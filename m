From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 11:48:18 -0800
Message-ID: <xmqq8usx4pvh.fsf@gitster.dls.corp.google.com>
References: <20140225154158.GA9038@sigill.intra.peff.net>
	<530CCFB0.5050406@alum.mit.edu>
	<20140226102350.GB25711@sigill.intra.peff.net>
	<530DC4D1.4060301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 26 20:48:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkSx-0001mO-FF
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 20:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbaBZTsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 14:48:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62805 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbaBZTsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 14:48:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2F3F6E2E3;
	Wed, 26 Feb 2014 14:48:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DhDt8Z5n7gE0ZOaCav2FLlStca0=; b=PuGAYr
	AgluiLrDSFYqe6PDqbn2Phj1H7uiW8nt6sE55VrhbujEu31r4Dcb7Jx0hZtyBVdK
	BzIQov7fZN04oKYt6WAX8RNVLc8oaQ9bkFPcO0UXz0IEMsWGDPX0EuNLcDXvPze7
	0HbWB7WHwEHyw7xRduYzVXd5TqMAb8c2zJF1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEmYZYceAftOzLQK2fFg1S+OqgYx0NAS
	dPSZTSkmJXYjoKxdrYY7fkT65nm7WeMcBBNIxh1il0GRZxTVfxICA4BCzO9iEzKT
	KVeYrKu/bOa/sxMcbOGwMwnnMR1pUqbbsSnSuAvqokwhS1CBxH9Gxb1bu0yu+IRO
	ab8nkx7IzIQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7BB26E2E1;
	Wed, 26 Feb 2014 14:48:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F5F96E2DF;
	Wed, 26 Feb 2014 14:48:20 -0500 (EST)
In-Reply-To: <530DC4D1.4060301@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 26 Feb 2014 11:41:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F193393A-9F1E-11E3-8C62-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242751>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> See my branch on GitHub [1] or read the appended text below.

Very nice.

> ## Introduction
>
> It is strongly recommended that students who want to apply to the Git
> project for the Summer of Code 2014 should submit a small code-related
> patch to the Git project as part of their application.  Think of these
> microprojects as the "Hello, world" of getting involved with the Git
> project; the coding aspect of the change can be almost trivial, but to
> make the change the student has to become familiar with many of the
> practical aspects of working on the Git project:

I'd suggest one step before all of the below.  

 * Here (http://thread.gmane.org/{TBD1,TBD2,TBD3...}) are a sample
   set of threads that show how a change and a patch to implement it
   is proposed by a developer X, the problem it attempts to solve,
   the design of the proposed solution and the implementation of
   that design are reviewed and discussed, and that after several
   iterations it resulted in inclusion to our codebase.  As a GSoC
   student, you will be playing the role of X and engaging in a
   similar discussion.  Get familar with the flow, need for clarity
   on both sides (i.e. you need to clearly defend your design, and
   need to ask clarifications when questions/suggestions you are
   offered are not clear enough), the pace at which the discussion
   takes place, and the general tone of the discussion, to learn
   what is expected of you.

That would help the later step, namely:

> * Expect feedback, criticism, suggestions, etc. from the mailing list.
>
>   *Respond to it!* and follow up with improved versions of your
>   change.  Even for a trivial patch you shouldn't be surprised if it
>   takes two or more iterations before your patch is accepted.  *This
>   is the best part of the Git community; it is your chance to get
>   personalized instruction from very experienced peers!*
