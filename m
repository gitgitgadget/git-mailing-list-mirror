From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: handle CVS 'noop' command.
Date: Thu, 29 Jan 2009 15:46:17 -0800
Message-ID: <7vhc3hd6ba.fsf@gitster.siamese.dyndns.org>
References: <1232144521-21947-1-git-send-email-stefan.karpinski@gmail.com>
 <1233264914-7798-1-git-send-email-stefan.karpinski@gmail.com>
 <7v7i4denpg.fsf@gitster.siamese.dyndns.org>
 <d4bc1a2a0901291539m636f0fc8s5d9280ce9b7d22b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 00:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSgbu-00087q-Nc
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 00:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbZA2XqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 18:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZA2XqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 18:46:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbZA2XqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 18:46:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB6BF94996;
	Thu, 29 Jan 2009 18:46:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C24C494987; Thu,
 29 Jan 2009 18:46:19 -0500 (EST)
In-Reply-To: <d4bc1a2a0901291539m636f0fc8s5d9280ce9b7d22b2@mail.gmail.com>
 (Stefan Karpinski's message of "Thu, 29 Jan 2009 15:39:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 08D11D18-EE5F-11DD-9893-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107755>

Stefan Karpinski <stefan.karpinski@gmail.com> writes:

> So apparently a response *is* expected. I'm not really familiar enough
> with CVS or git-cvsserver to determine what that means it should do,
> but I suspect from perusing the code that req_EMPTY is the appropriate
> action.
>
> Moreover, I've moved on from using git-cvsserver myself, having
> instead convinced my Windows-using compatriots to use msysgit instead.
> So if you feel that this change is unwarranted, feel free to just drop
> it.

Because the issue currently has our attention, and we think we know that
the code does not do the right thing currently, and that we are fairly
sure that the right thing is to do req_EMPTY, I'd rather see a tested fix
applied so that we can forget about it ;-)

It's good that you moved your people to native git environment, but if you
have an environment where you can test the fix still lying around, I'd
appreciate a quick test and resubmit.
