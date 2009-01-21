From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 17:41:34 +0200
Message-ID: <e29894ca0901210741i14bb2c44uc8222e426c987fc2@mail.gmail.com>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com>
	 <49773240.7090605@drmicha.warpmail.net>
	 <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com>
	 <49773E48.90302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 16:43:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfEL-0007ow-DE
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 16:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbZAUPli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Jan 2009 10:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbZAUPlh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 10:41:37 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:29132 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZAUPlg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 10:41:36 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1820411fgg.17
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 07:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c3/cU0MFAcARwvualA+vytCuRcnAyhoq6pVRFwB+ASQ=;
        b=roJiubkDIy3wtK2xzFYSmWMPUZTJmKVWnyhqp6xr4je0t0rKLpPeVEyvgvJdDlhIL9
         VVen156NtvLRFSa2Hr9SeSHzSY4xeAt9/sIQ03TzCTJizpAPQi4sRp6TPR4W+BxdWrtt
         MoNlESaur7OuCptIIXkrooo06X78qz5b/781I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f+pfLe04Rfr3oVgsuooSv7AlmtAlsqnMYgO1AWSZxGkg37nWG1HYZye0ioSsYQTA38
         pRob2vdW16fTLjb6KOAxHWPESg5HxChll0zhXntT4asF7XKWh+0YPbiM7OJLUinp4JWv
         wB43vV4Mmf9iDWcGEkOERikAA8Aj3rFgU8Siw=
Received: by 10.86.100.19 with SMTP id x19mr2571341fgb.18.1232552494751; Wed, 
	21 Jan 2009 07:41:34 -0800 (PST)
In-Reply-To: <49773E48.90302@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106618>

Hi

On Wed, Jan 21, 2009 at 5:24 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> So, you get these errors on the local repo when dealing with the remo=
te
> repo, right? I guess this means two things:
>
> 1) You are deleting a remote branch
>
> 2) Your original report could have been a bit more detailed ;)
>
> In fact, I'm still unsure about your setup and can't reproduce, unles=
s
> "almost every git command" was vastly exaggerated, and Adeodato's
> description matches your setup. Does it?
>

It matches. Sorry if I didn't describe the problem correctly.

"almost every git command" might be exaggerated. Since I am using bash
and abusing completion, I get it in the middle of my shell, and it
confuses bash. I have to clear my terminal to continue writing my
command (C-l)

> If yes then git has basically no choice, unless you want git to leave
> HEAD in place as a detached head. This is related to how the symref i=
s
> resolved, which in turn is related to the issue of removing remote
> branches, which in turn is related to an issue I've been meaning to l=
ook
> into quite a while ago... So, reproducibility would be nice.

Not sure I follow, but I think Adeodato mail gives you a more detailed
test case to reproduce.

thanks,

--=20
Marc-Andr=E9 Lureau
