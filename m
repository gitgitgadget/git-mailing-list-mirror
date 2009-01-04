From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rev-parse --symbolic-abbrev-name
Date: Sun, 04 Jan 2009 11:36:33 -0800
Message-ID: <7v63kuyibi.fsf@gitster.siamese.dyndns.org>
References: <quack.20090101T1928.lthzliaqtdf@roar.cs.berkeley.edu>
 <402731c90901012026j470f35ffj1eaa189a837054f3@mail.gmail.com>
 <quack.20090103T1818.lth7i5bg6f7@roar.cs.berkeley.edu>
 <20090104033839.GD21154@genesis.frugalware.org>
 <quack.20090103T2026.lth3afzg0hx@roar.cs.berkeley.edu>
 <7vzli73b1g.fsf@gitster.siamese.dyndns.org>
 <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	David Aguilar <davvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Sun Jan 04 20:38:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJYny-0008Gx-Mx
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 20:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756811AbZADTgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 14:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755676AbZADTgo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 14:36:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39065 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZADTgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 14:36:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6DA2D1BCA4;
	Sun,  4 Jan 2009 14:36:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B93B21BCA3; Sun, 
 4 Jan 2009 14:36:35 -0500 (EST)
In-Reply-To: <quack.20090104T0434.lthfxjz1c8x_-_@roar.cs.berkeley.edu> (Karl
 Chen's message of "Sun, 04 Jan 2009 04:34:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02E381A6-DA97-11DD-BD3E-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104536>

Karl Chen <quarl@cs.berkeley.edu> writes:

> ... you really think "branchfoo" instead of
> "refs/heads/branchfoo" is a narrow special case?

Of course it is narrower.  There are namespaces other than "heads" under
refs, and not everybody is interested in branches.

> obviously all those people posting on blogs don't know about it :)

Yes, and that won't be helped by any new option to the plumbing.

The above two does not necessarily mean that it is useless to add a new
option to help a narrow special case that is common, though.
