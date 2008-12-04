From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Wed, 03 Dec 2008 16:40:46 -0800
Message-ID: <7v4p1k93ht.fsf@gitster.siamese.dyndns.org>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7vy6yw95ln.fsf@gitster.siamese.dyndns.org>
 <cb7bb73a0812031620s2459f773q3db33971e3507b2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <pasky@suse.cz>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 01:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L82IF-0005Uh-Tb
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 01:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbYLDAkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 19:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbYLDAkz
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 19:40:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbYLDAkz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 19:40:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 38EB7180CC;
	Wed,  3 Dec 2008 19:40:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5DDFB180CB; Wed, 
 3 Dec 2008 19:40:47 -0500 (EST)
In-Reply-To: <cb7bb73a0812031620s2459f773q3db33971e3507b2f@mail.gmail.com>
 (Giuseppe Bilotta's message of "Thu, 4 Dec 2008 01:20:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 352D6BFE-C19C-11DD-9CC9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102312>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> No, as extra 'email' headers, similarly to what commitdiff_plain does.
> It might or might not make sense, and might or might not be worth the
> effort.

I tend to agree; the point of this 'patch' feature is to give something
you can feed "am" with, and "am" certainly would discard such extra
garbage headers as uninteresting, so there is no point to add such
headers. 
