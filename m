From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: Re: [PATCH/RFC] Ship bash completion package in RPMs
Date: Fri, 19 Mar 2010 11:52:55 -0700
Message-ID: <14EFE50D-5ACC-4DA8-8DB9-1BBD5C338E0F@stanford.edu>
References: <1269023213-18432-1-git-send-email-icomfort@stanford.edu> <1269023855-sup-5053@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Mar 19 19:53:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NshJf-0006fo-MC
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 19:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab0CSSw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 14:52:58 -0400
Received: from smtp5.Stanford.EDU ([171.67.219.85]:53932 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751600Ab0CSSw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 14:52:57 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 2748018F64C;
	Fri, 19 Mar 2010 11:52:57 -0700 (PDT)
Received: from rescomp.stanford.edu (rescomp.Stanford.EDU [171.67.43.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 1FCC718F57B;
	Fri, 19 Mar 2010 11:52:56 -0700 (PDT)
Received: from webster.Stanford.EDU (webster.Stanford.EDU [171.67.132.132])
	by rescomp.stanford.edu (Postfix) with ESMTP id EF4D791EF;
	Fri, 19 Mar 2010 11:52:55 -0700 (PDT)
In-Reply-To: <1269023855-sup-5053@pinkfloyd.chass.utoronto.ca>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142632>

On 19 Mar 2010, at 11:43 AM, Ben Walton wrote:
> Excerpts from Ian Ward Comfort's message of Fri Mar 19 14:26:53  
> -0400 2010:
>> RPM-based distributions tend to have bash. Let's add the bash  
>> completion routines to our core RPM in the standard location.
>
> I'd like to see this change too and have been tempted to submit it  
> myself.
>
> The only thing I'd (possibly) change, which speaks to your comments  
> about contrib/, would be to make it conditional, requiring the  
> builder to enable it specifically during the rpmbuild.  Alternately,  
> it could be split out to a git-completion subpackage?

I'd be happy to implement either of these alternatives, if we can  
gather a reasonable consensus around either.

-- 
Ian Ward Comfort <icomfort@stanford.edu>
Systems Team Lead, Academic Computing Services, Stanford University
