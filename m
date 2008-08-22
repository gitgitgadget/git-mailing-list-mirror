From: Junio C Hamano <gitster@pobox.com>
Subject: Re: About git pretty
Date: Fri, 22 Aug 2008 16:41:01 -0700
Message-ID: <7vd4k062k2.fsf@gitster.siamese.dyndns.org>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWgGj-00065K-OI
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbYHVXlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754973AbYHVXlI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:41:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbYHVXlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:41:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 15E9664956;
	Fri, 22 Aug 2008 19:41:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 54D0C64955; Fri, 22 Aug 2008 19:41:03 -0400 (EDT)
In-Reply-To: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
 (Felipe Contreras's message of "Sat, 23 Aug 2008 02:24:34 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C9EE1616-70A3-11DD-AABC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93403>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> Please read aloud the following commands:
> git log --pretty=short
> git log --pretty=full
> git log --pretty=format:%s
>
> It is just me or 'pretty full' doesn't exactly convey the meaning of
> the action to execute?
>
> How about:
> git log --format=short
> git log --format=full
> git log --format=custom:%s
>
> If you like the idea I can work on a patch.

FWIW, I don't like it.
