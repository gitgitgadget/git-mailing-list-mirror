From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Fri, 30 Mar 2012 09:23:01 -0500
Message-ID: <20120330142301.GB10343@unpythonic.net>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
 <7v1uokxxzh.fsf@alter.siamese.dyndns.org>
 <4F6C4B59.8060102@op5.se>
 <87obrn6o9x.fsf@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Plotnick <shrike@netaxs.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 16:23:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDcjP-0008Mb-1G
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 16:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760431Ab2C3OXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 10:23:07 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:54976 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759700Ab2C3OXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 10:23:04 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id B161511404E; Fri, 30 Mar 2012 09:23:01 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <87obrn6o9x.fsf@sol.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194362>

Hmm, let's say you'd like to view the last 10 commits in a specialized
program that divides them up and provides good search capabilities:
    mutt -f <(git format-patch --stdout -10)
one shortcoming is that the whole git format-patch process must finish
before mutt will begin showing the mailbox .. otherwise, this seems
pretty awesome.

Jeff
