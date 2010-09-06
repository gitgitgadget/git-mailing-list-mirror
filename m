From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Should git-citool be in mainporcelain in command-list?
Date: Mon, 6 Sep 2010 22:17:05 +0000
Message-ID: <AANLkTiknz1vmXj+jOHudyW1QQkZhy+EgMG7_56_50GT6@mail.gmail.com>
References: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
	<20100906213937.GF26371@burratino>
	<AANLkTimRoAgAtrkpyd08mVG93prQ40B1y=ReLRdNfbWt@mail.gmail.com>
	<20100906220757.GH26371@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:17:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osk01-0007A9-Nc
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937Ab0IFWRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:17:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54553 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab0IFWRG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:17:06 -0400
Received: by iwn5 with SMTP id 5so4652073iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YjEmTDpGC/vmCyw+PmXsZVwJgQJ98AKrasjnHCaE/dA=;
        b=I5TIuDsQ0C9KIDamfgvTPPvl5++aKP6vkljKyGYnIZQLm6IkYRyJmySkxgoex98JZa
         MRdrTxBKB/BNIZxxHhiSmS8edxoxYohpU4Uk7SxpOvQN/k9yqa+blgVb3RgHLqAtj3ZW
         YLbFpOWv82huLxrRYzyFDkoz2B8SG7AwWnU14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Z5TLbjO6GAwvopWkWLbI9QutohUzLOZ9imcWJ6pXTxMvbC7ZQdKbsP10/EgriN3CK0
         YDg6jx6aLXTHkhfkAozQhzzrjZT6ps1Dwz74rFxEXLx/kN8wnesbSa+W3apC2ooPXO9C
         LcxAuu52Ijt0I03Dj6zqAei69I6+KTSDnXdNY=
Received: by 10.231.33.129 with SMTP id h1mr75065ibd.140.1283811425366; Mon,
 06 Sep 2010 15:17:05 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 15:17:05 -0700 (PDT)
In-Reply-To: <20100906220757.GH26371@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155633>

On Mon, Sep 6, 2010 at 22:07, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> The entries in git(1) don't indicate that citool is a convenience
>> alias for git-gui:
>
> That's because it isn't, no?

I mean "convenience" interchangeably with "standard" as this paragraph
uses it:

> =C2=A0 =C2=A0 =C2=A0 git citool is actually a standard alias for git =
gui
> =C2=A0 =C2=A0 =C2=A0 citool. See git-gui(1) for more details.

I.e. `git gui citool` and `git citool` launch the same thing, the
latter is just a shorter way to do it.
