From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: why are gitweb 'description' and 'owner' stored in different ways?
Date: Mon, 19 Dec 2005 02:13:19 +0100
Message-ID: <20051219011319.GA29492@vrfy.org>
References: <C095FE37-2673-449D-AAB9-ADF042CE8F32@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 02:14:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo9ao-0006c6-KT
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 02:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVLSBNZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbVLSBNY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 20:13:24 -0500
Received: from soundwarez.org ([217.160.171.123]:16087 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1030207AbVLSBNY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 20:13:24 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 6A0B4724D4; Mon, 19 Dec 2005 02:13:19 +0100 (CET)
To: Ben Clifford <benc@hawaga.org.uk>
Content-Disposition: inline
In-Reply-To: <C095FE37-2673-449D-AAB9-ADF042CE8F32@hawaga.org.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13806>

On Sun, Dec 18, 2005 at 08:27:41PM +0930, Ben Clifford wrote:
> Just wondering, is there a reason that gitweb stores the  
> 'description' in one way (inside .git) and 'owner' in a different way  
> (in index.aux) ?

No special reason besides that the owner is generated automatically from
the file permissions on the master server along with searching for
repositories and creating the list. We currently have more than one
"Linus' kernel tree" descriptions, so if we would rely on in-repo data
for the owner, the owner would be wrong on that repos too.

Kay
