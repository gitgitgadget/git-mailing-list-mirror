From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 29 Feb 2012 10:53:29 -0800
Message-ID: <7vhay9tqs6.fsf@alter.siamese.dyndns.org>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: opticyclic <opticyclic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 19:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2oej-0005ux-JG
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 19:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274Ab2B2Sxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 13:53:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756683Ab2B2Sxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 13:53:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7C36671F;
	Wed, 29 Feb 2012 13:53:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6MW9m0gGD0+GsXO9FcM7Ty0M6zA=; b=U/0sQr
	IrwdYYEGpRcS8uOdJhaNH1zwtBcZxvTNAQWL2e5JFEhI54K6j4pthNPqTMCjdWSZ
	+wnkvRLqvcPxKSAZQwTxDENkNaJ2XXmYL3etNKDZkgBcEcFM4dfHnEDvVfg+f1Xp
	bmk/lVXJHv19LDxOD0v+yNG0d4IvMxIDhBwSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=va/5USwrAVjiBtHyzIGRu/etRQyiwONI
	n3dp06/NiZ1j/qwwN096tybUIfwtaEIebCGQkSSNOBapVz07gXrE7hbGvj62EbzV
	pIz/x3Ujl9dY75fgC7n0Tm/gKZ45ByUE5Gy/SBGju34pkpamICyd0rj+xv84daaT
	nUPo3MmMbsE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD5F4671E;
	Wed, 29 Feb 2012 13:53:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D60F671C; Wed, 29 Feb 2012
 13:53:31 -0500 (EST)
In-Reply-To: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 (opticyclic@gmail.com's message of "Wed, 29 Feb 2012 12:19:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC867F10-6306-11E1-A23A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191842>

opticyclic <opticyclic@gmail.com> writes:

> Firstly, why is there no Bug Tracker such as JIRA for the git project?

Probably because nobody volunteered to set-up, actively de-dupe, triage
and maintain it in general.

> Secondly, since one of the alleged reasons for creating git was to not
> have to deal with patches, why are pull requests disable and patches
> sent to this mailing list?!

I think Brian already corrected whoever "alleges" such.

We prefer to develop in the open, reviewing and improving both patches and
ideas on the mailing list, without having to rely on a single project
hosting site everybody has to go and deal with web based interface.
