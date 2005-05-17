From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] improved delta support for git
Date: Tue, 17 May 2005 21:02:44 +0200
Message-ID: <20050517190244.GP13508@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain> <20050517182232.GM13508@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 17 21:04:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7Ki-0004fZ-2w
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVEQTCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVEQTCr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:02:47 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:6045 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261312AbVEQTCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 15:02:46 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4HJ2iS8004389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 17 May 2005 19:02:45 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4HJ2i05004388
	for git@vger.kernel.org; Tue, 17 May 2005 21:02:44 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050517182232.GM13508@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
btw. 6 Megabyte are spend on commit and tree objects:

(medion) [/scratch/mutt/mutt-cvs] find .git/objects/ -type f | sed 's^.*\(..\)/^\1^' | while read FILE; do echo -n "$FILE " ;git-cat-file -t $FILE; done | egrep 'tree|commit' | awk '{print $1}' | sed 's,^\(..\),.git/objects/\1/,' | xargs ls -l | awk '{sum += $5} END {print sum}'
6179105

I know my shell sux.

	Thomas
