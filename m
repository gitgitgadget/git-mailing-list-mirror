From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Simple problem
Date: Mon, 28 Apr 2008 19:47:51 +0200
Message-ID: <20080428174751.GA6710@steel.home>
References: <fv4u49$oks$1@ger.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 19:48:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXT2-0006PT-Nf
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785AbYD1Rr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 13:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933769AbYD1Rr4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:47:56 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45355 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933329AbYD1Rrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 13:47:55 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZBJxGkw==
Received: from tigra.home (Faada.f.strato-dslnet.de [195.4.170.218])
	by post.webmailer.de (mrclete mo8) (RZmta 16.27)
	with ESMTP id f0148ck3SGaeKp ; Mon, 28 Apr 2008 19:47:52 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E6F38277BD;
	Mon, 28 Apr 2008 19:47:51 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C04DC56D28; Mon, 28 Apr 2008 19:47:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <fv4u49$oks$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80570>

Kenneth P. Turvey, Mon, Apr 28, 2008 18:31:05 +0200:
> I ran into an issue earlier today that I didn't know how to easily solve 
> in git.  I'm sure it is easy to handle, but I wasn't sure how.  
> 
> I removed a file and then realized I'd hit the wrong one.  So all I 
> wanted to do was to get the file back the way it was in the last commit.  
> 
> Basically I wanted something similar to:
> 
> svn update myfile
> 

git checkout HEAD filename

but mostly just "git checkout filename"
