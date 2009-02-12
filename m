From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Support "\" in non-wildcard exclusion entries
Date: Thu, 12 Feb 2009 13:03:45 -0800
Message-ID: <7v7i3vl64u.fsf@gitster.siamese.dyndns.org>
References: <20090210121149.GA1226@pvv.org>
 <alpine.DEB.1.00.0902101354460.10279@pacific.mpi-cbg.de>
 <20090210125800.GA14800@pvv.org>
 <alpine.DEB.1.00.0902101402230.10279@pacific.mpi-cbg.de>
 <20090210142017.GA16478@pvv.org>
 <alpine.DEB.1.00.0902101525380.10279@pacific.mpi-cbg.de>
 <20090210143742.GB16478@pvv.org> <7vab8upb5v.fsf@gitster.siamese.dyndns.org>
 <7v7i3ynt1z.fsf@gitster.siamese.dyndns.org> <20090212093250.GA9623@pvv.org>
 <alpine.DEB.1.00.0902121143560.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiko-0008UB-NF
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760568AbZBLVDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756529AbZBLVDx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:03:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760549AbZBLVDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:03:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F5252AFEC;
	Thu, 12 Feb 2009 16:03:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 330E82AA64; Thu,
 12 Feb 2009 16:03:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A6AF9B74-F948-11DD-ABA5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109653>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 12 Feb 2009, Finn Arne Gangstad wrote:
>
>> @@ -82,6 +88,7 @@ test_expect_success \
>>  cat > excludes-file << EOF
>>  *.[1-8]
>>  e*
>> +\#*
>>  EOF
>
> You addressed all comments, except the \EOF comment, I guess.

Thanks; I'll amend the one queued in 'pu' for the last few days, which
matches this round.
