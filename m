From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack
 and git-receive-pack.
Date: Sat, 10 Jan 2009 12:36:29 -0800
Message-ID: <7viqomx5iq.fsf@gitster.siamese.dyndns.org>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
 <1231595452-27698-2-git-send-email-prohaska@zib.de>
 <1231595452-27698-3-git-send-email-prohaska@zib.de>
 <alpine.DEB.1.00.0901101532430.30769@pacific.mpi-cbg.de>
 <9CECD102-6D3E-487D-BA1E-C0269D055965@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jan 10 21:38:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLkas-0000wh-Jy
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 21:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbZAJUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 15:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752943AbZAJUgm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 15:36:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbZAJUgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 15:36:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5314E1C324;
	Sat, 10 Jan 2009 15:36:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5300E1C323; Sat,
 10 Jan 2009 15:36:30 -0500 (EST)
In-Reply-To: <9CECD102-6D3E-487D-BA1E-C0269D055965@zib.de> (Steffen
 Prohaska's message of "Sat, 10 Jan 2009 17:01:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 61480E10-DF56-11DD-B2AA-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105143>

Steffen Prohaska <prohaska@zib.de> writes:

> On Jan 10, 2009, at 3:34 PM, Johannes Schindelin wrote:
>
>> Logically, and to avoid committing a broken revision, 1/6 should come
>> last, methinks.
>
> RUNTIME_PREFIX is not defined before 6/6. But I agree,
> 1/6 should probably be moved after 5/6.
>
> 	Steffen

Hmm, I actually was thinking about applying that (and that one only) early
to my tree, to make sure it is regression-free.
