From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 16:47:34 -0700
Message-ID: <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 01:48:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMX1l-00005B-FB
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 01:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbYGYXrs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 19:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbYGYXrs
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 19:47:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbYGYXrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 19:47:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 795933B82B;
	Fri, 25 Jul 2008 19:47:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2BD03B82A; Fri, 25 Jul 2008 19:47:36 -0400 (EDT)
In-Reply-To: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 (Scott Chacon's message of "Fri, 25 Jul 2008 10:35:43 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 10DA802A-5AA4-11DD-A3CF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90135>

I think counting merges in "The Authors of Git" statistics give quite
skewed numbers.  If you are generating it with "shortlog", you probably
would want to give --no-merges to the command line as well.  Also it
appears that you are not using .mailmap to avoid counting the same person
as different people.

I find a tabular list like this list easier to read if it were sorted like
this:

	A	D	G
        B	E	H
        C	F

i.e. not like this:

	A	B	C
        D	E	F
        G	H
