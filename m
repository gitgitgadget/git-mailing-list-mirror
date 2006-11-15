X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 18:58:50 +0000
Message-ID: <200611151858.51833.andyparkins@gmail.com>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 19:02:03 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qZd2ps7GQi7L9pg1munFHL/AJjGfMc4XTn3iCqmvi8jjxDjLkOCVNGoLrUNpCTqafeSKd61knSrC9s0nz9/hOAkrKELCz6kIlc333ziwy6LDbe4nDeGrxt6i7UMBfTYBSjW8neKzxPkDe1CPNQj3EHi4EHN9Q0DzyrzYjN6Dajk=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31467>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ1A-0004aL-JG for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030879AbWKOTBb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030882AbWKOTBb
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:01:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:10770 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1030879AbWKOTBa
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:01:30 -0500
Received: by ug-out-1314.google.com with SMTP id m3so228167ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:01:28 -0800 (PST)
Received: by 10.66.216.6 with SMTP id o6mr3465246ugg.1163617288316; Wed, 15
 Nov 2006 11:01:28 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id u6sm1307914uge.2006.11.15.11.01.27; Wed, 15 Nov
 2006 11:01:27 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 15 18:03, Linus Torvalds wrote:

> Guys, before you start thinking this way, the fact is, there's a lot of
> happy git users.

I'm a happy user, doesn't mean I wouldn't like changes.  In fact, by that 
argument, that there are happy users means that there is no need to ever make 
changes.

>  - git itself has now done it that way for the last 18 months, and the
>    fact is, the people _complaining_ are a small subset of the people who
>    actually use git on a daily basis and don't complain.

That's awfully like the argument I hear off my bank whenever I complain to 
them too - "well lots of other people don't complain so we must be right".  
The people who complain are a subset of the people who have complaints.  I 
don't think never changing is a good argument - leaving aside the actual 
changes under discussion - in another 18 months lets say there are double the 
number of git users, and 18 months after that double again - in that case the 
potential new users needs outweigh the current users needs.

> If you think "pull" is confusing, I can guarantee you that _changing_ the
> name is a hell of a lot more confusing. In fact, I think a lot of the

> But the fact is, git isn't really that hard to work out, and the commands

On the one hand you're arguing that git syntax is easy to learn, and on the 
other that no one will be able to learn a new syntax just as easily.

> aren't that complicated. There's no reason to rename them. We do have
> other problems:

That there are other problems doesn't negate these problems.

> But trying to rename "pull" (or the "git" name itself) is just going to
> cause more confusion than you fix.

I don't think so.  Mainly because the proposed new git pull would be a subset 
of the existing git pull.  It's not changing function, it's just reducing in 
function.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
