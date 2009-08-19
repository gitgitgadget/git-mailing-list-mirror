From: Changsheng Jiang <jiangzuoyan@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 10:24:46 +0800
Message-ID: <eafc0afe0908181924x60e5dd23vd37711db880ead84@mail.gmail.com>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Rob (gmail)" <robvanb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 04:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdarV-0008Bc-4g
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 04:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbZHSCZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Aug 2009 22:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbZHSCZH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 22:25:07 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:46744 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZHSCZG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Aug 2009 22:25:06 -0400
Received: by vws2 with SMTP id 2so3501175vws.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 19:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gUEreKu3Khy7TzbmyTu1ijDxP0Wecj0itsW2ktP/Drg=;
        b=GwGkaI0pqeKIsIhJ4yCNAsKzVUFJ/yEuMrJVqppk3SDgmdQYGuvylPTndzrAiYooFJ
         pv/X5iFMKnd1wWWUzy0EqItibiOeORfp8zA+/GL3rSOQp+t9T/p33TqFrKgVrzGnGmfP
         S3VljTMIE2ad+cpvrLfXuJSk6HGKiD1TTqZJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LD+ADEiE2wxWJ6asTentJxX+Xgz1wQgXFALSD+YEv+LPBjZ/ty+FNdlwmuqyg4FeCm
         QwZUPG3aT1UQIH2f81XU5hh+lf7KkBNd3YNMEpU+3GyjJHhT1p+FLTcBE7X3T/dsdvy6
         gX+qioRCAHLMt6NmlR/bOuge2h+C9TXJGVQNA=
Received: by 10.220.15.134 with SMTP id k6mr8097680vca.91.1250648706455; Tue, 
	18 Aug 2009 19:25:06 -0700 (PDT)
In-Reply-To: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126497>

I am not that familiar with git too, but see the answers below
questions, respectively, and fix me if i am wrong.

On Wed, Aug 19, 2009 at 09:52, Rob (gmail) <robvanb@gmail.com> wrote:
>
> I'm new to git and have some (I think) basic questions that I have no=
t
> been able to find answers to in the documentation.
> It's very possible that these are the result of my lack in
> understanding git / version control, so feel free to point me to
> documentation
> that might contain the answers.
>
> I'm doing ERP development for my job and various 'hobby' development
> in my spare time.
> I'd like to track/store/ version control the code that I write for
> both work and play.
> I am (currently) working by myself, no need to have multiple
> developers working of the same code.
>
> Q1:
> Can I create a single repository (project?) for all my code, knowing
> that there are multiple small, unrelated projects. Or should I create
> a new repository for each project ?
git-submodule
>
> Q2:
> After initalizing my repository, and comitting the 1st batch of code:
> When further working on the code, will the command "git add ." add al=
l
> changed and new files ? Or do I specifically need to list the new
> files ?
=3Dgit status=3D or =3Dgit ls-files=3D will list the files in different=
 statuses.

If there are no other files, such as backup file produced by editor,
you can run =3Dgit add .=3D. If there are, try to configure in file
=3D.git/info/exclude=3D or =3D.gitignore=3D.

Changed files can be committed automatically by =3Dgit commit -a=3D
>
> Q3: Can I run 'git add x' in any subdirectory, or do I need to issue
> if from the root of the project ?
You can.
>
> Thanks,
>
> Rob.
>
> --
> When in trouble or in doubt, run in circles, scream and shout
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Changsheng Jiang
