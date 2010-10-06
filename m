From: cdossantos <claudia.dossantos@ricoh-europe.com>
Subject: Re: Someone using GIT and Maven?
Date: Wed, 6 Oct 2010 04:47:50 -0700 (PDT)
Message-ID: <1286365670193-5606731.post@n2.nabble.com>
References: <1285913490619-5590307.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 06 13:47:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3STV-0005RY-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 13:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758838Ab0JFLrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 07:47:51 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33312 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab0JFLrv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 07:47:51 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <claudia.dossantos@ricoh-europe.com>)
	id 1P3STO-0001Pf-6T
	for git@vger.kernel.org; Wed, 06 Oct 2010 04:47:50 -0700
In-Reply-To: <1285913490619-5590307.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158282>


Hi,

I made new tests and the problem just occur in my Linux environment. 
I used, in my Windows environment, the command "mvn -Dusername=admin
-Dpassword=admin org.apache.maven.plugins:maven-release-plugin:2.0:prepare"
and it worked!

The difference is that in my Linux environment I can just clone the GIT
repository using localhost (git clone http://localhost/project2), if I try
to use the Server IP address I get this error:
Warning: remote HEAD refers to nonexistent ref, unable to checkout.

 I review the Apache HTTP Server settings and I didn't find anything. I'm
able to browse the GIT Repository using Localhost
(http://localhost/project2) or the Server IP address
(http://10.1.1.2/project2).

Any ideas?

regards,
Santos
-- 
View this message in context: http://git.661346.n2.nabble.com/Someone-using-GIT-and-Maven-tp5590307p5606731.html
Sent from the git mailing list archive at Nabble.com.
