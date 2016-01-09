From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: How do I get the contents of a directory in fast-import
Date: Sat, 09 Jan 2016 18:56:49 -0500
Message-ID: <jwvegdqb946.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvio3d7152.fsf-monnier+gmane.comp.version-control.git.user@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 00:57:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aI3O5-0000Ta-Tc
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jan 2016 00:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbcAIX47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 18:56:59 -0500
Received: from plane.gmane.org ([80.91.229.3]:56000 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368AbcAIX46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2016 18:56:58 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aI3NO-0008Oh-MA
	for git@vger.kernel.org; Sun, 10 Jan 2016 00:56:54 +0100
Received: from 184-175-3-20.dsl.teksavvy.com ([184.175.3.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 00:56:54 +0100
Received: from monnier by 184-175-3-20.dsl.teksavvy.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Jan 2016 00:56:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 184-175-3-20.dsl.teksavvy.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:+9pWZpP4e8ukoVXaJ0K+kqUfbAM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283608>

Any help would be greatly welcome, including "sorry, can't do that".


        Stefan


>>>>> "Stefan" == Stefan Monnier <monnier@iro.umontreal.ca> writes:

> I have a program which tries to collect info from lots of branches and
> generate some table from that data into another branch.

> For performance reasons, I'd like to do that from fast-import, and as
> long as I know the name of all the files I need to consult, everything
> is fine since I can use the "ls" and "cat-blob" commands of fast-import
> to get efficiently the data I need.

> But I also need to look at some files whose names I don't know beforehand
> (i.e. all the files in some directories).  If I do "cat-blob" on those
> directories I get some binary "thing" which I don't understand.

> So how do I get a directory listing from fast-inmport, i.e.
> like I can get with "git cat-file -p", but without having to fork
> a separate git process?


>         Stefan
