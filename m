From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: 'read-tree -m head' vs 'read-tree head'
Date: Tue, 3 May 2005 14:49:35 +0200
Message-ID: <20050503124935.GT25004@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 03 14:44:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSwko-0005cf-Dv
	for gcvg-git@gmane.org; Tue, 03 May 2005 14:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVECMtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVECMtt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 08:49:49 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:58594 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261511AbVECMtm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 08:49:42 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j43CnZS8018374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 3 May 2005 12:49:35 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j43CnZN3018372
	for git@vger.kernel.org; Tue, 3 May 2005 14:49:35 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I see in Linus merge script

	read-tree -m $merge_tree && checkout-cache -f -a && update-cache --refresh

Does this the same as read-tree $merge_tree would do?

	Thomas
