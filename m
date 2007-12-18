From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git with custom diff for commits
Date: Tue, 18 Dec 2007 13:38:38 -0800
Message-ID: <7vir2vy97l.fsf@gitster.siamese.dyndns.org>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
	<vpq1w9kaphg.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712172310090.9446@racer.site>
	<7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
	<vpqk5ncz8fn.fsf@bauges.imag.fr>
	<7vodco1him.fsf@gitster.siamese.dyndns.org>
	<000001c841b5$89fcef00$762a14ac@na.acco.com>
	<7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
	<000101c841b7$5f1d1060$762a14ac@na.acco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@imag.fr>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "Gerald Gutierrez" <ggmlfs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4k9y-0001lj-7Q
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 22:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbXLRVjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 16:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752948AbXLRVjH
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 16:39:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61460 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbXLRVjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 16:39:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 820896D24;
	Tue, 18 Dec 2007 16:38:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B5D046D01;
	Tue, 18 Dec 2007 16:38:42 -0500 (EST)
In-Reply-To: <000101c841b7$5f1d1060$762a14ac@na.acco.com> (Gerald Gutierrez's
	message of "Tue, 18 Dec 2007 12:48:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68822>

"Gerald Gutierrez" <ggmlfs@gmail.com> writes:

> I thought that's what the external diff capability is for,...

It certainly is.  Your external diff gets all the information it needs
to generate whatever custom diff computation it may want to do.
