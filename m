From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Fri, 21 Dec 2007 03:14:12 -0800
Organization: Google, Inc.
Message-ID: <20071221111412.GA8695@bulgaria.corp.google.com>
References: <1198216860-487-1-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 12:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fqe-0000TH-9f
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 12:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbXLULO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 06:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbXLULO7
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 06:14:59 -0500
Received: from smtp-out.google.com ([216.239.45.13]:37503 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbXLULO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 06:14:59 -0500
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id lBLBEuhh023057;
	Fri, 21 Dec 2007 03:14:56 -0800
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
	b=ME8W1ARIHyr+Cu3EP1VjaHTL9M5cJZQYidOxWnCJDwRvyzc4f2rbBaF83r6E5M+aY
	ZlaT3THNUc9Lm9fh+UT6w==
Received: from bulgaria (bulgaria.corp.google.com [172.18.102.38])
	by zps37.corp.google.com with ESMTP id lBLBEtod017621;
	Fri, 21 Dec 2007 03:14:55 -0800
Received: by bulgaria (Postfix, from userid 1000)
	id 5A8CF122F27; Fri, 21 Dec 2007 03:14:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1198216860-487-1-git-send-email-git@davidb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69060>

[David Brown <git@davidb.org>]
> Sometimes, it is useful to be able to send a patch to a third party
> without the author of the patch being copied on the message.  An
> common example would be an internal discussion at a company to ask if
> a particular patch should be applied.  Some environments may even have
> policy against such mail being sent outside of the company.
> 
> Add the --suppress-all-from/--no-suppress-all-from options to avoid
> sending patches to the patch author, even if different from the
> sender.  Add the sendemail.suppressallfrom config option to allow this
> to have a different default.
> 
> Signed-off-by: David Brown <git@davidb.org>

Yes-Please: Brian Swetland <swetland@google.com>

This has caused me some pain previously, and just earlier today I 
received an internal patch mail from somebody at another company who
almost certainly did not intend to cc me.

Brian
