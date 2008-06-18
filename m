From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 12:13:29 -0700
Message-ID: <7vzlpiy2sm.fsf@gitster.siamese.dyndns.org>
References: <1213796224-995-1-git-send-email-michael@ndrix.org>
 <m37icmol6y.fsf@localhost.localdomain>
 <alpine.DEB.1.00.0806181756540.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael Hendricks <michael@ndrix.org>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:14:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K937I-0006W1-Pp
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 21:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYFRTNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 15:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYFRTNw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 15:13:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53808 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYFRTNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 15:13:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0417F1686C;
	Wed, 18 Jun 2008 15:13:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 281DB16868; Wed, 18 Jun 2008 15:13:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806181756540.6439@racer> (Johannes
 Schindelin's message of "Wed, 18 Jun 2008 18:00:14 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ABDA08C2-3D6A-11DD-B574-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85400>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 18 Jun 2008, Jakub Narebski wrote:
>
>> Michael Hendricks <michael@ndrix.org> writes:
>> 
>> > Instead of using IO::String to create an in-memory filehandle, use 
>> > open() with a scalar reference as the filename.  This feature has been 
>> > available since Perl 5.8.0 (which was released in 2002), so it should 
>> > be available pretty much everywhere by now.
>> 
>> Besides if I understand correctly gitweb very much requires Perl >= 5.8 
>> because of required Unicode support.
>
> Did I miss something?  Was this patch not more about Git.pm?
>
> BTW I think it is not nice at all how the dependency hell with Git.pm is 
> made worse recently.
>
> It is fascinating through how much _pain_ we go with the shell scripts to 
> maintain portability, even with _very_ old or obscure systems (see the SCO 
> server patches that came in not long ago!), and just walk over that 
> portability when it comes to Perl...

Hey, calm down a bit and give me a bit more credit.  I am not that stupid.
I've looked at the patch, and it is parked in 'pu', not near 'next'.
