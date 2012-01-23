From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: What does "modified" in git status mean?
Date: Mon, 23 Jan 2012 15:07:32 -0500
Message-ID: <4F1DBE04.6040200@ubuntu.com>
References: <loom.20120122T174204-274@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mikolas <mikolas.janota@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 21:07:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpQB1-0004Wg-VO
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 21:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2AWUHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 15:07:35 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:18204 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850Ab2AWUHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 15:07:34 -0500
X-Authority-Analysis: v=2.0 cv=TqVkdUrh c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=seg9fo12g4kA:10 a=nSowTIaEBBsA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=xe8BsctaAAAA:8 a=eyDZpEM8Fhr-82dOU2QA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:53175] helo=[10.1.1.230])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 31/76-20593-40EBD1F4; Mon, 23 Jan 2012 20:07:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <loom.20120122T174204-274@post.gmane.org>
X-Enigmail-Version: 1.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189009>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/22/2012 11:57 AM, Mikolas wrote:
> I am using git version 1.7.5.1 under cygwin and I'm getting
> behavior that I'm not understanding.
> 
> When I do 'git status' in the root directory of the repository, it
> shows no difference. Once I cd to a subdirectory, it starts showing
> modifications. However, 'git diff' shows nothing.
> 
> So it looks something like this: $ git status # On branch master 
> nothing to commit (working directory clean)
> 
> $ cd foo $ git status # On branch master # Changes not staged for
> commit: #   (use "git add <file>..." to update what will be
> committed) #   (use "git checkout -- <file>..." to discard changes
> in working directory) # #       modified:   ../foo/bar
> 
> $ git diff $
> 
> I put the following in my gitconfig but that doesn't seem to be
> doing much. [core] trustctime = false autocrlf = input

autocrlf is basically broken, don't use it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPHb4EAAoJEJrBOlT6nu75NmsIALPYuRTdGPLigxmiAWfH4e/i
d516AR8AgkWtJzK3TbaD2HxgnQK9dmWYysppT7WR2SetrBrpsEUvQnw0b3jUewkb
lL97cEcDfiYbKXnkpfHRtAawUIXhrQeT/8XpOrvc7d8wPCWt4Zd7hrLo3TTuBGmN
tQcJtUqPwxreUYWOR5dPMV3oaeclptavEoeGc+2BlTiAuti6aw89G7lRvgVZQDGr
y0uCL4QIyOuMU9xUaeiFm/pCqY5MWSTs6Nv3mnAiw6PwK+aR1OcUkJjRw6dM6xWY
7futPNLEph8fptltaLhzMoeSzct3vNd+Al7synmOTh8bGitJeyaiCZOR55CG/eY=
=i8Zy
-----END PGP SIGNATURE-----
