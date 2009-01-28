From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] git-am: emit usage when called w/o arguments and 
 w/o patch on stdin
Date: Wed, 28 Jan 2009 10:10:43 -0800
Message-ID: <7v7i4fti70.fsf@gitster.siamese.dyndns.org>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
 <7vhc3kxdwm.fsf@gitster.siamese.dyndns.org>
 <76718490901280628y3761b41dhd2e544093e01e209@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sverre@rabbelier.nl
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:12:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEtd-0002VZ-Gp
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZA1SKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZA1SKw
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:10:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZA1SKv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:10:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6613194E03;
	Wed, 28 Jan 2009 13:10:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1A41894E01; Wed,
 28 Jan 2009 13:10:44 -0500 (EST)
In-Reply-To: <76718490901280628y3761b41dhd2e544093e01e209@mail.gmail.com>
 (Jay Soffian's message of "Wed, 28 Jan 2009 09:28:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FDF3E806-ED66-11DD-8CA4-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107555>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Tue, Jan 27, 2009 at 11:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jay Soffian <jaysoffian@gmail.com> writes:
>>
>>> +     test $# = 0 && test -t 0 && usage
>>
>> Sorry to be dense.  Why isn't your patch the above single liner?
>>
>
> "Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
> while it is processing input, but not if mailsplit exits non-zero due to
> error."

My point was why "Also" needs to be in the same commit.  Aren't they
separate issues?
