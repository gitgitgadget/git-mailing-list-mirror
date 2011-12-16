From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: How to generate pull-request with info of signed tag
Date: Fri, 16 Dec 2011 12:05:16 +0530
Message-ID: <874nx1korf.fsf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 07:35:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbROJ-0001PR-3s
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 07:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab1LPGfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 01:35:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:45374 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab1LPGf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 01:35:29 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Thu, 15 Dec 2011 23:35:29 -0700
Received: from d03relay05.boulder.ibm.com (9.17.195.107)
	by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Thu, 15 Dec 2011 23:35:25 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id pBG6ZN5t014714
	for <git@vger.kernel.org>; Thu, 15 Dec 2011 23:35:23 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id pBG6ZMLO011104
	for <git@vger.kernel.org>; Thu, 15 Dec 2011 23:35:23 -0700
Received: from skywalker.linux.vnet.ibm.com ([9.124.95.8])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id pBG6ZHod010577;
	Thu, 15 Dec 2011 23:35:20 -0700
User-Agent: Notmuch/0.10+50~g65f6e2b (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
x-cbid: 11121606-7282-0000-0000-000004F490DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187262>


Hi,

I am using git from master branch and wanted to try the signed pull
request. I have pushed the signed tag to repo.or.cz, but not sure how to
generate pull request with signed tag information ? git-pull-request
insist on a branch on the server and put the branch details in the
pull-request text, It do add tag description but not the tag name and
still put "repo-name branch" name in the txt. Shouldn't that be
"repo-name tag-name" so that one can cut-paste that in pull request ?

-aneesh
