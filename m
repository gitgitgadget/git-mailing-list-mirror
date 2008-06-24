From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pre-commit hook should ignore carriage returns at EOL
Date: Tue, 24 Jun 2008 16:39:46 -0700
Message-ID: <7vbq1q9zct.fsf@gitster.siamese.dyndns.org>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com>
 <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site>
 <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com>
 <7v3an2bh3b.fsf@gitster.siamese.dyndns.org>
 <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com>
 <m3k5gejtkp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:40:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBI86-0004Zt-Mx
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYFXXj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbYFXXj6
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:39:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYFXXj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:39:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F057E99FF;
	Tue, 24 Jun 2008 19:39:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4658899FE; Tue, 24 Jun 2008 19:39:49 -0400 (EDT)
In-Reply-To: <m3k5gejtkp.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 24 Jun 2008 16:34:35 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D8941930-4246-11DD-A789-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86185>

Jakub Narebski <jnareb@gmail.com> writes:

> Christian Holtje <docwhat@gmail.com> writes:
>
>> Based on the information about core.whitespace doesn't git do this
>> already?  Maybe we should just delete the pre-commit hook or make it
>> empty with a note saying what you can do with it?
>
> pre-commit hook also detects unresolved merge conflicts, which
> core.whitespace doesn't (and probably shouldn't).

But perhaps "diff --check" should.
