From: "Richard Lee" <richard@webdezign.co.uk>
Subject: Handling non-git config files
Date: Tue, 23 Feb 2010 22:37:46 -0000
Message-ID: <8440EA2C12E50645A68C4AA9887166513FC19C@SERVER.webdezign.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3cy-00027f-P7
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab0BWWxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 17:53:04 -0500
Received: from mail.webdezign.co.uk ([213.123.201.79]:32250 "EHLO
	webdezign.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754381Ab0BWWxA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 17:53:00 -0500
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2010 17:53:00 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Handling non-git config files
Thread-Index: Acq02NHhdM4+mpshSWGeYMVTWbJuRg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140860>

Hi again git-list,

I have a workflow-related query.

I understand that git is for source code mangement. However in certains
applications like web applications in a live environment, it ends up
storing data related to the state of the application as well.

I myself am a web developer and for me git ends up storing data like the
root path of the web app. I would like to work on a test rig, commit and
push the changes to a central repo. Then pull the changes on to the live
server. Having different config files on the test and live deployments
make this workflow difficult as I don't know how to tell git to handle
the different config files. I have managed to do this with patches, but
I do not thing it is good in the long run.

I would put the config data in it's own location, but unfortunately I
have been given a product to work with and I cannot do that. This means
that config data that I do wish to commit is in the same file as data
that would vary from deployment to deployment.

Currently I only work on the live server with git. Firstly this is not
ideal to experiment on a live site. Secondly my colleagues now want to
learn git and you can't have several people performing git operations on
the same working directory.

So my quesstion is that is there any way to have several checked out
copies of a git repo each with their own slightly different config
files, yet still being able to perform git operations with respect to a
centralised repository as if they were identical?

I've thought about using a migration script for each target deployment
and then ignoring any changes related to the deployment. I've also
considered having each deployment as a seperate branch and then rebasing
changes back and forth. However this seems uneccesarily complicated and
I teaching git beginners about rebasing doesn't seem like a good idea.

The first solution give a me a corrolary question. I use tig for staging
changes. In the config file, the lines specific to the deployment can
end up in the same hunk as lines specific to the application that I do
want to keep. Can I stage partial hunks in tig? Or do I have to use git
add --interative?

Regards,

Richard
