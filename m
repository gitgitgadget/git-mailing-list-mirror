From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Interest in locking mechanism?
Date: Tue, 12 Jan 2010 13:10:10 -0500
Message-ID: <1263319565-sup-1767@ezyang>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 12 19:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUlH1-0006P3-0c
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 19:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab0ALSPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 13:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659Ab0ALSPT
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 13:15:19 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:62186 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391Ab0ALSPS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jan 2010 13:15:18 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jan 2010 13:15:18 EST
X-AuditID: 1209190c-b7ccdae00000276b-cd-4b4cbb09b41c
Received: from grand-central-station.mit.edu (GRAND-CENTRAL-STATION.MIT.EDU [18.7.21.82])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id 23.49.10091.90BBC4B4; Tue, 12 Jan 2010 13:10:17 -0500 (EST)
Received: from outgoing-legacy.mit.edu (OUTGOING-LEGACY.MIT.EDU [18.7.22.104])
	by grand-central-station.mit.edu (8.13.6/8.9.2) with ESMTP id o0CIAdNV021477
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 13:10:39 -0500 (EST)
Received: from localhost (EZYANG.MIT.EDU [18.243.1.50])
	)
	by outgoing-legacy.mit.edu (8.13.6/8.12.4) with ESMTP id o0CIAR9U023808
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 13:10:32 -0500 (EST)
User-Agent: Sup/git
X-Scanned-By: MIMEDefang 2.42
X-Brightmail-Tracker: AAAAAQCq+Kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136744>

I have a few friends that still use RCS for their version control
needs.  We have argued over various points between RCS and Git, and
as far as I can tell the one thing RCS has that Git does not is
a locking mechanism.  That is to say, co -l checks out a file and
also gives you a lock on it, preventing others from futzing with it,
and ci -u checks in the file and releases your lock.  This is
useful if you have a shared working copy on a multiuser system or
on a network file system, and you don't want conflicts.

I was wondering if there would be interest in such a feature on
the Git developers side.

Cheers,
Edward
