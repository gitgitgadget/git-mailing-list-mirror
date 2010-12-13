From: Sylvestre Ledru <sylvestre.ledru@scilab.org>
Subject: Corruption in the repository
Date: Mon, 13 Dec 2010 16:59:50 +0100
Message-ID: <1292255990.25237.27642.camel@korcula.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 17:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSAv9-0005ZN-RY
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 17:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757513Ab0LMQGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 11:06:34 -0500
Received: from santostefano.inria.fr ([193.51.192.151]:44167 "HELO
	santostefano.inria.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757488Ab0LMQGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 11:06:34 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2010 11:06:33 EST
Received: (qmail 27792 invoked by uid 1001); 13 Dec 2010 16:59:51 +0100
Received: from korcula.inria.fr by santostefano (envelope-from <sylvestre.ledru@scilab.org>, uid 92) with qmail-scanner-2.02st 
 (clamdscan: 0.90.1/7197. spamassassin: 3.1.7-deb. perlscan: 2.02st.  
 Clear:RC:1(193.51.192.130):. 
 Processed in 0.020578 secs); 13 Dec 2010 15:59:51 -0000
Received: from korcula.inria.fr (HELO ?193.51.192.130?) (193.51.192.130)
  by santostefano.inria.fr with SMTP; 13 Dec 2010 16:59:51 +0100
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163559>

Hello guys,

I have a small problem with a git repository and I haven't find a way to
fix my problem.
I am using git with gerrit [1] as frontend (even if I don't think it is
related here).
For an unknown reason, the repository just became corrupted.

When I try to clone the repository straight with the file system, the
following error is displayed:
error: refs/changes/98/398/1 does not point to a valid object!
error: refs/changes/98/398/2 does not point to a valid object!
fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is corrupted
fatal: The remote end hung up unexpectedly

git-prune & git-fsck both fail.

Does anyone know how to repair this error ?

Thanks
Sylvestre

[1] http://code.google.com/p/gerrit/
