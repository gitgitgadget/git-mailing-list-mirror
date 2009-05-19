From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: Re: committing to a checked out branch
Date: Tue, 19 May 2009 10:09:05 -0500
Message-ID: <bbd12f0f0905190809k3dc13c3ak170535a5c0eed9b9@mail.gmail.com>
References: <bbd12f0f0905181733h6a9537d2hf4e6b7a1384fa32d@mail.gmail.com>
	 <76718490905181917u1f41e06dq9cf527a1dac9bea5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 17:09:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6QwQ-0004Tr-MI
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 17:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbZESPJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 11:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbZESPJH
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 11:09:07 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:49762 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbZESPJG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 11:09:06 -0400
Received: by bwz22 with SMTP id 22so3888964bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 08:09:06 -0700 (PDT)
Received: by 10.204.69.133 with SMTP id z5mr129111bki.163.1242745745797; Tue, 
	19 May 2009 08:09:05 -0700 (PDT)
In-Reply-To: <76718490905181917u1f41e06dq9cf527a1dac9bea5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119536>

On Mon, May 18, 2009 at 9:17 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> On Mon, May 18, 2009 at 8:33 PM, Jeff Brown <jeff@jeffandbetsy.net> w=
rote:
>> The workspace on my server is currently "checked out" so I get the b=
ig
>> warning message every time I push to there. =A0What is the best way =
to
>> cleanup that working area so I can push to it without the large
>> warning every time I commit. =A0I know I can set a config variable t=
o
>> squelch the message but that isn't what I want to do. =A0I want to m=
ake
>> the workspace on the server _not_ be checked out.
>>
>> Thanks for the help.
>
> If you never want to checkout any branches in that repo on your
> server, then what you want is a bare repository. The easiest way to
> create it is as follows:
>
> $ git clone --bare /path/to/repo /path/to/repo.git
>
> Then you can remove /path/to/repo after verifying everything is sane.
> Note the ".git" extension is a convention denoting the repository is
> bare (vs "repo/.git", which implies a repository with a working copy)=
=2E
>
> j.
>

Very good.  That appears to have worked nicely.  I appreciate the help.

When I create a new repo on my server I have been creating an empty
directory, then git init, then git add some file and commit.  I expect
that is the long/wrong way to initialize a repo, especially if I want
it to be bare.  What is the best approach to creating a cloneable bare
repo?



jb

--=20
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
=46ind The Cause ~ Find The Cure
http://www.autismspeaks.org/
