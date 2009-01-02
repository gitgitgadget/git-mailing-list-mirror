From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] rebase: learn to rebase root commit
Date: Fri, 02 Jan 2009 15:07:56 -0800
Message-ID: <7vhc4hb92r.fsf@gitster.siamese.dyndns.org>
References: <200812301323.30550.trast@student.ethz.ch>
 <200901022320.14055.trast@student.ethz.ch>
 <7vzli9b9y6.fsf@gitster.siamese.dyndns.org>
 <200901022354.17922.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Jan 03 00:09:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIt8x-0002Hp-Jm
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 00:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757503AbZABXIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757281AbZABXIF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 18:08:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989AbZABXID (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 18:08:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 529101BA07;
	Fri,  2 Jan 2009 18:08:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF5951BA08; Fri, 
 2 Jan 2009 18:07:57 -0500 (EST)
In-Reply-To: <200901022354.17922.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri, 2 Jan 2009 23:54:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 33DD9240-D922-11DD-94B7-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104445>

Thomas Rast <trast@student.ethz.ch> writes:

>> ${1+"$@"} should be equivalent to "$@" in modern Bourne shell variants
>> that are POSIX compliant.
>
> So do you want me to change it back to ${1+"$@"}?

No.  I was merely answering your question.
