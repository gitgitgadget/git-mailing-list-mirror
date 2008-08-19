From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] adapt git-cvsserver manpage to dash-free syntax
Date: Tue, 19 Aug 2008 00:43:33 -0700
Message-ID: <7vy72tfo0p.fsf@gitster.siamese.dyndns.org>
References: <20080818141704.GC11842@schiele.dyndns.org>
 <7v3al1lunw.fsf@gitster.siamese.dyndns.org>
 <20080819071235.GD11842@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 09:44:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVLtU-0005Xv-1H
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 09:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbYHSHnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 03:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYHSHnk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 03:43:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33385 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626AbYHSHnk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 03:43:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9F215A00B;
	Tue, 19 Aug 2008 03:43:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 032075A00A; Tue, 19 Aug 2008 03:43:35 -0400 (EDT)
In-Reply-To: <20080819071235.GD11842@schiele.dyndns.org> (Robert Schiele's
 message of "Tue, 19 Aug 2008 09:12:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 896973D0-6DC2-11DD-B92F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92824>

Robert Schiele <rschiele@gmail.com> writes:

> On Mon, Aug 18, 2008 at 05:23:31PM -0700, Junio C Hamano wrote:
>> Thanks; have you tested these instructions, by the way (I haven't)?
>
> You mean whether I tested that replacing "git-cvsserver" by "git cvsserver" in
> CVS_SERVER does work?  Yes, I did with cvs 1.12.12 on Linux.  I had concerns
> myself because of the space, especially in the syntax where CVS_SERVER is
> inlined into the CVSROOT but everything worked without any issues as long as
> you quoted the strings correctly.

Thanks.  I did that myself after I sent the message to you, as I wanted to
queue this documentation update of yours for 'maint' track for 1.6.0.1.
