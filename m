From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Howto update a 'dirty' entry in the cache from the object database
Date: Wed, 4 May 2005 21:20:02 +0200
Message-ID: <20050504192002.GH20994@cip.informatik.uni-erlangen.de>
References: <20050504142351.GL18380@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505041014510.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 04 21:15:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTPJy-0005qi-Jb
	for gcvg-git@gmane.org; Wed, 04 May 2005 21:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVEDTUS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 15:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEDTUS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 15:20:18 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50076 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261399AbVEDTUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 15:20:05 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j44JK2S8008512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 4 May 2005 19:20:02 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j44JK2Y1008510
	for git@vger.kernel.org; Wed, 4 May 2005 21:20:02 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505041014510.2328@ppc970.osdl.org>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> 	# read a new index file with the HEAD information
> 	GIT_INDEX_FILE=tmp-index git-read-tree HEAD

> 	# check out just the one file you want to have
> 	GIT_INDEX_FILE=tmp-index git-checkout-cache -f filename

> 	# remove the now useless temporary index
> 	rm tmp-index

> 	# update your _real_ index file with the file information
> 	git-update-cache filename

thanks. That is exactly what I was looking for.

	Thomas
