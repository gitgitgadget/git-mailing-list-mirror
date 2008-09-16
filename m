From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Tue, 16 Sep 2008 09:34:25 -0700
Message-ID: <7vprn46odq.fsf@gitster.siamese.dyndns.org>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
 <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
 <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
 <200809160205.23371.trast@student.ethz.ch>
 <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com>
 <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
 <32541b130809160858k3c019f6pdc4831c831e22b55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 18:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfdWk-0003pu-1j
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 18:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYIPQeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 12:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbYIPQeh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 12:34:37 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbYIPQeg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 12:34:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E24A6009E;
	Tue, 16 Sep 2008 12:34:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 79A8A60097; Tue, 16 Sep 2008 12:34:28 -0400 (EDT)
In-Reply-To: <32541b130809160858k3c019f6pdc4831c831e22b55@mail.gmail.com>
 (Avery Pennarun's message of "Tue, 16 Sep 2008 11:58:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57DACA4C-840D-11DD-8132-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96015>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Hmm, browsing around through a newer asciidoc package from Ubuntu, it
> appears that in asciidoc 8, those lines are in an
> "ifdef::asciidoc7compatible[]" section.  But the quoting mechanism in
> 8 appears to be improved.

Yeah, the thing is that we cannot say "ifdef::asciidoc7compatible[]"
and feed it to asciidoc7 X-<.
