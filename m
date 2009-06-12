From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Fri, 12 Jun 2009 09:06:51 -0700
Message-ID: <7vr5xp8mhw.fsf@alter.siamese.dyndns.org>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch>
	<7v4ouqwa42.fsf@alter.siamese.dyndns.org>
	<200906091019.11000.trast@student.ethz.ch>
	<200906121348.19103.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 12 18:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF9Hd-0007LV-EO
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 18:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546AbZFLQHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 12:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757852AbZFLQHB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 12:07:01 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47031 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757523AbZFLQHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 12:07:00 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612160651.LSJP2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Fri, 12 Jun 2009 12:06:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 346r1c00K4aMwMQ0446ryl; Fri, 12 Jun 2009 12:06:52 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=fC4PegqPu0EA:10 a=rURELfc3W64A:10
 a=JkNo4gaa03tFM0lBXnoA:9 a=PjioW1H0va0fL0lWHCcA:7
 a=ffdmnF6WyO8SgRJVIFkUM2HKw4cA:4
X-CM-Score: 0.00
In-Reply-To: <200906121348.19103.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 12 Jun 2009 13\:48\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121434>

Thomas Rast <trast@student.ethz.ch> writes:

> Thomas Rast wrote:
>> Junio C Hamano wrote:
>> > Thomas Rast <trast@student.ethz.ch> writes:
>> > 
>> > > Every so often, someone sends out an unedited cover-letter template.
>> > > Add a simple check to send-email that refuses to send if the subject
>> > > contains "*** SUBJECT HERE ***", with an option --force to override.
>> > 
>> > Good ;-).  More valuable to detect would be an empty "blurb" section
>> > (i.e. not "unedited *** BLURB HERE ***" string, but literally, there is
>> > nothing said in the message other than the shortstat).
> ...
> What do you want me to do about the patch?  Should I extend it so that
> it traps both "*** BLURB HERE ***" and "*** SUBJECT HERE ***"?

Oh, nothing.

I did not mean to say "if you do not add this unrelated thing, your patch
is not acceptable."  Please take my "oh I wish there is another feature to
do this similar but different thing" as a hint for possible follow-up
patches, and they do not necessarily have to be done by you but can be
done by anybody, or for that matter they do not have to be done by anybody
like this particular case where it turns out to be "why bother?  it cannot
be done sensibly and usefully".

Thanks, and sorry.  I'll try to be more explicit next time.
