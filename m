From: Junio C Hamano <gitster@pobox.com>
Subject: Re: add -e, was Re: What's cooking in git.git (Apr 2009, #02; Sun,
 12)
Date: Tue, 14 Apr 2009 15:31:01 -0700
Message-ID: <7v7i1m3m1m.fsf@gitster.siamese.dyndns.org>
References: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904141943060.10279@pacific.mpi-cbg.de>
 <7vhc0r3wpq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0904142224030.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 00:33:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtrBb-00074I-0R
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 00:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbZDNWbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbZDNWbJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 18:31:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897AbZDNWbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 18:31:07 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B3B2E2E5;
	Tue, 14 Apr 2009 18:31:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9200DE2E4; Tue,
 14 Apr 2009 18:31:03 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904142224030.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 14 Apr 2009 22:25:55 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1A9BCF6-2943-11DE-816F-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116582>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Actually, I am beginning to hate the idea of having this in add -e, but 
> would prefer it to be in apply ("git apply $PATCH" could -- and should -- 
> complain when not being called with --unidiff-zero and encountering a 
> patch that should (but does not) have common context lines).

I think it already complains by rejecting.  The thing is, only "add -e"
knows that the patch being fed to apply is potentially manually corrupt by
the end user.
