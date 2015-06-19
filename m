From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 11:52:28 +0100
Message-ID: <20150619105228.GR18226@serenity.lan>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-4-git-send-email-charles@hashpling.org>
 <20150619101010.GA15802@peff.net>
 <20150619103324.GA4093@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:53:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5tus-0006I3-4i
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbbFSKwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:52:50 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:45771 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbbFSKwo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:52:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7896DCDA5F6;
	Fri, 19 Jun 2015 11:52:42 +0100 (BST)
X-Quarantine-ID: <q6fMjvKSaqUb>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q6fMjvKSaqUb; Fri, 19 Jun 2015 11:52:41 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 2C349CDA5EA;
	Fri, 19 Jun 2015 11:52:30 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20150619103324.GA4093@hashpling.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272126>

On Fri, Jun 19, 2015 at 11:33:24AM +0100, Charles Bailey wrote:
> So, yes, performance is definitely an issue and I could have called this
> command "git magically-generate-all-object-for-scripts" but then, as it
> was so easy to provide exactly the filtering that I was looking for in
> the C code, I thought I would do that as well and then "filter-objects"
> ("filter-all-objects"?) seemed like a better name.

By analogy with "git filter-branch", I don't think "filter-objects" is a
good name here.  My preference would be "ls-objects".
