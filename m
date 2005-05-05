From: Andreas Gal <gal@uci.edu>
Subject: Re: list all dirty files in working directory
Date: Thu, 5 May 2005 14:35:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505051433190.8745@sam.ics.uci.edu>
References: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 23:29:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTntm-0005at-C3
	for gcvg-git@gmane.org; Thu, 05 May 2005 23:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEEVfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 17:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVEEVfQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 17:35:16 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:62168 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261935AbVEEVfK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 17:35:10 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j45LZ6er008752;
	Thu, 5 May 2005 14:35:06 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j45LZ5Ht008748;
	Thu, 5 May 2005 14:35:05 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


git-update-cache --refresh | while read line; do
    echo $line | cut -d ':' -f 1
done

That should give you one file per line, for every dirty file. 

Andreas

On Thu, 5 May 2005, Thomas Glanzmann wrote:

> Hello,
> is there another way than call 'checkout-cache -a' and parse the output?
> Maybe a command which lists one dirty file per line?
> 
> 	Thomas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
