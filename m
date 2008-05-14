From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 15:12:05 -0700
Message-ID: <7vod78k022.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141802480.30431@racer>
 <alpine.DEB.1.00.0805141803240.30431@racer>
 <7vbq38oi3j.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805141940460.30431@racer>
 <7vy76cn1aq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0805142308400.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 15 00:13:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPDc-0003tz-8E
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbYENWMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 18:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756537AbYENWMN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:12:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49545 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756274AbYENWMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 18:12:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A4A92F7A;
	Wed, 14 May 2008 18:12:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C82C72F76; Wed, 14 May 2008 18:12:07 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805142308400.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 23:09:07 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CC66759A-2202-11DD-B045-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82152>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 14 May 2008, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > The point is: for the sake of a script (which wants to ignore 
>> > submodules) asking if there is a diff, I think it makes sense to not 
>> > ignore those changes.  IOW I think my patch is enough for the purpose 
>> > of getting stash/rebase to behave.
>> 
>> But the patch is not about stash/rebase but affects all diff users, 
>> doesn't it?
>
> Does it?  I thought I hid all that special handling behind the 
> --ignore-submodules options.

That's exactly the point.  The option reads "ignore submodules", not
"special option for use only by stash and rebase".
