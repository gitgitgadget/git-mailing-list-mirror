From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: Oddities cloning over http
Date: Tue, 10 Apr 2007 06:12:21 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27E536AE@az33exm24.fsl.freescale.net>
References: <46a038f90704100540y33c64a9au762fd927fb906f3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 19:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbG9D-0002ZK-SU
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 15:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbXDJNMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 09:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030490AbXDJNMc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 09:12:32 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:43548 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030477AbXDJNMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 09:12:31 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l3ADCMpD028633
	for <git@vger.kernel.org>; Tue, 10 Apr 2007 06:12:23 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l3ADCMix020544
	for <git@vger.kernel.org>; Tue, 10 Apr 2007 08:12:22 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <46a038f90704100540y33c64a9au762fd927fb906f3d@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Oddities cloning over http
Thread-Index: Acd7bX4tJpMS9104TfK2Cz38cp+bKgAA4sbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44135>

Hi Martin,


I've seen this behavior when the server repo files don't have the same
owner/group as the one you're running the server with. That happened to
me after I edited the config files.


Cheers,
Emil.


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Martin Langhoff
Sent: Tuesday, April 10, 2007 7:41 AM
To: Git Mailing List
Subject: Oddities cloning over http

Cloning over http this repo, using git v1.5.0.5 and v1.5.1.106.ga32037

  http://git.catalyst.net.nz/git/moodle-r2.git

The clone doesn't complete successfully.

 - I don't get a checkout
 - It never creates .git/branches/origin
 - It never creates .git/refs/heads/master

OTOH, it does fetch all the packfiles, and creates all the refs for
the remote branches under .git/refs/remotes/origin/

hmmm...? I did run git-update-server-info on the server...


martin
