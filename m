From: John Keeping <john@keeping.me.uk>
Subject: Re: Review of git multimail
Date: Wed, 3 Jul 2013 09:33:56 +0100
Message-ID: <20130703083356.GF9161@serenity.lan>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
 <7vsizwiowt.fsf@alter.siamese.dyndns.org>
 <51D3DA9A.9090604@alum.mit.edu>
 <20130703082902.GE9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:34:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuIW0-0008G1-4L
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab3GCIeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:34:11 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:47702 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521Ab3GCIeI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:34:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 10B52CDA5DA;
	Wed,  3 Jul 2013 09:34:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ex1Szwf+6W76; Wed,  3 Jul 2013 09:34:07 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id EB60CCDA5D8;
	Wed,  3 Jul 2013 09:34:06 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D8410161E467;
	Wed,  3 Jul 2013 09:34:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwiUkGL-NrmN; Wed,  3 Jul 2013 09:34:05 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 310FE161E032;
	Wed,  3 Jul 2013 09:33:58 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130703082902.GE9161@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229466>

On Wed, Jul 03, 2013 at 09:29:02AM +0100, John Keeping wrote:
> Doesn't "git config --get" return an error if there are multiple values?
> The answer is apparently "no" - I wrote the text below from
> git-config(1) and then checked the behaviour.  This seems to be a
> regression in git-config (bisect running now).

Ah, that was an intentional change in commit 00b347d (git-config: do not
complain about duplicate entries, 2012-10-23).  So the issue is that the
documentation was not updated when the behaviour was changed.
