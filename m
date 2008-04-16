From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] sh updates for 2.6.25
Date: Tue, 15 Apr 2008 20:25:28 -0700
Message-ID: <7vd4oqwkev.fsf@gitster.siamese.dyndns.org>
References: <20080415172333.GA29489@linux-sh.org>
 <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
 <m3ej97rmc0.fsf@localhost.localdomain>
 <20080416003725.GF8387@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:39:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlyI3-0003tr-9F
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 05:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbYDPDZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 23:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755410AbYDPDZp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 23:25:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbYDPDZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 23:25:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E926D2F96;
	Tue, 15 Apr 2008 23:25:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4B1FA2F95; Tue, 15 Apr 2008 23:25:36 -0400 (EDT)
In-Reply-To: <20080416003725.GF8387@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 16 Apr 2008 02:37:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79655>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Apr 15, 2008 at 11:43:24AM -0700, Jakub Narebski <jnareb@gmail.com> wrote:
>> I seem to remember (but I might be mistaken) that this issue was
>> corrected by some patch on git mailing list already...
>
> If we are at it, I had a similar bugreport: If one doesn't use an empty
> line after the first line in the commit message, a git-format-patch +
> git-am combo will strip newlines from the commit message:

That's not a bug but an intended behaviour.  You are triggering "RFC 2822
line folding" of Subject: header.
