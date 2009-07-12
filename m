From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto-merge after push?
Date: Sun, 12 Jul 2009 14:30:44 -0700
Message-ID: <7vocrplhbv.fsf@alter.siamese.dyndns.org>
References: <20090511142326.GA18260@redhat.com>
 <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302>
 <20090511201705.GA21045@redhat.com>
 <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de>
 <20090611104020.GA12036@redhat.com> <20090711203831.GA10875@redhat.com>
 <alpine.DEB.1.00.0907120441440.3155@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 12 23:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ6dT-0008QN-R7
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 23:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbZGLVa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 17:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbZGLVa4
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 17:30:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbZGLVaz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 17:30:55 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E401327E79;
	Sun, 12 Jul 2009 17:30:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3014E27E78; Sun,
 12 Jul 2009 17:30:50 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0907120441440.3155@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun\, 12 Jul 2009 04\:42\:03 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 475CB464-6F2B-11DE-8FE8-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123160>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, I use it myself, what more can I say?

It's rather hard to justify a feature that is available to the general
public with documentation that only says "we tell you what happens in
terms of low-level commands when you use this feature, we warn you that
this has its own set of possible complications, but we do not specify what
they are, nor how to recover from them. You should know what you are doing
if you choose to use it".

That is not very helpful.

If this _were_ implemented as a sample hook on the receiving end, with
ample comments that the users can read to undersand the issues before
deciding to install it on their repositories, it might have been an easier
sell.

If Dscho is short on time, perhaps somebody else can improve upon the
documentation part of the patch?  It's a long time ago that I took a look
at the patch text itself but I had a recorrection that the code itself was
reasonable (and it is a well known fact that I tend not to notice bugs in
Dscho's code so it is not a very useful thing for me to go back to look at
the code again now when I am short on brain cycles).
