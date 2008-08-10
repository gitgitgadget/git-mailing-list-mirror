From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Make it scream by minimizing temp files
Date: Sat, 09 Aug 2008 20:53:48 -0700
Message-ID: <7v8wv54jar.fsf@gitster.siamese.dyndns.org>
References: <1218235313-19480-1-git-send-email-marcus@griep.us>
 <20080809062521.GA10480@untitled> <489DBB8A.2060207@griep.us>
 <20080810014625.GA31438@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Aug 10 05:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS21B-0000R5-Hw
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 05:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbYHJDx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 23:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbYHJDx4
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 23:53:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbYHJDxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 23:53:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AF083530D5;
	Sat,  9 Aug 2008 23:53:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EA05F530D0; Sat,  9 Aug 2008 23:53:50 -0400 (EDT)
In-Reply-To: <20080810014625.GA31438@hand.yhbt.net> (Eric Wong's message of
 "Sat, 9 Aug 2008 18:46:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F3C44EEC-668F-11DD-9CDA-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91803>

Eric Wong <normalperson@yhbt.net> writes:

> Junio (or anybody else), any thoughts on what the submodule should be
> named?  I'm not good at naming things :x

I'd say putting it in Git.pm itself is fine.  Git.pm is to give common
services to Porcelains, and we already have things like command_*_pipe()
family of functions that do not have to be git specific.

I'd be a bit surprised if there isn't any existing CPAN module for things
like this, though...
