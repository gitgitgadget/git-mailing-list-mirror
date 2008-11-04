From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in
 packs with a .keep file
Date: Tue, 04 Nov 2008 11:55:53 -0800
Message-ID: <7vmygfqn92.fsf@gitster.siamese.dyndns.org>
References: <20081103161202.GJ15463@spearce.org>
 <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <49109FD4.30003@op5.se> <V78jOMhdYwpSlLU-YzsqEHZxJyrvKbXRQbKsuNPZOEtB8E0kZ5Wi7Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:57:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxS1o-0005af-5f
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 20:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbYKDT4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 14:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbYKDT4N
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 14:56:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbYKDT4M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 14:56:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A46493BA2;
	Tue,  4 Nov 2008 14:56:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7AAC293BA0; Tue,  4 Nov 2008 14:55:55 -0500 (EST)
In-Reply-To: <V78jOMhdYwpSlLU-YzsqEHZxJyrvKbXRQbKsuNPZOEtB8E0kZ5Wi7Q@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue, 04 Nov 2008 13:49:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A0E68492-AAAA-11DD-96C5-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100100>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Andreas Ericsson wrote:
>
>> sed 1q is faster, as it stops parsing after the first line (the same as
>> 'head
>> -n 1' does, but in a more portable fashion).

If your sed is GNU, and you are doing this for a small file, the startup
cost of it may dwarf such gain ;-)

> Except that I wanted all but the _last_ line though.
>
> I didn't think about using sed. Perhaps I could have used something like
>
>    sed -n -e '$q' -e 'p'

You surely meant "sed -e '$d'", right?

> The grep works though.

Indeed.
