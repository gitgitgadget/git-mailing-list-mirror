From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Thu, 21 Mar 2013 13:59:48 -0700
Message-ID: <20130321205948.GM29311@google.com>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321111333.GD18819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 22:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UImaz-00015W-JT
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 22:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab3CUU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 16:59:54 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:50898 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab3CUU7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 16:59:54 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so745729dal.12
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XIdOAmUhHyAOzaQriVYlv5naeHPJfBaCAidMRGUMKdE=;
        b=Ef1Lilx1o3OFJP2uw1WCGWd7xbNVwihbYVoqY+RrDefnmI0r7ex3WuIQ6PCUY8EYsh
         O61slYdYbABwkSJKJMEk/H4+usfhZG6Fw/aUSzOGu4VxRAUsiDqaFcZzkNUWkOiN8pAN
         UCbqfNKW9hmaf5yyTAOJlntr1W6hoatRp7styk1oAFkkEX5zDwcQwecfrr7rR/t6YIUk
         T+jgUB7NDZFOFTKb1bu7qJf/Oi5IomqlmDVWDIuz/jfCjs9g8y+X00zCKejtP0jk9Hhr
         XiqP6k5dTQ0BHSYubdKbmbUfrMgQQOYBxT3/zDJe3Sk0otHYgN6pkB5BP9WBa/ZDmn5v
         euwg==
X-Received: by 10.66.220.197 with SMTP id py5mr17052674pac.86.1363899593608;
        Thu, 21 Mar 2013 13:59:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id gf1sm7291195pbc.24.2013.03.21.13.59.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 13:59:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130321111333.GD18819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218760>

Jeff King wrote:

> We probably _don't_ want to apply this one right now.

I think we should.  gcc 4.6.y warning bugs should be fixed --- there's
no need for git to work around them.  And anyone affected can easily
stop using -Werror (-Werror is not meant for use by non-developers in
production).

So fwiw
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
