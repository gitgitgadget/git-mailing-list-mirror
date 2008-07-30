From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Compile fix for SCO OPenServer
Date: Wed, 30 Jul 2008 13:18:59 -0700
Message-ID: <7vk5f33z2k.fsf@gitster.siamese.dyndns.org>
References: <20071205172125.GF12636@yugib.highrise.ca>
 <20080730184956.GF10399@yugib.highrise.ca>
 <7vtze73zwg.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:20:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOI9c-0002Zn-QN
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYG3UTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbYG3UTJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:19:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbYG3UTI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:19:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 118E24334A;
	Wed, 30 Jul 2008 16:19:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F300C43348; Wed, 30 Jul 2008 16:19:01 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0807301403360.13032@xenau.zenez.com> (Boyd Lynn
 Gerber's message of "Wed, 30 Jul 2008 14:09:03 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C25528C2-5E74-11DD-8B77-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90849>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Wed, 30 Jul 2008, Junio C Hamano wrote:
>> Aidan Van Dyk <aidan@highrise.ca> writes:
>> > SCO OpenServer also hides the definitions of (at least) u_short and
>> > friends if _XOPEN_SOURCE is defined.
>> 
>> I thought that was covered by 457bb45 (Port to 12 other Platforms., 2008-06-08).
>
> I thought it was covered as well.
>
>> Sign-off?
>> 
>> Boyd, does this make any of the earlier symbols you added redundant?
>
> I have just tried this on 4 OpenServer 6.0 machines fresh installed and I 
> do not need this added.  I am trying to figure out what is different on 
> his.  It appears he is using the exact same version of the compiler as 
> well.
>
> My uname -a gives me this...
>
> SCO_SV tech0 5 6.0.0 i386
>
> and the gcc -V gives me the exact same compiler.  So I do not know why he 
> has to have the additional __OPENSERVER__.  This does break my OpenServer 
> 5.0.7 fresh install as well.  So I would not use it.  What I do not 
> understand is why the !defined(__USLC__) does not catch it.  It should.

Thanks for a prompt response.

Could you work with Aidan to come up with the optimal solution that does
not break anybody?  I won't queue this patch until the issue is sorted
out.
