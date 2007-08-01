From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: multiple checked out branches
Date: Thu, 2 Aug 2007 00:34:30 +0200
Message-ID: <20070801223430.GC2911@steel.home>
References: <20070801220435.GA19226@raptus.dandreoli.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:34:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMm3-0007Qf-1x
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXHAWec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 18:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbXHAWec
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:34:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:39048 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbXHAWec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:34:32 -0400
Received: from tigra.home (Fae16.f.strato-dslnet.de [195.4.174.22])
	by post.webmailer.de (mrclete mo44) (RZmta 10.3)
	with ESMTP id j072b9j71MQtWf ; Thu, 2 Aug 2007 00:34:30 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4AE46277BD;
	Thu,  2 Aug 2007 00:34:30 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3049AC21D; Thu,  2 Aug 2007 00:34:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070801220435.GA19226@raptus.dandreoli.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3urCQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54491>

Domenico Andreoli, Thu, Aug 02, 2007 00:04:35 +0200:
> Hi again,
> 
>   I would like to contemporaneously work with multiple branches out of
> the same git repository. This does not work out of the box.
> 
> So I prepare multiple copies of the same repository, every one will have
> its own checked out branch but I want to share most of their .git subdir.
> 
> I surely want to share the object db, the local and remote refs.
> This way it is enough to make a round of fetches/merges/pushes to have
> all the shared-repositories up to date.
> 
> I expect to do the trick with some symlinks but I am not an expert of
> git internals. Which traps are waiting me? Any hint? Thank you.
> 

No traps. Supported. See for "git clone -s" and "git clone -l"
