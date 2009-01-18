From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP Patch 00/12] Refactoring the http API
Date: Sun, 18 Jan 2009 00:30:12 -0800
Message-ID: <7v8wp9yq23.fsf@gitster.siamese.dyndns.org>
References: <20090118074911.GB30228@glandium.org>
 <1232265877-3649-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 09:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOT4M-0007RI-2B
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 09:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763734AbZARIaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 03:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763512AbZARIaV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 03:30:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763344AbZARIaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 03:30:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F26DE91712;
	Sun, 18 Jan 2009 03:30:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EDE691711; Sun,
 18 Jan 2009 03:30:14 -0500 (EST)
In-Reply-To: <1232265877-3649-1-git-send-email-mh@glandium.org> (Mike
 Hommey's message of "Sun, 18 Jan 2009 09:04:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D43765A-E53A-11DD-BD02-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106162>

Mike Hommey <mh@glandium.org> writes:

> As it is work in progress, some error handling might have regressions, but
> the original error handling is not necessarily much better.
>
> Also note I only rebased my one-year-old work on current master, and haven't
> actually tested it, though, as the code hasn't changed much, I guess it
> should be fine.
> ...
>  6 files changed, 162 insertions(+), 304 deletions(-)

Thanks.

This looks like a very nice code reduction, and the first few patches
looked obviously correct, too ;-)

But I am puzzled by what you mean by "haven't actually tested it".  Do you
mean you do not use http transport very much yourself, or even when you do
you do not use a version of git with these patches applied?
