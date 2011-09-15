From: David Michael Barr <davidbarr@google.com>
Subject: Fwd: vcs-svn and friends
Date: Thu, 15 Sep 2011 11:53:53 +1000
Message-ID: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 03:54:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R419O-0005aN-UW
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 03:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab1IOBx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 21:53:58 -0400
Received: from smtp-out.google.com ([216.239.44.51]:59576 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab1IOBx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 21:53:57 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p8F1ruH9013177
	for <git@vger.kernel.org>; Wed, 14 Sep 2011 18:53:56 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1316051636; bh=+ZxHPzZZbVHOrmg09gasdZPs868=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Cc:Content-Type;
	b=THAO8fuhTMYl9QjTgLxNwQEK6E8NQDd8Ruszpk4iptRLGClNv24tqak8JcFPA5KxA
	 y/At9aIdma/JKdsXodaQA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=dkim-signature:mime-version:date:message-id:subject:from:to:cc:
	content-type:x-system-of-record;
	b=Q7km3lE6BXoT6wa3OGA77JzkwfxnOlCfO0zog7BXgsDm4G9acoLRVHe7fqWnqJ7fN
	W8UzwzTBhUJ6k5KWV3ylw==
Received: from qyk33 (qyk33.prod.google.com [10.241.83.161])
	by hpaq1.eem.corp.google.com with ESMTP id p8F1rsu0031747
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 14 Sep 2011 18:53:55 -0700
Received: by qyk33 with SMTP id 33so2226796qyk.10
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=yUwuDc3+gcD/jhpLAA4K2z6nyG1rELBcJb8bqPN5EnM=;
        b=l1gpIE3/qbCRxblyK5A/xOxPO82YrotnzlkvsiR/fRJuzmW3cbw3kNnciFlgU+egb/
         wd3LeU6v0Vx9iOiKKm0g==
Received: by 10.229.68.87 with SMTP id u23mr471406qci.8.1316051633606;
        Wed, 14 Sep 2011 18:53:53 -0700 (PDT)
Received: by 10.229.68.87 with SMTP id u23mr471397qci.8.1316051633283; Wed, 14
 Sep 2011 18:53:53 -0700 (PDT)
Received: by 10.229.8.13 with HTTP; Wed, 14 Sep 2011 18:53:53 -0700 (PDT)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181420>

Hi,

Thanks to the work of Dmitry, we now have a simple front-end
that exercises the yet unmerged changes to vcs-svn that Jonathan
and I authored a few months ago. I think there's still some work
to be done before we can bless an integrated branch for inclusion.
I'd like to bring attention to just how far we have diverged; see the
email below.

--
David Barr

---------- Forwarded message ----------
From: David Michael Barr <davidbarr@google.com>
Date: Thu, Sep 15, 2011 at 11:37 AM
Subject: Re: vcs-svn and friends
To: Dmitry Ivankov <divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>


We now have 56 interesting commits pending:

vcs-svn: add fast_export_note to create notes
vcs-svn,svn-fe: add --incremental option
vcs-svn,svn-fe: allow to disable 'progress' lines
vcs-svn,svn-fe: convert REPORT_FILENO to an option
vcs-svn,svn-fe: allow to specify dump destination ref
vcs-svn: move commit parameters logic to svndump.c
vcs-svn: make svndump_init parameters a struct
svn-fe,test-svn-fe: use parse-options
fast-import: allow top directory as an argument for some commands
fast-import: be saner with temporary trees
svn-fe: reuse import-marks in remote-svn-alpha
svn-fe: import incrementally in svn-remote-alpha
svn-fe: write svnrev notes in remote-svn-alpha
svn-fe: use proper refspec in remote-svn-alpha
svn-fe: use svn-fe --no-progress in remote-svn-alpha
svn-fe: add a test for remote-svn-alpha
svn-fe: allow svnadmin instead of svnrdump in remote-svn-alpha
svn-fe: avoid error on no-op imports in remote-svn-alpha
svn-fe: add man target to Makefile
svn-fe: use svnrdump --quiet in remote-svn-alpha
vcs-svn: reset first_commit_done in fast_export_init
svn-fe: use tabs to indent in remote helper script
svn-fe: do not rely on /bin/env utility to launch remote helper
Add alpha version of remote-svn helper
Arrange a backflow pipe from fast-importer to remote helper stdin
vcs-svn: do not initialize report_buffer twice
vcs-svn: avoid hangs from corrupt deltas
vcs-svn: guard against overflow when computing preimage length
vcs-svn: cap number of bytes read from sliding view
test-svn-fe: split off "test-svn-fe -d" into a separate function
vcs-svn: implement text-delta handling
vcs-svn: let deltas use data from preimage
vcs-svn: let deltas use data from postimage
vcs-svn: verify that deltas consume all inline data
vcs-svn: implement copyfrom_data delta instruction
vcs-svn: read instructions from deltas
vcs-svn: read inline data from deltas
vcs-svn: read the preimage when applying deltas
vcs-svn: parse svndiff0 window header
vcs-svn: skeleton of an svn delta parser
vcs-svn: make buffer_read_binary API more convenient
vcs-svn: learn to maintain a sliding view of a file
Makefile: list one vcs-svn/xdiff object or header per line
vcs-svn: avoid using ls command twice
vcs-svn: drop obj_pool
vcs-svn: drop treap
vcs-svn: drop string_pool
vcs-svn: pass paths through to fast-import
vcs-svn: use mark from previous import for parent commit
vcs-svn: handle filenames with dq correctly
vcs-svn: quote paths correctly for ls command
vcs-svn: eliminate repo_tree structure
vcs-svn: add a comment before each commit
vcs-svn: save marks for imported commits
vcs-svn: use higher mark numbers for blobs
vcs-svn: set up channel to read fast-import cat-blob response

There are a lot of svn-fe tests failing on my integration branch.
One upside is that gph/master..db/svn-fe-pu only contains
relevant commits. I think a little more polish is needed before
we can suggest a pull to jch. In particular, I think we should
include remote-svn-alpha and the test should work out of the
box.

--
David Barr
