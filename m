From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git and GSoC 2013
Date: Wed, 27 Mar 2013 11:52:48 -0700
Message-ID: <20130327185248.GE28148@google.com>
References: <20130327183410.GA26066@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:53:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvTO-0002jG-08
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab3C0Swy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:52:54 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63138 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab3C0Swx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:52:53 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so5409111pbb.18
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=O/1wUEEkXAT7M+g9YELtar7Z3s3/tN1MtHHXuVtLV+8=;
        b=cBYnjRaPAzSAeA23qyjF5+23aKvzqQb/wwM3A4Smq/mdX6y30u0/UnZTqahxKzWiwz
         hIiZSOr/kwuiBUySrrrEWvqBUIjQ3qqI5AIhK4yIlIXUuo6FI9UxH3vAIvuupo3AfiAy
         kwMvXFz8eGbJR+seB56xPlKcipOsRqzlqbU4fag3+qNE6IY5H5lP4ddoUaxxlaEov6/d
         BBlEe9XJpCXJ8/nJlk0DRPXdw973AWTJ4NUr5svVsu4sv+EjAhLVKUwCevPjj+C4gFYZ
         g4RVkrf1gfBeo0wlJHttOGRZqK7LVR2x2CF8bf20gWCkHa/UaVpiBrYWUvWkpld2pia+
         L+Jg==
X-Received: by 10.68.164.33 with SMTP id yn1mr31181977pbb.166.1364410373115;
        Wed, 27 Mar 2013 11:52:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id eh5sm22357353pbc.44.2013.03.27.11.52.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 11:52:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327183410.GA26066@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219303>

Jeff King wrote:

> There was a big thread about a month ago on whether Git should do Google
> Summer of Code this year[1].
[...]
> In my opinion, a lot of the issues come down to project selection;

Let me throw in some other issues. :)

 * I think the git project has been very disorganized in vetting
   candidate students.  Other organizations have formal requirements
   (for example, "must submit at least one properly formatted patch to
   qualify") but we seem to rely on a candidate's good sense,
   independence, and general sense of trustworthiness without
   providing guidance beyond that.

   At first glance that wouldn't seem to be a problem --- the accepted
   students have been very good anyway --- but I think that if we
   could communicate more clearly what we need, we might find there
   are more qualified students that we have been missing, and
   promising students might end up working a little in advance of
   GSoC to adapt themselves to the project.

 * Similarly, we are not very good at making clear the expectations
   for students during the program and making sure they are met.  At
   least I know I was lousy about this as a mentor.

   For example, students delay too long before posting patches
   on-list and do not ask for help quickly when they are stuck.  By
   the end of the summer they may start to get a sense of the usual
   contribution workflow when they could have been more effective
   by following it from the start.

   Some organizations require (as a non-negotiable rule) regular blog
   posts from their students, as a way of advertising to others what
   work they are doing and how to help them out.  That could help
   here. 

 * We didn't plan in advance for "What happens when summer ends and
   the students don't have free time any more?"

 * We don't advertise any good recourse available to students if a
   mentor is unexpectedly too busy or hard to contact.  I don't know
   if that's happened in practice.

Matthieu Moy's summer projects worked better in all these respects, I
think.

I don't think we should apply.  Better to take a break and prepare for
next time.

My two cents,
Jonathan
