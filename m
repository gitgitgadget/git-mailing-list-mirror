From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v10 00/44] Use ref transactions for all ref updates
Date: Fri, 16 May 2014 11:39:17 -0700
Message-ID: <20140516183917.GD12314@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlN2T-0004hr-MF
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428AbaEPSjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 14:39:21 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:54295 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbaEPSjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 14:39:20 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so2922764pbc.26
        for <git@vger.kernel.org>; Fri, 16 May 2014 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5THv6NnqWm/70sPfKRuNRMCiXqNcS/SK9nE3R0YBiZM=;
        b=REl3Nz4teGebrdr9Qo7KbX78CgjuxlPpYDYZVVVZv6ITWeaTt9Cxpq38w3/JVgeZDi
         zxy3FJYthKzkUMW83L2vEm0WHiCwp0al9CDxvyxI+xanFV+yKE1vBin7EoJgjLqCsAlI
         NkvMc+1JNUM0OC4Hzd9pKA/eQ2MRfvTYH+zfEieXIiv9ErSW7ukIHO1J4zoCWCrIUYkv
         dnDzoi0nnGqSnGlXDaT3bhBh/kKdnkjpB3ZJ3NnrgWqZJnueFpuvJEHyUmYFumbj0elY
         W6SqvteLobCEptO3z50lW9I5GO4jnjiIB4g64+JWJyokuJjB6+uZ+pOHT8lSPiA5BcUo
         hOzA==
X-Received: by 10.68.178.131 with SMTP id cy3mr23243108pbc.146.1400265559883;
        Fri, 16 May 2014 11:39:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yj6sm37526467pab.19.2014.05.16.11.39.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 May 2014 11:39:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249408>

Ronnie Sahlberg wrote:

> This patch series can also be found at
> https://github.com/rsahlberg/git/tree/ref-transactions

I think the rerolls are coming too fast.  I've been using your
repository on github to check if I should not send any particular
comment because you've already fixed it, so the extra mail is not
needed for that purpose, at least.

In general, I think it's best to stick with one version of a series,
gather review comments on it, comment inline to solicit feedback about
approaches to particular problems, point reviewers to an up-to-date
branch which is more in flux, etc, and then only resend when reviewers
have had a chance to get through it to make it easier to keep track of
the review without getting lost.

Thanks for the quick work so far, by the way.  It's been fun watching
the API evolve.

My two cents,
Jonathan
