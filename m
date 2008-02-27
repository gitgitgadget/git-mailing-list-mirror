From: <Ken.Fuchs@bench.com>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Date: Wed, 27 Feb 2008 17:43:01 -0600
Message-ID: <AA28F077645B324881335614E4F7C428034C0A@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:44:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVwR-00057J-Fd
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbYB0XnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbYB0XnG
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:43:06 -0500
Received: from tx-smtp01.bench.com ([12.163.172.137]:14992 "EHLO
	tx-smtp01.bench.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761362AbYB0XnD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 18:43:03 -0500
Received: from unknown (HELO smtp.corp.bench.com) ([167.67.199.67])
  by tx-smtp01.bench.com with ESMTP; 27 Feb 2008 17:45:21 -0600
Received: from win-ex01.bench.com ([167.67.1.16]) by smtp.corp.bench.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 27 Feb 2008 17:43:02 -0600
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FW: git via http protocol _and_ a proxy using NTLM authentication -- git 1.5.4.2 & curl 7.18.0
Thread-Index: Ach5k4cIFePPj5NsQ8mFpSgI5Fi/QQAAt3Kg
X-OriginalArrivalTime: 27 Feb 2008 23:43:02.0441 (UTC) FILETIME=[7DE91190:01C8799A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75324>

> > $ GIT_CURL_VERBOSE=1 git clone \
> >   http://www.kernel.org/pub/scm/git/git.git
> > Initialized empty Git repository in /mnt/s2u1/git/test-git/git/.git/
> > Cannot get remote repository information.
> > Perhaps git-update-server-info needs to be run there?
> > $
 
> git-clone is not a builtin yet. When it is (and a patch has come for
> that), it will correctly use proxys.

Is there a work-around for cloning a git repository via a proxy?

Worse case, it should be possible to clone a repository on a
machine that doesn't require a proxy.  Convert the repository
into a tarball, copy it to the machine that requires a proxy
and change the config to work with the proxy, right?  At this
point, the git fetch command should work with the proxy, since
the local repository now has the required refs, right?

Thanks,

Ken Fuchs
