From: Charles Brossollet <chbrosso@lltech.fr>
Subject: Error using git-remote-hg
Date: Mon, 12 May 2014 17:16:58 +0200
Message-ID: <ACDAFE7C-6615-4E44-AE6C-C12CD001EF4F@lltech.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 17:17:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjryV-0002I2-OP
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 17:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758575AbaELPRD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 11:17:03 -0400
Received: from mx0.network-studio.com ([62.93.225.99]:52443 "EHLO
	mx0.network-studio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaELPRB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 11:17:01 -0400
Received: from zimbra-ne02.network-studio.com (zimbra.network-studio.com [192.168.101.82])
	by mx0.network-studio.com (Postfix) with ESMTP id 824A84081F7
	for <git@vger.kernel.org>; Mon, 12 May 2014 17:17:00 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id 48558261568
	for <git@vger.kernel.org>; Mon, 12 May 2014 17:16:35 +0200 (CEST)
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id mmz123tglCmi for <git@vger.kernel.org>;
	Mon, 12 May 2014 17:16:29 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-ne02.network-studio.com (Postfix) with ESMTP id 27EE0261577
	for <git@vger.kernel.org>; Mon, 12 May 2014 17:16:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra-ne02.network-studio.com
Received: from zimbra-ne02.network-studio.com ([127.0.0.1])
	by localhost (zimbra-ne02.network-studio.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6TBqFBSFGP4U for <git@vger.kernel.org>;
	Mon, 12 May 2014 17:16:29 +0200 (CEST)
Received: from cluj.int.lltech.fr (95-141-98-68.as16211.net [95.141.98.68])
	(Authenticated sender: chbrosso@lltech.fr)
	by zimbra-ne02.network-studio.com (Postfix) with ESMTPSA id CE53626159C
	for <git@vger.kernel.org>; Mon, 12 May 2014 17:16:28 +0200 (CEST)
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248710>

Hello,

I have the following error while pushing to an hg repository though the=
 "remote translator":

$ git remote -v
origin	hg::ssh://charlesb05@hg.code.sf.net/u/charlesb05/lapdogapi (push=
)
origin	hg::ssh://charlesb05@hg.code.sf.net/u/charlesb05/lapdogapi (fetc=
h)

$ git push origin
Password:
searching for changes
no changes found
searching for changes
Traceback (most recent call last):
  File "/usr/local/bin/git-remote-hg", line 1254, in <module>
    sys.exit(main(sys.argv))
  File "/usr/local/bin/git-remote-hg", line 1238, in main
    do_export(parser)
  File "/usr/local/bin/git-remote-hg", line 1119, in do_export
    if not push(parser.repo, peer, parsed_refs, p_revs):
  File "/usr/local/bin/git-remote-hg", line 1007, in push
    ret =3D push_unsafe(repo, remote, parsed_refs, p_revs)
  File "/usr/local/bin/git-remote-hg", line 984, in push_unsafe
    cg =3D repo.getbundle('push', heads=3Dlist(p_revs), common=3Dcommon=
)
  File "/usr/local/lib/python2.7/site-packages/mercurial/repoview.py", =
line 217, in __getattr__
    return getattr(self._unfilteredrepo, attr)
AttributeError: 'localrepository' object has no attribute 'getbundle'

I'm using git 1.9.3 on Mac OS X 10.9.2, with hg 3.0 installed with brew=
=2E

It used to work before, on this same repository, since then git and hg =
were both upgraded.

Thanks for help,
=97-=20
Charles
