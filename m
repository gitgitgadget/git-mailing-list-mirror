From: gitmiserable <stefank2@yahoo.com>
Subject: fatal: did not find object for shallow
Date: Tue, 26 Jul 2011 07:43:00 -0700 (PDT)
Message-ID: <1311691380591-6622474.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:43:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qliqg-0001Ni-Qd
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459Ab1GZOnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:43:04 -0400
Received: from sam.nabble.com ([216.139.236.26]:56755 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab1GZOnC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:43:02 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <stefank2@yahoo.com>)
	id 1Qliqa-0007Os-JN
	for git@vger.kernel.org; Tue, 26 Jul 2011 07:43:00 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177889>

git fetch mymaindevel

fatal: did not find object for shallow
8803e0ff31955e3fb0ba29f35e07861320490e21

The object is there in the repos:

-bash-3.2$ find .git -name 03e0ff31955e3fb0ba29f35e07861320490e21
.git/objects/88/03e0ff31955e3fb0ba29f35e07861320490e21

-bash-3.2$ git cat-file -t 8803e0ff31955e3fb0ba29f35e07861320490e21
commit

Does anyone know how to get out of this?

Stefan


--
View this message in context: http://git.661346.n2.nabble.com/fatal-did-not-find-object-for-shallow-tp6622474p6622474.html
Sent from the git mailing list archive at Nabble.com.
