From: Junio C Hamano <gitster@pobox.com>
Subject: Re: epic fsck SIGSEGV!
Date: Wed, 10 Dec 2008 17:52:50 -0800
Message-ID: <7vskovwk99.fsf@gitster.siamese.dyndns.org>
References: <1228867861.14165.19.camel@starfruit.local>
 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
 <1228949523.27061.20.camel@starfruit.local>
 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
 <alpine.LFD.2.00.0812102031440.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"R. Tyler Ballance" <tyler@slide.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 02:54:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAakz-000103-J7
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 02:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbYLKBxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 20:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753780AbYLKBxA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 20:53:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbYLKBxA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 20:53:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1065985D15;
	Wed, 10 Dec 2008 20:52:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9CEC85D12; Wed,
 10 Dec 2008 20:52:52 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812102031440.14328@xanadu.home> (Nicolas
 Pitre's message of "Wed, 10 Dec 2008 20:33:36 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FDECE20-C726-11DD-B73D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102766>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 10 Dec 2008, Linus Torvalds wrote:
>
>> But we should definitely fix this braindamage in fsck. Rather than 
>> recursively walk the commits, we should add them to a commit list and just 
>> walk the list iteratively.
>
> What about:
>
> 	http://marc.info/?l=git&m=122889563424786&w=2

I have to dig that out of the mail archive (quoting message-id or $gmane
article number would have been easier for me), but should I take it as an
Ack from you?
