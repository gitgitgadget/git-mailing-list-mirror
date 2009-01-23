From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Short "git commit $file" syntax fails in the face of a resolved
 conflict
Date: Thu, 22 Jan 2009 22:15:39 -0800
Message-ID: <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFLy-000102-D3
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZAWGPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbZAWGPu
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:15:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60611 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbZAWGPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:15:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 69E511D1D1;
	Fri, 23 Jan 2009 01:15:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 393B61D1C5; Fri,
 23 Jan 2009 01:15:41 -0500 (EST)
In-Reply-To: <20090123094509.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Fri, 23 Jan 2009 09:45:09 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46E8693E-E915-11DD-874B-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106838>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> But Nathan's first sentence is a different matter. I do not think it is
> coming from the same confusion, and I think the question is a valid
> one. Your answer does not explain why it is a bad idea to change the
> behavior of "git commit path" to what "git commit -i path" does during a
> merge.
>
> The answer of course can be "because it changes the behavior people are
> very much used to."

[jc: how many times do I have to ask you to wrap your lines, by the way?]

I tend to agree that "very much used to" argument carries much weight, but
I'll be sending a three-patch series to weatherbaloon the idea.
