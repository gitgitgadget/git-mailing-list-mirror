From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 2/4] completion: simplify __git_remotes
Date: Mon, 6 Feb 2012 23:04:29 +0200
Message-ID: <CAMP44s2vwQK4Mp=qJN-_60NRBY42fxzFLHbh9e9j=vL5mrMryg@mail.gmail.com>
References: <1328214625-3576-1-git-send-email-felipe.contreras@gmail.com>
	<1328214625-3576-3-git-send-email-felipe.contreras@gmail.com>
	<20120206205315.GI16099@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Todd Zullinger <tmz@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 06 22:04:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVjn-0005Q0-SA
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 22:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab2BFVEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 16:04:31 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:62804 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256Ab2BFVEa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 16:04:30 -0500
Received: by lbom4 with SMTP id m4so1242265lbo.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 13:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r+2lJabY5t0LvkTigHVGwAMPi4TeO+9LkvqaaZmZ9Fc=;
        b=NSiACRprRhK/C/NB8du84UKXTH9Ic6tiL6YenMpc6xs+AuyclPpK0dbTgmDX9l6BjY
         aw8lAxqvhOzadYS2r61malFNEpyHaTRxCEm1qLCTo6qS5cwThrnrWqZnM9EH5YKZPfyI
         xTQB1Tu1zXN98UhvnmjKh1tZIWX0nDevUw2VM=
Received: by 10.112.32.1 with SMTP id e1mr5497741lbi.3.1328562269468; Mon, 06
 Feb 2012 13:04:29 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Mon, 6 Feb 2012 13:04:29 -0800 (PST)
In-Reply-To: <20120206205315.GI16099@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190102>

2012/2/6 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Thu, Feb 02, 2012 at 10:30:23PM +0200, Felipe Contreras wrote:
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index b435b6d..f86b734 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -644,12 +644,7 @@ __git_refs_remotes ()
>> =C2=A0__git_remotes ()
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 local i ngoff IFS=3D$'\n' d=3D"$(__gitdir)"
>
> You could also remove the ngoff variable, because with this patch it'=
s
> not used anymore.

Right, I thought I did that... The change must have been lost in one
of the many revisions =3D/

--=20
=46elipe Contreras
