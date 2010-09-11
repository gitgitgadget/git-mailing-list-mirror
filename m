From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] vcs-svn: Fix some printf format compiler warnings
Date: Sat, 11 Sep 2010 23:42:56 +0300
Message-ID: <AANLkTi=hhM64Jiph4ERzujyHgEo5C0vjc1oPhdpyxyUD@mail.gmail.com>
References: <4C891836.6070608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, artagnon@gmail.com,
	David Barr <david.barr@cordelta.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Sep 11 22:43:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuWud-00038t-IY
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 22:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab0IKUm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 16:42:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44611 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab0IKUm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 16:42:57 -0400
Received: by iwn5 with SMTP id 5so3545197iwn.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=/nyCxdDqqlzOstVPmGqqw5ulFoe1MspvXdSByczsmjs=;
        b=Q1V84YwR3PBVw7F6Q2hPQbHa9hfdjO6Dx+AOoHgsxyO9Nwz/wYvaXbcuWYlTboVYUC
         z939jexw+27Oqog2iVU0zG+As99r+CuhfBNF/aHEntRtHyaHBnhv1YXtJziR7jJbFxTh
         d2OBR8T2jirm4ei/ahfIPtksY9LOxHN7ulMDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=O6Gj//JugmlUmlBBByUe4LTqqiKelfSicvQLobghWDHa3MtpgBjJphPu6fW7ahfwVu
         XNwLmclDF0F6k+a2FMs6DNWbduc4L7FcvbU9cF2dagDj+T5SAMLMK7MDGy9+S7Qnc4Y+
         FgrgfA6ylpI8LTsDPlP8XzGpUCEd2+rC+KXU4=
Received: by 10.231.191.6 with SMTP id dk6mr3389779ibb.51.1284237776776; Sat,
 11 Sep 2010 13:42:56 -0700 (PDT)
Received: by 10.231.14.76 with HTTP; Sat, 11 Sep 2010 13:42:56 -0700 (PDT)
In-Reply-To: <4C891836.6070608@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156012>

Ramsay Jones wrote:

> In order to suppress the warnings we use the C99 format specifier
> macros PRIo32 and PRIu32 from <inttypes.h>.

Thanks.

> The addition to git-compat-util.h is required in order to not break
> the build on both MinGW and MSVC

Yep, looks sane. So for what it's worth:

 Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I see that David has already applied this to the svn-da tree, but it
would be good to have the fix in git, too.
