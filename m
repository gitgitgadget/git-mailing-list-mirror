From: "Richard Lee" <richard@webdezign.co.uk>
Subject: Doing a dummy or empty merge
Date: Thu, 11 Mar 2010 12:41:02 -0000
Message-ID: <8440EA2C12E50645A68C4AA9887166513FC480@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 13:41:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NphhQ-0001ml-7q
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 13:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943Ab0CKMlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 07:41:07 -0500
Received: from mail.webdezign.co.uk ([213.123.201.79]:47743 "EHLO
	webdezign.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756000Ab0CKMlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Mar 2010 07:41:05 -0500
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Doing a dummy or empty merge
Thread-Index: AcrBGBuruAVGt0WhQ42a058G1lPxcQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141958>

Hi again git-list,

This is a question regarding merging following directly on from my last
question about workflows.

I was recommended a workflow by Jon Seymour to handle multiple
deployments of the same project. In a nutshell, the workflow was to keep
a main branch that reflects a generic undeployed state and keep each
deployment along with the deployment artifacts in a seperate branch.

I don't have a generic branch as such. It's not have the way software I
was given to work on works. I do have a live/production branch.

I have just created a local/test branch. So far I have made and
committed and changes that enables the project to run on my local
machine. 

At this point I want to merge this test branch into the live branch
despite not having made any commits apart from deployment related
changes on the test branch. I want this to be a dummy merge so that a
merge is recorded into the live branch, but the contents of the live
branch remain untouched. This is as if I made an empty commit on the
live branch.

The reason why I want to do this is that I want a point on the test
branch that represents when all deployment-specific commits have been
made. Any further commits from this point onwards are additional
features or bug fixes that are unrelated to the deployment. So any
further merges from this point onwards into the live branch will only
bring over these additional features and fixes. The deployment settings
on the live branch will remain untouched as I have made a 'dummy' merge
already.

I think a nice additional consequence would be that any resulting merge
conflicts would probably indicate that I have made deployment specific
commits rather than any features of bug fixes.

So the question is how do a do a dummy or empty merge as described? So
far I can only thing of doing a --no-commit merge, then checking out all
changed files from the live branch. Is there a neater way of doing this?
I assume this would be like the merge using the 'theirs' strategy, but
the strategy would be used on all merge changes rather than just
conflicts.

Or is there a better way of implementing this workflow?

Regards,

Richard
