From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Wed, 21 May 2008 10:30:20 -0700
Message-ID: <7vprrf4lar.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
 <200805121440.12836.jnareb@gmail.com>
 <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
 <200805131507.04912.jnareb@gmail.com>
 <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
 <7vlk29er1w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 21 19:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JysA9-0006Oj-Jy
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 19:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933638AbYEURag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 13:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbYEURaf
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 13:30:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933638AbYEURae (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 13:30:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1D436B59;
	Wed, 21 May 2008 13:30:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 405716B52; Wed, 21 May 2008 13:30:24 -0400 (EDT)
In-Reply-To: <7vlk29er1w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 May 2008 17:02:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B2ADB16-275B-11DD-B5B2-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82558>

Junio C Hamano <gitster@pobox.com> writes:

> "Sverre Rabbelier" <srabbelier@gmail.com> writes:
>
>>>  >>  Details I think need to be provided by maintainer...
>>>  >
>>>  > Do you mean Junio, or the user of the program?
>>>
>>>  I mean that all I can provide is speculation.  I'm not, and never was
>>>  a maintainer of OSS project, and I don't know what criteria one use
>>>  (perhaps unvoiced criteria) to decide whether given patch needs to be
>>>  examined more closely, or the cursory browsing should be enough.
>>
>> I reckon more input from actual maintainers would be needed then.
>> Junio: aside from the original list with suggestions you provided,
>> could you shine your light as git maintainer on this?
> ...
> Project maintainers and old timers become familiar with habits, strengths
> and weaknesses of known contributors over time, and that is the source of
> such trust.

I just realized another thing about "the source of trust".  The
"statistics" would count _only_ what gets accepted, but maintainers and
list participants have much richer set of datapoints to judge the
strengths and weaknesses of contributors --- rejects.

An early round of contribution from somebody needs deeper review if the
contributor has a history of taking many rounds of refinements to get a
rather trivial change into an acceptable shape.  IOW, over time people can
learn who are meticulous and who are careless from rejection counts, which
is not recorded in the committed history.
