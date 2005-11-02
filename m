From: Pavel Roskin <proski@gnu.org>
Subject: cogito: missing *.txt files in Documentation/tutorial-script
Date: Wed, 02 Nov 2005 18:07:30 -0500
Message-ID: <1130972850.23026.11.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 03 00:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXRhf-0001rV-Mf
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 00:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965332AbVKBXHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965333AbVKBXHd
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 18:07:33 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:36771 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965332AbVKBXHc
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 18:07:32 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EXRhb-0002CG-Tj
	for git@vger.kernel.org; Wed, 02 Nov 2005 18:07:32 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EXRha-00007b-Ss; Wed, 02 Nov 2005 18:07:30 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11055>

Hello!

Following files are missing in cogito:

Documentation/tutorial-script/0002-alice-license.txt
Documentation/tutorial-script/0009-alice-README.txt
Documentation/tutorial-script/0020-alice-CONTRIBUTORS.txt

I believe they weren't committed because *.txt is ignored in
Documentation/.gitignore

You may want to add Documentation/tutorial-script/.gitignore and put
following line in it:

!*.txt

-- 
Regards,
Pavel Roskin
