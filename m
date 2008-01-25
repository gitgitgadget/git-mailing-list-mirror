From: Chris Mason <chris.mason@oracle.com>
Subject: Re: [Btrfs-devel] btrfs and git-reflog
Date: Fri, 25 Jan 2008 10:01:23 -0500
Message-ID: <200801251001.23462.chris.mason@oracle.com>
References: <873asmcodd.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Collins <paul@burly.ondioline.org>, git@vger.kernel.org
To: btrfs-devel@oss.oracle.com
X-From: git-owner@vger.kernel.org Fri Jan 25 16:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIQ51-0004ej-88
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 16:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874AbYAYPCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 10:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbYAYPCN
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 10:02:13 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64062 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbYAYPCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 10:02:12 -0500
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id m0PF271O017523;
	Fri, 25 Jan 2008 09:02:07 -0600
Received: from acsmt353.oracle.com (acsmt353.oracle.com [141.146.40.153])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id m0PEHmn3000579;
	Fri, 25 Jan 2008 08:02:06 -0700
Received: from cpe-72-225-43-119.rochester.res.rr.com by acsmt359.oracle.com
	with ESMTP id 7015875011201273293; Fri, 25 Jan 2008 09:01:33 -0600
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <873asmcodd.fsf@burly.wgtn.ondioline.org>
Content-Disposition: inline
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71712>

On Friday 25 January 2008, Paul Collins wrote:
> I was just playing with git 1.5.3.8 and btrfs 0.11, and I noticed
> something odd.
>
> If I prepare a very simple repository:
>
>   $ mkdir foo
>   $ cd foo
>   $ git init
>   Initialized empty Git repository in .git/
>   $ echo hi > blort
>   $ git add .
>   $ git commit -m create
>   Created initial commit 4ae9415: create
>    1 files changed, 1 insertions(+), 0 deletions(-)
>    create mode 100644 blort
>
> and then attempt to expire the reflogs
>
>   $ git-reflog --expire --all
>
> on ext3, git-reflog completes its work and exits immediately;

Strange, but I can reproduce here.  I'll take a look, thanks for this report.

-chris
