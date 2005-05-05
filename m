From: Pavel Roskin <proski@gnu.org>
Subject: Please rename cg-X* to something else
Date: Thu, 05 May 2005 17:37:06 -0400
Message-ID: <1115329026.3838.8.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 05 23:31:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTnvn-0005rB-Dk
	for gcvg-git@gmane.org; Thu, 05 May 2005 23:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVEEVhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 17:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVEEVhW
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 17:37:22 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:1726 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261944AbVEEVhK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 17:37:10 -0400
Received: by localhost.localdomain (Postfix, from userid 500)
	id 89018EFDD1; Thu,  5 May 2005 17:37:06 -0400 (EDT)
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Since cg-X* scripts are not supposed to be used by the end users, I
suggest that we rename them so something not starting with "cg-" or even
"cg" so that tab completion in bash doesn't show them.  I suggest "_cgX"
instead of "cg-X"

In the long term, the internal scripts should go to
$prefix/share/cogito, but it would require generating other scripts from
templates to substitute $prefix, which could be inconvenient at this
stage.

-- 
Regards,
Pavel Roskin

