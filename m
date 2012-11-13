From: Joe Perches <joe@perches.com>
Subject: bug?  git format-patch -M -D then git am fails
Date: Tue, 13 Nov 2012 14:45:21 -0800
Message-ID: <1352846721.17444.24.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:45:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPEc-0006BG-2H
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 23:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab2KMWpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 17:45:19 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:32822 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755791Ab2KMWpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 17:45:18 -0500
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.167])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19837706; Tue, 13 Nov 2012 14:45:18 -0800
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209679>

(Sorry about the partial message.
 evolution and ctrl-enter sends, grumble...)

If a file is deleted with git rm and a patch
is then generated with git format-patch -M -D
git am is unable to apply the resultant patch.

Is this working as designed?
