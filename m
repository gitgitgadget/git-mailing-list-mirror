From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC PATCH 2/3] mergetools/kdiff3: allow opting-out of
 auto-merges
Date: Thu, 9 May 2013 18:23:34 +0100
Message-ID: <20130509172334.GK25912@serenity.lan>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
 <1368090810-40596-2-git-send-email-davvid@gmail.com>
 <7vli7ob0c4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 19:24:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaUZR-0005Dw-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 19:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3EIRXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 13:23:53 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:32780 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab3EIRXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 13:23:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 62BD4CDA5DA;
	Thu,  9 May 2013 18:23:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GOztEUEVfcla; Thu,  9 May 2013 18:23:44 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D277ACDA5F8;
	Thu,  9 May 2013 18:23:36 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vli7ob0c4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223763>

On Thu, May 09, 2013 at 09:10:51AM -0700, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > Marked "RFC" because I am kinda against adding more configuration
> > variables.
> 
> Just like "git merge" has -X<option> escape hatch to allow us to
> pass backend-specific options, perhaps you can add a mechanism to
> "git mergetool" to let the user pass --no-auto from the command
> line?

We already have "mergetool.<tool>.cmd" which allows a completely custom
command line to be specified.  IIUC this can be used to override the
built-in command for tool names that already exist.

I'm not sure an extra -X<option> buys us much on top of this, but
perhaps it would be useful for one-off usage.
