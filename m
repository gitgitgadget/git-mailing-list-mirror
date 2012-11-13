From: Joe Perches <joe@perches.com>
Subject: bug?  git format-patch -M -D then git am fails
Date: Tue, 13 Nov 2012 14:41:32 -0800
Message-ID: <1352846492.17444.20.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:41:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPAt-0003Ap-2t
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 23:41:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab2KMWl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 17:41:29 -0500
Received: from perches-mx.perches.com ([206.117.179.246]:59826 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754220Ab2KMWl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 17:41:29 -0500
Received: from [173.51.221.202] (account joe@perches.com HELO [192.168.1.167])
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 19837692; Tue, 13 Nov 2012 14:41:28 -0800
X-Mailer: Evolution 3.6.0-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209678>

If a file is deleted with git rm and a patch
is then generated with git format-patch -M -
