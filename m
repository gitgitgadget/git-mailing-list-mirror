From: Tejun Heo <htejun@gmail.com>
Subject: Regarding gitk
Date: Fri, 13 May 2005 14:19:23 +0900
Message-ID: <20050513051923.GA15116@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 13 07:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWSSk-00084e-Oi
	for gcvg-git@gmane.org; Fri, 13 May 2005 07:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVEMFTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 01:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVEMFTh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 01:19:37 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:13694 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262239AbVEMFT1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 01:19:27 -0400
Received: by rproxy.gmail.com with SMTP id a41so345817rng
        for <git@vger.kernel.org>; Thu, 12 May 2005 22:19:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=FIC9F0zsKGwre6fwc2jWPTOXt/NoohpYCjmM2F6NV+R9oKxCtpEQPQzog2ol3GPGnJ4+G/gTMlD85kgTfZ5lfdsSAS87Gs0OEbGwTiEmgu6+odSWEga7ziwuBIDblY0LQmU9zdSwJVNlw56sNqThRr/5ku+hsH9gMpJE4scvSaA=
Received: by 10.39.1.54 with SMTP id d54mr1206588rni;
        Thu, 12 May 2005 22:19:27 -0700 (PDT)
Received: from htj.dyndns.org ([222.97.233.103])
        by mx.gmail.com with ESMTP id f3sm886018rne.2005.05.12.22.19.26;
        Thu, 12 May 2005 22:19:27 -0700 (PDT)
Received: by htj.dyndns.org (Postfix, from userid 1000)
	id 748FE184293; Fri, 13 May 2005 14:19:23 +0900 (KST)
To: paulus@samba.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 Hello, Paulus.

 First of all, thanks a lot for gitk.  I was working on something using
graphviz/pygtk to do about the same thing for a couple of weeks (and got
pretty far with it) but ditched it as gitk seemed much better.  I really
love how gitk shows the commit graph. :-)

 As I don't wanna ditch any more of my time, it would be great if you
let me know what you're currently working on, so that I can coordinate
with you.  Here are the things I have on mind.

* integrate two-way diff view w/ diff map into gitk from mgdiff.
* show the current cache and working files at the head of graph
* demand-load commits as the user scrolls down the graph

 I wrote a commit viewing utility (gitkdiff) modified from mgdiff two
weeks ago so I'm quite familiar with mgdiff source, and implemented
demand-loading of commits in my own project in python, but writing a
separate c utility with the same algorithm wouldn't take that much time.

 Thanks.

-- 
tejun
