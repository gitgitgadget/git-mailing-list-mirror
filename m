From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] test suite: Use 'say' to say something instead of
 'test_expect_success'
Date: Thu, 19 Mar 2009 04:16:39 -0700
Message-ID: <7vd4cdahk8.fsf@gitster.siamese.dyndns.org>
References: <cover.1237410682.git.j6t@kdbg.org>
 <199f6a5e20f857a53af50872927a8086ce221345.1237410682.git.j6t@kdbg.org>
 <alpine.DEB.1.00.0903182306020.10279@pacific.mpi-cbg.de>
 <49C1F8D6.1060309@viscovery.net>
 <alpine.DEB.1.00.0903191128120.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 12:18:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkGGa-0000Tm-2D
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 12:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbZCSLQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 07:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbZCSLQr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 07:16:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbZCSLQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 07:16:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A22BC7585;
	Thu, 19 Mar 2009 07:16:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F17797584; Thu,
 19 Mar 2009 07:16:40 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903191128120.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 19 Mar 2009 11:29:08 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6DFB5A44-1477-11DE-BF7D-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113761>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 19 Mar 2009, Johannes Sixt wrote:
>
>> Johannes Schindelin schrieb:
>> 
>> > I see that you exchanged one "say_color" by "say".  What is the 
>> > difference?
>> 
>> The color. It's a change towards consistency. I figured that the command 
>> to use by the tests is "say", while "say_color" is an implementation 
>> detail of test-lib.sh.
>
> Fair enough.  Could you say that in the commit message, too,...

Have done so already.
