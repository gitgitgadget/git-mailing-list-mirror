From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: add merge_recursive.h to LIB_H
Date: Tue, 02 Sep 2008 15:39:57 -0700
Message-ID: <7vfxoii342.fsf@gitster.siamese.dyndns.org>
References: <b96b1e10babd379daea483e72d99d8e520e34506.1220392547.git.vmiklos@frugalware.org> <1220393639-20433-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:41:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaeYj-0003gi-9g
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbYIBWkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYIBWkH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:40:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbYIBWkG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:40:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC0E5701B9;
	Tue,  2 Sep 2008 18:40:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C4A86701B7; Tue,  2 Sep 2008 18:39:59 -0400 (EDT)
In-Reply-To: <1220393639-20433-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Wed, 3 Sep 2008 00:13:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15AD9564-7940-11DD-B493-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94731>

Miklos Vajna <vmiklos@frugalware.org> writes:

> When modifying merge-recursive.h, for example builtin-merge-recursive.c
> have to be recompiled which was not true till now, causing various
> runtime errors using an incremental build.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Wed, Sep 03, 2008 at 12:05:32AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> Subject: Re: [PATCH 1/2] merge-recursive: move call_depth to struct
>>       merge_options
>
> While testing this one, I got some weird errors, finally they gone after
> a 'touch builtin-merge-recursive.c', I guess this is the right fix.

Thanks.
