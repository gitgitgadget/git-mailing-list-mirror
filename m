From: "Per Cederqvist" <cederp@opera.com>
Subject: Confusing error message from "git pull" when upstream repo no longer
 exists
Date: Tue, 29 Jun 2010 12:33:16 +0200
Organization: Opera Mini
Message-ID: <op.ve14xqlq0i1pst@centurion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: cederp@opera.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 12:45:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTYJy-000853-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 12:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab0F2Kpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 06:45:34 -0400
Received: from smtp.opera.com ([213.236.208.81]:42052 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755142Ab0F2Kpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 06:45:33 -0400
X-Greylist: delayed 733 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2010 06:45:33 EDT
Received: from centurion (046-tdc.opera.com [213.236.208.46] (may be forged))
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o5TAXHWe020154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 Jun 2010 10:33:18 GMT
User-Agent: Opera Mail/10.11 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149897>

When running "git pull", I get this error message:

     fatal: /usr/local/libexec/git-core/git-pull cannot be used without a  
working tree.

"git fetch" gives me a much clearer error message:

     fatal: '/var/git/project.git' does not appear to be a git repository
     fatal: The remote end hung up unexpectedly

/var/git/project.git does no longer exist on the origin server, so I
understand why the commands fail.  I think "git pull" should have a
less confusing error message, though.

     /ceder
-- 
Per Cederqvist, cederp@opera.com
