From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Thu, 4 Dec 2014 09:56:54 -0800
Message-ID: <20141204175654.GC9992@google.com>
References: <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051911.GP6527@google.com>
 <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
 <xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
 <20141203232951.GJ6527@google.com>
 <xmqqbnnkufmt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:57:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwaeF-0004aE-RW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 18:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbaLDR47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 12:56:59 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:39051 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbaLDR46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 12:56:58 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so16204201iec.16
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UYBWpxT+QkgaYZ9WgClVXnRtyk2nMPAGjqUWZjjszeM=;
        b=O72xeNGegTvrY8ToMbcp1Pl9FhNWEJYF+KBI2fyB+yCqkPtmw2zc3Eqf5YJMLsrQf0
         P3vg0+YvC0CGnHvRMN0aH8R8ZoQgwDZBj5PNW0uSGS52eJBD/5LhYP9ZLftur0d3H7qZ
         w8uFf0OCtRMGBv5j7eHLNlLssr+iyWV7BzQ9eSu70Q3AimGK2Il8OyucFvw3DV0BnGZm
         BtrNUm0vPrBjSZL/18q8KonDt69WjT880dQaFOt67BKJswpkHjaWNQ8mzi5kd/AyfHYQ
         g9sV4KMVbLRQAaE0tfQkAM8Re44tL6gTJeGB/WpAJQCUmghPVYmbbtSvdgEvA2FAc/r6
         0d+Q==
X-Received: by 10.50.18.6 with SMTP id s6mr14997622igd.18.1417715817366;
        Thu, 04 Dec 2014 09:56:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id la3sm5017599igb.0.2014.12.04.09.56.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 09:56:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqbnnkufmt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260771>

Junio C Hamano wrote:

> We may want to see it done the other way around, though.  That is,
> to allow the pack-refs race fix, which was reviewed and has been
> cooking, graduate without having to depend on this API rewrite, so
> that we may be able to merge it down even to v2.2.x maintenance
> track.

Good idea.  When I send out the reroll of this API change today, it
will be based on top of master + that patch.

Thanks,
Jonathan
