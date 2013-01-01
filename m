From: greened@obbligato.org
Subject: Re: [PATCH 5/8] Honor DESTDIR
Date: Tue, 01 Jan 2013 16:36:49 -0600
Message-ID: <87fw2kfs3i.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-6-git-send-email-greened@obbligato.org>
	<7vsj6k8tr8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqASw-0002Jl-F8
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3AAWh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:37:28 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48609 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752250Ab3AAWh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:37:26 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAZi-0001Gm-SO; Tue, 01 Jan 2013 16:44:47 -0600
In-Reply-To: <7vsj6k8tr8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 13:42:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > "David A. Greene"
    <greened@obbligato.org> writes: > >> From: Adam Tkac <atkac@redhat.com> >>
    >> Teach git-subtree's Makefile to honor DESTDIR. >> >> Author: Adam Tkac
    <atkac@redhat.com> >> >> Signed-off-by: Adam Tkac <atkac@redhat.com> >> >>
    Signed-off-by: David A. Greene <greened@obbligato.org> >> --- > > The contents
    of the patch looks sensible; the above is questionable > as all the other
    messages in this series, though. Did any of our > tools cause this failure?
    If s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212467>

Junio C Hamano <gitster@pobox.com> writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: Adam Tkac <atkac@redhat.com>
>>
>> Teach git-subtree's Makefile to honor DESTDIR.
>>
>> Author:    Adam Tkac <atkac@redhat.com>
>>
>> Signed-off-by:    Adam Tkac <atkac@redhat.com>
>>
>> Signed-off-by: David A. Greene <greened@obbligato.org>
>> ---
>
> The contents of the patch looks sensible; the above is questionable
> as all the other messages in this series, though.  Did any of our
> tools cause this failure?  If so I would like to know more about it.

What failure are you referring to?  When I used git send-email --author,
the Author: line was commented out.  I assumed I was supposed to
uncomment it.  Guess I was wrong.

I'll re-send the series since you pointed out a number of improvements.

                       -David
