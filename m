From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Disable filemode rebase tests in t3400-rebase.sh if no 
 filesystem mode support
Date: Wed, 11 Feb 2009 02:09:00 -0800
Message-ID: <7v7i3xgu9v.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 11:10:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXC3A-0000G4-Ua
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 11:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbZBKKJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 05:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbZBKKJK
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 05:09:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbZBKKJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 05:09:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CFD432AE2C;
	Wed, 11 Feb 2009 05:09:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0183E2AE52; Wed,
 11 Feb 2009 05:09:01 -0500 (EST)
In-Reply-To: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
 (Alex Riesen's message of "Wed, 11 Feb 2009 10:51:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 03DD90CE-F824-11DD-9690-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109396>

Alex Riesen <raa.lkml@gmail.com> writes:

> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> I'm honestly sorry for my contributions. They seem to be exclusively
> in the "make Git work in Windows" area.  Depressing.
>
>  t/t3400-rebase.sh |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

I wonder if you should be fixing the tests with "update-index --chmod"
instead...
