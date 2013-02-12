From: MikeW <mw_phil@yahoo.co.uk>
Subject: A good Git technique for referring back to original files
Date: Tue, 12 Feb 2013 08:11:27 +0000 (UTC)
Message-ID: <loom.20130212T085620-989@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 09:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5AyD-0003Td-8O
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 09:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758132Ab3BLILl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 03:11:41 -0500
Received: from plane.gmane.org ([80.91.229.3]:34612 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757989Ab3BLILk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 03:11:40 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U5Ay6-00037a-8l
	for git@vger.kernel.org; Tue, 12 Feb 2013 09:11:58 +0100
Received: from static.kpn.net ([static.kpn.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 09:11:58 +0100
Received: from mw_phil by static.kpn.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 09:11:58 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.204.2.113 (Mozilla/5.0 (Windows NT 5.1; rv:18.0) Gecko/20100101 Firefox/18.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216120>

Hi,

I have a client with an SDK product. Normally the SDK is used in its unpackaged
form by the end-user, and that is the directory structure and set of files in
which development work on the SDK functionality is performed.

However the SDK directory and content is generated from a packager which first
runs on numerous other version controlled projects (currently CVS projects -
this is unlikely to change).

This means that once changes to the unpackaged SDK have been tested, they have
to be cross-referred back to the original projects and the changes ported back.

I have found it most convenient to control my in-SDK changes with git.

However it's still a royal pain to cross-refer and diff the changes back to the
originals, especially since duplicate file names exist across the original
projects which get filtered down to one relevant instance by the packager.

Since git is so good at tracking file content, I wondered whether there was any
technique using git that would simplify the back-referencing task.

Failing a method using git 'normally', perhaps building a script on top of the
git file system might be a possibility - if that is feasible ...

Thanks,
MikeW
