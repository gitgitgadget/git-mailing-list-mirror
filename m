From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-gc doesn't clean up leftover objects after git-filter-branch
 unless you clone first
Date: Wed, 23 Apr 2008 10:00:59 -0700
Message-ID: <7vve28sdys.fsf@gitster.siamese.dyndns.org>
References: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:02:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoiM5-0005HP-SA
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 19:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbYDWRBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 13:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYDWRBO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 13:01:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43463 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYDWRBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 13:01:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C0AC346F;
	Wed, 23 Apr 2008 13:01:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7AE4D346D; Wed, 23 Apr 2008 13:01:08 -0400 (EDT)
In-Reply-To: <32541b130804230841h32c07f3arc94cccfaf0b156a3@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 23 Apr 2008 11:41:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80231>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> This question has come up at least once a week since I subscribed to
> the list.  I can think of these solutions:
>
> - Add a note to the git-gc and/or git-repack man page about how hidden
> refs can impact the cleanup.
>
> - Add an option to make git-clone *not* hardlink stuff; its different
> behaviour for hardlinking vs. file:// seems to be very confusing.
>
> - Make git-gc give a warning when there are some objects that are only
> referenced via the reflog or refs/original.  (I suspect this would
> trigger too often though.)
>
> - Give git-gc a "really, I'm serious" option that makes it ignore the
> reflog and refs/original.

- Teach people that leftover cruft is nothing to worry about.
