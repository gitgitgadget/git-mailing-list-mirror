From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to compare different files in different branches
Date: Sun, 08 Jun 2008 02:51:46 -0700
Message-ID: <7v1w38l0el.fsf@gitster.siamese.dyndns.org>
References: <20080606122421.GA1521@denkbrett.schottelius.org>
 <20080606123539.GA3119@mithlond.arda.local>
 <20080608094754.GB1521@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 11:52:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5HZw-0002sw-Oh
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 11:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755874AbYFHJv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 05:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbYFHJv4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 05:51:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609AbYFHJvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 05:51:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 713883E80;
	Sun,  8 Jun 2008 05:51:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E6E3F3DBF; Sun,  8 Jun 2008 05:51:50 -0400 (EDT)
In-Reply-To: <20080608094754.GB1521@denkbrett.schottelius.org>
 (nico-git-20080606@schottelius.org's message of "Sun, 8 Jun 2008 11:47:54
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86AAE3DC-3540-11DD-B2A1-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84261>

Nico -telmich- Schottelius <nico-git-20080606@schottelius.org> writes:

> Very nice syntax, somehow guessed that this is available, but didn't
> try... my fault. 
>
> Perhaps we should reference git-rev-list(1) from git-diff(1), too?

This is just the standard syntax to name blob _anywhere_, so we should not
hide it in git-rev-list(1) but somewhere people would read before reading
any "technical manual" material, perhaps in the tutorial and git(1).
