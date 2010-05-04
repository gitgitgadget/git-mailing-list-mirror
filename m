From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: While the awesome switch is always on, so is the confusion 
	switch.
Date: Tue, 4 May 2010 17:24:34 +0100
Message-ID: <z2m57518fd11005040924oa4e609d3g9e7cc57c6fb52992@mail.gmail.com>
References: <28447763.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: xuinkrbin <nabble.20.xuinkrbin@spamgourmet.com>
X-From: git-owner@vger.kernel.org Tue May 04 19:06:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9LZl-0003u7-Cz
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 19:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760008Ab0EDRGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 13:06:06 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:44018 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760005Ab0EDRGB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 13:06:01 -0400
X-Greylist: delayed 2445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 13:05:58 EDT
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52284)
	by juliet.asmallorange.com with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.69)
	(envelope-from <maillist@steelskies.com>)
	id 1O9Kvc-0005QW-He
	for git@vger.kernel.org; Tue, 04 May 2010 12:25:00 -0400
Received: by wye20 with SMTP id 20so2506952wye.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:24:54 -0700 (PDT)
Received: by 10.216.90.3 with SMTP id d3mr1277136wef.110.1272990294249; Tue, 
	04 May 2010 09:24:54 -0700 (PDT)
Received: by 10.216.173.198 with HTTP; Tue, 4 May 2010 09:24:34 -0700 (PDT)
In-Reply-To: <28447763.post@talk.nabble.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146330>

On 4 May 2010 17:18, xuinkrbin <nabble.20.xuinkrbin@spamgourmet.com> wr=
ote:
>
> Hi, All!
>
> So, here's the situation. =C2=A0I start with no modifications to HEAD=
 and no
> stashes. =C2=A0I verify the lack of stashes with a 'git stash list'. =
=C2=A0I make some
> changes so I now have modifications to HEAD and, still, no stashes. =C2=
=A0I
> verify the lack of stashes with a 'git stash list'. =C2=A0I run 'git =
stash' so I
> now have no modifications to but a stash. =C2=A0I verify the presence=
 of a stash
> with a 'git stash list'. =C2=A0I run 'git stash pop' so I now have mo=
difications
> to head but no stashes. =C2=A0I run 'git stash list' to verify the la=
ck of
> stashes and receive the following message:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fatal: bad object refs/stash
> If I delete .git/refs/stash and repeat the process, I find the same r=
esults.
> The contents of .git/refs/stash are also embedded within
> .git/logs/refs/stash, if that fact means anything. =C2=A0Can Anyone p=
oint Me in
> the direction of documentation on this particular problem to help cle=
ar up
> why this is happening and which might help Me to determine what I sho=
uld do
> about it?
>

I can't reproduce this - what does 'git --version' say?
