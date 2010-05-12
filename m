From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] Documentation/notes: simplify treatment of default
 notes ref
Date: Wed, 12 May 2010 05:28:41 -0500
Message-ID: <20100512102841.GA17740@progeny.tock>
References: <20100509031357.GA7926@progeny.tock>
 <20100509032358.GD7958@progeny.tock>
 <201005120946.31193.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 12 12:28:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC9B6-0006cB-10
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 12:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0ELK2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 06:28:31 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:45441 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0ELK2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 06:28:30 -0400
Received: by ywh36 with SMTP id 36so3230915ywh.4
        for <git@vger.kernel.org>; Wed, 12 May 2010 03:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ty59uDwEpL8A2qdKec/yLqrnvEmMqsZSu7O0uW/gRmU=;
        b=LZL0O9RwwTkv7xO/3PnENg6Ne0TthQIExY+kLc8z32L+JXmunpdDfOp2cIS54YrzvH
         zqleZhXkBqv/Q5OekSZT2rSJOL6HrfuPNq+Q2YpfW2X6iqVbfUJpPS2iC3pMHbwE/Z5E
         JDBup0Z9dKFAGvbHJtL7n/u5aZIvrxIHTGbT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uH/+XGz7vwUblCkiRTwvJMrNUH851lOM2LqlNqI55HovqEzVY9cYnSfFrq7F/gto0q
         5UvbeWfp2lRO9YSzkHs60wZqRZvbMDUf2pHuVqTuILhJhfpn5A3kiZdlHWjGXCYCRcDB
         KG3BmFw5NFJjGpe81x4O/Dn0+aykF3NqhKqks=
Received: by 10.150.119.30 with SMTP id r30mr11237252ybc.5.1273660109110;
        Wed, 12 May 2010 03:28:29 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6486ywh.8.2010.05.12.03.28.22
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 03:28:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201005120946.31193.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146937>

Thomas Rast wrote:

> this makes core.notesRef the only configuration
> variable which does not have its environment sibling named explicitly
> in the config section.  Would you mind putting GIT_NOTES_REF back in
> the sentence for consistency with the other variables?

No problem.  You mentioned something similar before; sorry about
missing it.

Thanks,
Jonathan
