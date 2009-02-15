From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sat, 14 Feb 2009 18:32:50 -0800
Message-ID: <7v63jcqvjh.fsf@gitster.siamese.dyndns.org>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 03:38:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYWtL-0004Vc-Rg
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 03:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbZBOCdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 21:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbZBOCdF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 21:33:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZBOCdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 21:33:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 86DBA2B268;
	Sat, 14 Feb 2009 21:33:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D4EEC2B25F; Sat,
 14 Feb 2009 21:32:56 -0500 (EST)
In-Reply-To: <7vfxigqwsp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 14 Feb 2009 18:05:42 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F68750EE-FB08-11DD-BB85-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109955>

Junio C Hamano <gitster@pobox.com> writes:

> The advertised new feature is that you can use the @{-1} syntax anywhere
> you would use a branch name and it would work as if you typed the name of
> the branch, so in that sense show-branch that shows @{-1} and does not
> show the name of the branch is a bug.

I've checked "checkout -b new -t @{-1}", too.  Just for completeness's
sake.
