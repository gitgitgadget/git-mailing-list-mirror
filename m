From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Cache optimizations
Date: Mon, 9 May 2005 01:15:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505090058240.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 09 07:08:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV0VP-0006zA-4Y
	for gcvg-git@gmane.org; Mon, 09 May 2005 07:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbVEIFP2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 01:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVEIFP2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 01:15:28 -0400
Received: from iabervon.org ([66.92.72.58]:53255 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S263047AbVEIFPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 01:15:25 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DV0bl-0005sH-00
	for git@vger.kernel.org; Mon, 9 May 2005 01:15:09 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Does anyone know of a reason not to refresh each entry in the cache as
it's checked out? It seems to me like this would eliminate the need to
call update-cache --refresh after checkout-cache and it would update only
the entries for files which are actually changed in the working directory.

Is it just that the code to lock and write the cache is
(currently) inconvenient to add to different programs?

	-Daniel
*This .sig left intentionally blank*

