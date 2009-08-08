From: Caleb Adam Haye <caleb@firecollective.com>
Subject: git ssl error
Date: Fri, 7 Aug 2009 17:45:12 -0700
Message-ID: <ccf1fc2c0908071745j142c4dd0teccd276eab13203c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 02:45:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZa45-0000V0-7v
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 02:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbZHHApc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 20:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755165AbZHHApc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 20:45:32 -0400
Received: from mail-gx0-f213.google.com ([209.85.217.213]:46294 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755122AbZHHApb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 20:45:31 -0400
Received: by gxk9 with SMTP id 9so2602968gxk.13
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 17:45:32 -0700 (PDT)
Received: by 10.151.15.3 with SMTP id s3mr2989186ybi.270.1249692332180; Fri, 
	07 Aug 2009 17:45:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125235>

I'm having trouble using git over SSL.

git clone https://myserver.com/git/my-project.git
Initialized empty Git repository in /Users/username/my-project/.git/
fatal: https://myserver.com/git/my-project.git/info/refs download
error - SSL certificate problem, verify that the CA cert is OK.
Details:
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate
verify failed

The SSL Checker (http://www.sslshopper.com/ssl-checker.html) seems to
think everying is fine w/ the SSL config.

I think the problem is that I need to install the ca-certificates
locally, but i think i have done that... not sure if it's done
correctly though

Please help

--
Caleb Adam Haye
caleb@firecollective.com

The information contained in this message is confidential and intended
only for the use of the individual or entity named above, and may be
privileged. Any unauthorized review, use, disclosure, or distribution
is prohibited. If you are not the intended recipient, please reply to
the sender immediately, stating that you have received the message in
error, then please delete this e-mail. Thank you.
