From: Luke Diamand <luke@diamand.org>
Subject: git repo being corrupted?
Date: Mon, 07 Apr 2008 11:04:17 +0100
Message-ID: <47F9F1A1.30009@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 13:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jip8J-0003Ss-EO
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 13:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYDGLCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 07:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbYDGLCa
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 07:02:30 -0400
Received: from manchester.eukhost.com ([92.48.75.3]:37419 "EHLO
	manchester.eukhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbYDGLCa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 07:02:30 -0400
X-Greylist: delayed 3488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Apr 2008 07:02:29 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=diamand.org;
	h=Received:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse;
	b=hD5SyTobVWErV7QsCfvHKSVfbn5KFJ9d3d3Rg0uw3iNzQLMU6EeKs/T0qa7ucAD3URiqai001K+1NfCcaYMee4DWfx92tARDBq1KMIMvY0Y8+ohuzdYthKc0jDGwa0XZ;
Received: from cpc2-cmbg6-0-0-cust826.cmbg.cable.ntl.com ([81.107.35.59]:39926 helo=ethel.local.diamand.org)
	by manchester.eukhost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <luke@diamand.org>)
	id 1JioD5-0004To-Rl
	for git@vger.kernel.org; Mon, 07 Apr 2008 10:04:19 +0000
Received: from localhost ([127.0.0.1])
	by ethel.local.diamand.org with esmtp (Exim 4.69)
	(envelope-from <luke@diamand.org>)
	id 1JioD3-0001H4-Ug
	for git@vger.kernel.org; Mon, 07 Apr 2008 11:04:17 +0100
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - manchester.eukhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - diamand.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78967>

I've recently started to notice the following being reported:

% git-status
error: bad index file sha1 signature
fatal: index file corrupt

(a) Is there anything I can do to fix this (apart from git-clone from
the repo and start over) ? git-fsck reports the same problem.

(b) What is causing it? Is it just my hard disk failing, or is it a bug?
A memory test seems to be OK.

Linux 2.6.22-3-amd64
File system is XFS
git version 1.5.4.4
