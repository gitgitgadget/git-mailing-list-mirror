From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] merge-recur: if there is no common ancestor, fake empty one
Date: Wed, 9 Aug 2006 21:55:11 +0200
Message-ID: <20060809195511.GA13766@steel.home>
References: <Pine.LNX.4.63.0608091842210.1800@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0608091943570.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Aug 09 21:55:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAu9T-0004jE-0V
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 21:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWHITzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 15:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWHITzc
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 15:55:32 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:3790 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751315AbWHITzb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 15:55:31 -0400
Received: from fwd30.aul.t-online.de 
	by mailout01.sul.t-online.com with smtp 
	id 1GAu9G-0002dI-03; Wed, 09 Aug 2006 21:55:26 +0200
Received: from tigra.home (VTPJe8ZLged7tqc53VqTJoN3s5D5qrFUMzKS2i1kVTcTUOf9s6tvrr@[84.160.94.240]) by fwd30.sul.t-online.de
	with esmtp id 1GAu93-2KGtuK0; Wed, 9 Aug 2006 21:55:13 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E3DAB277AF;
	Wed,  9 Aug 2006 21:55:12 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GAu92-0003eW-0g; Wed, 09 Aug 2006 21:55:12 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608091943570.1800@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-ID: VTPJe8ZLged7tqc53VqTJoN3s5D5qrFUMzKS2i1kVTcTUOf9s6tvrr
X-TOI-MSGID: 677829ed-1df1-444a-b35b-64b8f130ab5a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25139>

Johannes Schindelin, Wed, Aug 09, 2006 19:44:38 +0200:
> 
> > +		*write_sha1_file_prepare(NULL, 0, tree_type, &tree->object.sha1,
> 
> ... make this "tree->object.sha1" _without_ a "&", of course.
> 

And without the asterisk before write_sha1_file_prepare
