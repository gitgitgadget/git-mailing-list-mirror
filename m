From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Mon, 14 May 2012 16:54:37 +0200
Message-ID: <20120514145437.GC2107@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <D4710CB39C254E8DA3B9778366145718@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, trast@student.ethz.ch,
	gitster@pobox.com, mhagger@alum.mit.edu, peff@peff.net,
	spearce@spearce.org, davidbarr@google.com
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon May 14 16:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STwfn-0004Z0-HN
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 16:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab2ENOyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 10:54:47 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56298 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab2ENOyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 10:54:46 -0400
Received: by obbtb18 with SMTP id tb18so7519858obb.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 07:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MwqsF2PuT/DtkmoWqmEZkTi/VOgWes2jmzXH2G5Rt+g=;
        b=UNrXPCCu5IgWlEgyeJP7H2zIIq57gBdf45xvRA2TqKiZFSfj6F9mMdsPvQB0AQKtm8
         bzpFpLe0AowrBJplFV8S/0z4cOFFiauKQn1CEozG5REpWN9qbGv7g7p3eplX5+TueD3B
         lvQ8esOSJyiIFL3Iv9WS9zcAL1jaWiwH732jSv3pWOfGJxrZcbr+MgTH6vMLY3742ez7
         /IFU/hLgCVXw1SQWIQBWBkTTl9B2GEyeEbfBfCMeJCZZjYg6ozcJTlpjdgQ7Appel5Sz
         1Z1UtWXZGIfGHUFFyvGsYrjiw4Qol5jkuDj4h9k5l4pJYOu9U8kkMzm89MR1jC/ABWIt
         nRDw==
Received: by 10.182.183.73 with SMTP id ek9mr11779846obc.15.1337007285322;
        Mon, 14 May 2012 07:54:45 -0700 (PDT)
Received: from localhost ([216.18.212.218])
        by mx.google.com with ESMTPS id d6sm15387137oeh.3.2012.05.14.07.54.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 May 2012 07:54:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <D4710CB39C254E8DA3B9778366145718@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197774>



On 05/13, Philip Oakley wrote:
> From: "Thomas Gummerer" <t.gummerer@gmail.com> Sent: Thursday, May 03, 2012 6:25 PM
> >I have been drafting the Version 5 of the index format over the past
> >few days with the help of Thomas Rast, Michael Haggerty, cmn and
> >barrbrain on IRC.
> 
> >
> >GIT index format
> >================
> >
> >= The git index file has the following format
> >
> 
> Given the discussions on the list about the general naming of
> Staging vs Index [1], would a careful change to the title, and the
> adding of an introductory line help in putting the index file format
> in the appropriate (implementation) context?
> 
> I'm thinking that perhaps -
> Title: "GIT index file format (V5)", i.e. add the 'file' qualifier.
> 
> Introduction line:
> "The git index file (.git/index) documents the status of the files in the git staging area."
>    i.e. this is an implementation document for this particular file, but using the terms
>    suggested in [1]. Followed by
> "The staging area is used for preparing commits, merging, etc.".
>   i.e. show the purpose of this index relative to the overall
> 'staging area'.   IIRC the use of the staging area for merging was
> one of Linus's key features;-)
> 
> By crafting the title and the introduction line(s) the confusion
> e.g. [2], between implementation details (this document) and
> conceptual operation can be clearly separated.
> 
> Philip
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/197111
> [1.8.0] use 'stage' term consistently
> 
> [2] http://raflabs.com/blogs/silence-is-foo/2011/04/07/staging-area-index-cache-git/
>    ... Git it's a little bit confusing to undersand some of its terminology

Thanks for your suggestion. I've changed the documentation to take this
into account.
