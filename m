From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: How do I get the contents of a directory in fast-import
Date: Fri, 01 Jan 2016 10:54:00 -0500
Message-ID: <jwvio3d7152.fsf-monnier+gmane.comp.version-control.git.user@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 01 16:54:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aF21v-0004H7-Hv
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jan 2016 16:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbcAAPyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2016 10:54:12 -0500
Received: from plane.gmane.org ([80.91.229.3]:51979 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbcAAPyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2016 10:54:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aF21p-00049h-77
	for git@vger.kernel.org; Fri, 01 Jan 2016 16:54:09 +0100
Received: from 181.47.69.49 ([181.47.69.49])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jan 2016 16:54:09 +0100
Received: from monnier by 181.47.69.49 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jan 2016 16:54:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 181.47.69.49
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:UoLk9kf1WGXXlVpaDx75E94OJBU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283257>

I have a program which tries to collect info from lots of branches and
generate some table from that data into another branch.

For performance reasons, I'd like to do that from fast-import, and as
long as I know the name of all the files I need to consult, everything
is fine since I can use the "ls" and "cat-blob" commands of fast-import
to get efficiently the data I need.

But I also need to look at some files whose names I don't know beforehand
(i.e. all the files in some directories).  If I do "cat-blob" on those
directories I get some binary "thing" which I don't understand.

So how do I get a directory listing from fast-inmport, i.e.
like I can get with "git cat-file -p", but without having to fork
a separate git process?


        Stefan
