From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: cogito Mac OS X compatibility
Date: Sat, 09 Jul 2005 14:38:54 -0400
Message-ID: <42D019BE.5050000@gmail.com>
References: <42CF0D9F.8040909@gmail.com> <20050709165028.GY18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 20:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrKFg-0007mp-Bj
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 20:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVGISkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVGISj7
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 14:39:59 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:57405 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261693AbVGISjA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 14:39:00 -0400
Received: by zproxy.gmail.com with SMTP id z31so286035nzd
        for <git@vger.kernel.org>; Sat, 09 Jul 2005 11:38:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GDwds/t1fKBMvMZ9USCyu+bjodP0aDkgnv4I0b2Y+N1pC1C3UkT2X8Q3WwyPkr2YKwlFmkTGRkQHS3MtnaO3XcWOCTeFe6DSAm6CpITcCCwuSkDolA4Hh2EYMu3Ly+KgGXW/NePstznHABPMI8YIMkUBx8EjE81gGyXAhij9z7Y=
Received: by 10.36.177.5 with SMTP id z5mr914782nze;
        Sat, 09 Jul 2005 11:38:59 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 34sm1379867nza.2005.07.09.11.38.59;
        Sat, 09 Jul 2005 11:38:59 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: skimo@liacs.nl
In-Reply-To: <20050709165028.GY18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> Sounds like you're missing "stat" from coreutils.
> 
> skimo
> 

Thanks.  I've got it working to the point where it passes "make test" 
now.  All I had to do was install coreutils and findutils from 
darwinports, and then make gcp, gstat and gnuxargs available under their 
standard names.

Do the BSD's or Solaris have the same problem?  Last time I used them 
they didn't have the gnu options available on their standard utils, but 
that was ages ago.  If current BSD's have the problem, it might be worth 
expending some effort to make cogito more portable.  If it's only OS X...

Bryan
