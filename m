From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RESEND] gitweb: Fix snapshots requested via PATH_INFO
Date: Mon, 20 Apr 2009 03:41:07 -0700
Message-ID: <7v7i1fip4s.fsf@gitster.siamese.dyndns.org>
References: <20090414104648.GA36554444@CIS.FU-Berlin.DE>
 <7vvdp6xvv3.fsf@gitster.siamese.dyndns.org>
 <200904151934.10253.jnareb@gmail.com> <m3iqkzps96.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Holger =?utf-8?Q?Wei=C3=9F?= <holger@zedat.fu-berlin.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:42:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvqxd-0002pW-34
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbZDTKlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754008AbZDTKlQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:41:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbZDTKlP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:41:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A2373109D6;
	Mon, 20 Apr 2009 06:41:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0B98109D5; Mon,
 20 Apr 2009 06:41:09 -0400 (EDT)
In-Reply-To: <m3iqkzps96.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Mon, 20 Apr 2009 02:52:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C59C300A-2D97-11DE-92EA-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116963>

Jakub Narebski <jnareb@gmail.com> writes:

> Ping!  This is quite straighforward bugfix for a new feature...
>
>> By the way, if there was check added for full path_info snapshot URL in
>> existing t/t9500-gitweb-standalone-no-errors.sh it would caught this
>> bug thanks to the
>>   "Odd number of elements in hash assignment ..."
>> warning that Perl throws in this case. 
>
> ... or are you waiting for test case?

Yeah, I somehow misinterpreted that you are saying you will follow up with
an additional test to cover this, and while I was waiting I got busy and
forgot.
