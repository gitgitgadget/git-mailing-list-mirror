From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9200: let "cvs init" create the test repository
Date: Mon, 24 Dec 2012 17:49:37 -0800
Message-ID: <7vmwx2nbny.fsf@alter.siamese.dyndns.org>
References: <7vr4mflyxu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 25 02:50:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnJeg-0006gm-IF
	for gcvg-git-2@plane.gmane.org; Tue, 25 Dec 2012 02:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab2LYBtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 20:49:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab2LYBtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 20:49:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 045DCA703;
	Mon, 24 Dec 2012 20:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N1x42VeGhYivWrG7mn8+w9Acd/w=; b=vRa48Y
	y3Lu6qVB+OsBYbQXqmJEIEGE1xrR6KwebSOkoDnlbRfC/gdkWj75nn2L805SkD4v
	dW5pBrnTBtMTJibOVObY0kI9QYmJgH4+NN7CyqYd5ghv+BRJBERXKrjkq028qglx
	gHJ0cNPj8fT6hXqUO1htc/raQ/3FTQDI97ajo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIJFMcAn25d0uktCiJ+dW3MHv654WtRh
	lffkwKAGyKut95zlUQTi+yW8+mSpFTEFTXr7JmxEdFlQnwRwwjQBMDntg8lYYczM
	Auu1D4F6NR9cUtdmljr/kYcizsANFvdF+dgjbOaNGoPGjpeL68pfKSpRjqPSwpkt
	dUIaaW4Y7WY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D54A702;
	Mon, 24 Dec 2012 20:49:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 645CAA701; Mon, 24 Dec 2012
 20:49:39 -0500 (EST)
In-Reply-To: <7vr4mflyxu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 24 Dec 2012 17:09:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 582E0F76-4E35-11E2-933E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212122>

Junio C Hamano <gitster@pobox.com> writes:

> Some platforms (e.g. NetBSD 6.3) seem to configure their CVS to

s/6.3/6.0/; sorry for the noise.
