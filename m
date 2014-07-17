From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] rebase: omit patch-identical commits with
 --fork-point
Date: Thu, 17 Jul 2014 10:36:22 +0100
Message-ID: <20140717093622.GE2322@serenity.lan>
References: <xmqqmwcatgza.fsf@gitster.dls.corp.google.com>
 <47e67c62fb2a8c8846f5d3a12d71aebf8fa875d7.1405538598.git.john@keeping.me.uk>
 <374b26180807c67f7bd152ce5a2f52e34397e3a6.1405538598.git.john@keeping.me.uk>
 <53C6F043.7090209@tedfelix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ted Felix <ted@tedfelix.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 11:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7i7V-000823-4s
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 11:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706AbaGQJgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 05:36:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49612 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755374AbaGQJgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 05:36:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 79ED4866009;
	Thu, 17 Jul 2014 10:36:50 +0100 (BST)
X-Quarantine-ID: <4bjtvtlQCWDE>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4bjtvtlQCWDE; Thu, 17 Jul 2014 10:36:42 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 300CA86602E;
	Thu, 17 Jul 2014 10:36:24 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <53C6F043.7090209@tedfelix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253727>

On Wed, Jul 16, 2014 at 05:36:03PM -0400, Ted Felix wrote:
> On 07/16/2014 03:23 PM, John Keeping wrote:
> > Change from v1:
> >      - add a test case
> 
> Test case is working fine for me.  It passes with the patch and fails 
> without.  However, it does seem to cause all the rest of the test cases 
> to fail if it fails.  Is there some cleanup missing?

The individual test cases in the script don't run in isolation, so I
don't think it's surprising the the remainder fail if this one ends up
stuck in rebase-in-progress state.  I think the same will happen with
most of the other test cases in this script.
