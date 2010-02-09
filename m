From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: error: packfile size changed
Date: Tue, 9 Feb 2010 15:15:20 +0100
Message-ID: <40aa078e1002090615m3fb94fc5k89d968eebe2c137a@mail.gmail.com>
References: <40aa078e1002080917s1c23580bo815de0c1afa4922@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 15:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeqsC-0000dL-7o
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 15:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab0BIOPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 09:15:23 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:42987 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451Ab0BIOPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 09:15:22 -0500
Received: by ewy28 with SMTP id 28so3833513ewy.28
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Y0JXAV4sKIeehF+mhZbyGRI2J+MWAd9rjfyJxATTQ1I=;
        b=PbDTjeMo8fbCkdHnK6x2vNe9PgvMc03wsB/fkong9zTjYF4yfnX2j1/njr0BHQMAdG
         MbLMPVPHrRxtpr/2c/s6GC6BKQdwQ4/97ZGE25gIGGKRq56QxglgFSQRjbqwSuW+OT/2
         J7rBETOODuiTa9LppzHZohuECJ8MDLppq2YPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=uI+5U2SMANgSjTwa7WtAAEtcIJFTJweCKBTgSLr1INw7hDk6YwCTCty7vNgQGGULVx
         Iq9YY27bmmm5D3PuzVE7NNYrAq/+jzg6eQZ3za3sAfDoBoIFQUkn2a9JU/m/cyt+hzz2
         g+gQU3EDjV+RIxAqaba5VUc1wTu5KCNvc6I0Y=
Received: by 10.216.87.67 with SMTP id x45mr1501360wee.18.1265724920242; Tue, 
	09 Feb 2010 06:15:20 -0800 (PST)
In-Reply-To: <40aa078e1002080917s1c23580bo815de0c1afa4922@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139404>

On Mon, Feb 8, 2010 at 6:17 PM, Erik Faye-Lund <kusmabite@googlemail.co=
m> wrote:
> I was just about to push out a branch to a remote repo, and got a
> quite worrying error message:
>
> $ git push kusma work/git-svn-autocrlf
> Counting objects: 3475, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (1132/1132), done.
> Writing objects: 100% (2503/2503), 933.82 KiB, done.
> Total 2503 (delta 1909), reused 1927 (delta 1362)
> error: packfile
> ./objects/pack/pack-165dacbd05ac0aa1634eb220f2b6d3be05b2bd3c.pack siz=
e
> changed
> error: packfile
> ./objects/pack/pack-165dacbd05ac0aa1634eb220f2b6d3be05b2bd3c.pack
> cannot be accessed
> error: unpack should have generated
> 83d114b6781e06b422a2062854dd3dede3795079, but I can't find it!
> To ssh://kusma@repo.or.cz/srv/git/git/kusma.git
> =A0! [remote rejected] work/git-svn-autocrlf -> work/git-svn-autocrlf=
 (bad pack)
> error: failed to push some refs to
> 'ssh://kusma@repo.or.cz/srv/git/git/kusma.git'
>
> The push was attempted with git v1.7.0.rc2. It fails with v1.6.6.1
> (and msysgit's devel-branch, 1.6.5.1.1375.gc836) as well.
>
> I tried running "git fsck --full", but it didn't report anything apar=
t
> from dangling objects.
>
> Any ideas, anyone?
>

I tried doing the same again today, and it worked just fine. Perhaps
it was just some glitch at the other end?

--=20
Erik "kusma" Faye-Lund
