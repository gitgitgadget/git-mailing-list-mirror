From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: git-svn taking a long time
Date: Wed, 10 Feb 2010 13:41:12 +0100
Message-ID: <87hbppp8k7.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 10 13:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfBse-00006W-Gr
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 13:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab0BJMlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 07:41:14 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:60282 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0BJMlO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 07:41:14 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 60B3C40049;
	Wed, 10 Feb 2010 13:39:27 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 5074B4004B; Wed, 10 Feb 2010 13:39:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 10F9340049;
	Wed, 10 Feb 2010 13:39:27 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 4BADB60F70; Wed, 10 Feb 2010 13:41:12 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139508>

I compiled the perl bindings from subversion 1.6.x, and git git version
1.7.0.rc0.52.g64ba.

I have imported a largish svn repo using "git svn fetch", which takes
quite a long time (at least a day).

But my problems is that if I rerun "git svn fetch" again right after
fetching, it will chew for hours before figuring out there are just a
few new revisions to import. And the same if I try again.

I have another import from the same repo (on another machine, using
slightly different versions of stuff) that doesn't have this problem.

So, does anyone have any suggestions for what could be done about this?

This is what the entry i .git/config looks like (url edited to protect
the innocent)

[svn-remote "svn"]
        url =3D svn://svn.server
        branches =3D foo/branches/*:refs/remotes/svn/*
        tags =3D foo/tags/*:refs/remotes/svn/tags/*

--=20
David K=C3=A5gedal
