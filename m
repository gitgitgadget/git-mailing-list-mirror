From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] linuxptp: add phc_ctl program to help debug PHC devices
Date: Thu, 10 Jul 2014 16:20:47 -0700
Message-ID: <xmqqr41s6bsg.fsf@gitster.dls.corp.google.com>
References: <1405032485-26117-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:21:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Ne7-0004R1-1b
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 01:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbaGJXUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 19:20:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58727 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbaGJXUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 19:20:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6209428203;
	Thu, 10 Jul 2014 19:20:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ss93n8xV2L/vrSFznaJJUeL+IQE=; b=nM3VPA
	yRTiwkY9eaU21CoorfhGaFO4M2mvV9t2DSnQyU0exSbtx6/PNLBMPB0dgwhd3n9/
	u+F0RXth8obGMJacIVwuBn2XoYwE8HUfTzkxbuC0SaUIh5ZAzZmokv1FcJjeVWl0
	6mgZoucaenAVy0XZRdsg+aH+fn1RHxCRd8XhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lMaAR0EqhqgS2d5Upw1PEzE8WoUwpXCh
	QdaI0Nlo4rHnR3oO5I61owap3Ug1/TEtuEupJxpRNnYDoTBTPpqQ2xzo9d85Weyl
	9OSwR24NMbZeudWjROeFezYlKfzEIBKgWtGGxg9WGSgr5cZ9ZcZ6IBDbkIRmmUBm
	fxXTpOq4pU8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 587A828202;
	Thu, 10 Jul 2014 19:20:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F39EF281FD;
	Thu, 10 Jul 2014 19:20:33 -0400 (EDT)
In-Reply-To: <1405032485-26117-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Thu, 10 Jul 2014 15:48:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CADE00C6-0888-11E4-8519-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253232>

Jacob Keller <jacob.e.keller@intel.com> writes:

> This is an updated version of a script I wrote a couple years ago for

I suspect that this is not for us ;-)
