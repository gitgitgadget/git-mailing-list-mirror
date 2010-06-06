From: Mike Solomon <mikesol@UFL.EDU>
Subject: Moving a branch to a different node
Date: Sun, 06 Jun 2010 23:01:31 +0200
Message-ID: <C831D94B.1D9DF%mikesol@ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:01:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLNuX-0006CH-SJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab0FFWBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:01:37 -0400
Received: from smtp04.osg.ufl.edu ([128.227.74.71]:33480 "EHLO smtp.ufl.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754396Ab0FFWBg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:01:36 -0400
X-Greylist: delayed 3907 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Jun 2010 18:01:36 EDT
Received: from [10.101.0.156] (nsc.ciup.fr [193.52.24.125])
	(authenticated bits=0)
	by smtp.ufl.edu (8.14.0/8.14.0/3.0.0) with ESMTP id o56KuPBu006112
	for <git@vger.kernel.org>; Sun, 6 Jun 2010 16:56:26 -0400
User-Agent: Microsoft-Entourage/11.4.0.080122
Thread-Topic: Moving a branch to a different node
Thread-Index: AcsFu3A5ruBmSXGuEd+kFAARJHM+bg==
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2010-06-06_01:2010-02-06,2010-06-06,2010-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-1005130000 definitions=main-1006060160
X-Spam-Level: *
X-UFL-Spam-Level: *
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148548>

Hey git users,
    I am working on a project where I proceeded by the following steps:

starting from master...
1) create branch foo
2) work in foo, make some commits, then a patch named Foo
3) create a branch bar while in foo
4) work in bar, make some commits, then a patch named Bar

git show-branch gives me

! [master] Hello
 * [foo] Foo
  ! [bar] Bar

I would like to make bar split off of master instead of foo so that I can
format a patch that can be applied to master (Bar) without having to first
apply Foo.  Is there a way to do that?

Thank you!
~Mike
