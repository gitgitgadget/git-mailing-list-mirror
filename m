From: "Matt McCutchen" <hashproduct+git@gmail.com>
Subject: Re: Multiple checkouts of the same repository
Date: Sun, 1 Oct 2006 17:04:36 -0400
Message-ID: <3bbc18d20610011404x52d8ba15ib51ac2a7060bd25e@mail.gmail.com>
References: <3bbc18d20610011203p40d631b7o3bd2c6971a2bfcca@mail.gmail.com>
	 <Pine.LNX.4.63.0610012105590.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	 <3bbc18d20610011214y6132d98eq9cd58b23721bb87d@mail.gmail.com>
	 <Pine.LNX.4.63.0610012116310.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 23:04:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU8UM-0003DE-Aq
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 23:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWJAVEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 17:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWJAVEj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 17:04:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:2741 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932307AbWJAVEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Oct 2006 17:04:38 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1368254nfa
        for <git@vger.kernel.org>; Sun, 01 Oct 2006 14:04:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=aqV+jjD9ZMACTpaWIQJrgbQUTSTDfkaUu4Tq1S8G9E6jq2tHNly+JrPjd9KrkT/NeDngb3cuPDHKudN6pVGVR9r/n8s2jXl0z4npi6gtRLo3H+lzUvksqvqllKgY+/kHnCA5ZuwkCO3gNYS8eSsqyqGhbmleS+V6J184aKxIfFg=
Received: by 10.82.135.13 with SMTP id i13mr119331bud;
        Sun, 01 Oct 2006 14:04:37 -0700 (PDT)
Received: by 10.82.128.10 with HTTP; Sun, 1 Oct 2006 14:04:36 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610012116310.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 3521948873fa5165
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28204>

On 10/1/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The fact is, your setup is fragile, and I think that is hard to fix if you
> do not make A and B git repositories in their own right.

I think my setup is much simpler than having two separate repositories
that update each other using hooks.  What can go wrong, besides the
scenario I mentioned where one working tree doesn't get updated when I
commit through the other one?

Matt
