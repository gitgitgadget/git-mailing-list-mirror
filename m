From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 20/20] gettextize: git-am printf(1) message to eval_gettext
Date: Tue, 7 Sep 2010 14:32:40 -0600
Message-ID: <AANLkTim1+BSZJt-LBkytXJvYujd8zhNeZCu29752P63G@mail.gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
	<1283878224-20202-1-git-send-email-avarab@gmail.com>
	<AANLkTim_ovWkPPepB7xRez5DTmJRTrFoZWG+Nx0_O=oL@mail.gmail.com>
	<AANLkTimDofOpfOrFisvP-1+qn1DYuk1oq2anjUcCHQw6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 22:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot4qY-0000Y6-R3
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 22:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236Ab0IGUcp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 16:32:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36361 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758067Ab0IGUcn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 16:32:43 -0400
Received: by iwn5 with SMTP id 5so5584883iwn.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CBUvoDTkJ2Jj4THfzmPkFhoQeyVNhuYSe8neKbUNF9A=;
        b=ARRTiG4eS9fzm87vTGnOG0jKjiOSDPuMhWGh0FkfojvXrHd/T4MQln0qHxjD6qHDu4
         xsOQknYzGjcxDylgFgtHPFMXS/wkDEjptbTLv5CCiWAY8nFH2gh7ED7JJQTfGZmoP0XY
         7DIBI5GBEIFomJN/DNEf0leWQoroIhNvBgUCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r4HkWr3aAMd/vyn1K4pXB6h8Ka3gYsrlceyLXe59SrSx9+l7/UEqHTTPZBaTW2KBIj
         HJbPwtnOfZofjBPuGB39ei7Lkm5U9tR2/qBqJCzZXHfZ1UNn+6yB0sLRtK2mSCyIHjSW
         yluVsdb60kJQ1qSOCHfZpjYpqa+vFClA+pmsg=
Received: by 10.231.12.139 with SMTP id x11mr8359062ibx.67.1283891560269; Tue,
 07 Sep 2010 13:32:40 -0700 (PDT)
Received: by 10.231.14.76 with HTTP; Tue, 7 Sep 2010 13:32:40 -0700 (PDT)
In-Reply-To: <AANLkTimDofOpfOrFisvP-1+qn1DYuk1oq2anjUcCHQw6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155741>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> In any case we could solve those with printf "%s" $str.

In general

 printf "%s\n" "$str"

is more reliable than

 echo "$str"

, yes.  See <http://www.opengroup.org/onlinepubs/9699919799/utilities/e=
cho.html>.
