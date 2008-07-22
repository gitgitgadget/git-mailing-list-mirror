From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bring description of git diff --cc up to date
Date: Tue, 22 Jul 2008 10:09:17 -0700
Message-ID: <7v63qxn8w2.fsf@gitster.siamese.dyndns.org>
References: <20080722111947.BIW29914@m4500-01.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLNY-0001mB-4i
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 19:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbYGVRJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752288AbYGVRJZ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 13:09:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYGVRJY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 13:09:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 609104086A;
	Tue, 22 Jul 2008 13:09:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CA86B40866; Tue, 22 Jul 2008 13:09:19 -0400 (EDT)
In-Reply-To: <20080722111947.BIW29914@m4500-01.uchicago.edu> (Jonathan
 Nieder's message of "Tue, 22 Jul 2008 11:19:47 -0500 (CDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EE6D1C40-5810-11DD-8968-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89504>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> Just to make sure I understand, here is what I think --cc does:
>
>   - In a two-parent merge, it is exactly as Linus has been
>     ...
>   - In a many-parent merge, the criterion is more stringent.
>     ...
>
> Is that correct?

The logic in the code does not have separate criteria for two-parent and
Octopus cases.  Actually Linus talks about "when you have two versions to
choose from, and if the result matches one of them, then it is not
interesting".  In a two-parent merge, you cannot have three or more
possible versions to choose from by definition, can you?
