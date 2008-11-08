From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Fri, 07 Nov 2008 16:47:46 -0800
Message-ID: <7vd4h7dowd.fsf@gitster.siamese.dyndns.org>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
 <20081101220319.1116.50509.stgit@gandelf.nowhere.earth>
 <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org>
 <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net>
 <7v3ai3gugt.fsf@gitster.siamese.dyndns.org>
 <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net>
 <7vskq3fdgz.fsf@gitster.siamese.dyndns.org>
 <20081107221224.GK5158@nan92-1-81-57-214-146.fbx.proxad.net>
 <7vhc6jdrvs.fsf@gitster.siamese.dyndns.org>
 <20081108002952.GC4030@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 01:49:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyc10-0003wG-J0
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 01:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbYKHAsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752403AbYKHAsH
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 19:48:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55899 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbYKHAsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 19:48:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CCBB94879;
	Fri,  7 Nov 2008 19:48:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9F16694877; Fri, 
 7 Nov 2008 19:47:52 -0500 (EST)
In-Reply-To: <20081108002952.GC4030@nan92-1-81-57-214-146.fbx.proxad.net>
 (Yann Dirson's message of "Sat, 8 Nov 2008 01:29:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E61CCD42-AD2E-11DD-B06B-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100369>

Yann Dirson <ydirson@altern.org> writes:

> ...  Commands
> for saving/mailing patches could issue a bold warning if the user
> specifies the for-human-viewing flag.

If it is a warning to the user who produces the patch, and not but a
warning in the patch text for the user who receives it, it is not useful.

> I was talking about exchanging patches with the non-git part of the
> world.

Renaming patch needs manual massaging if you want to use GNU patch and
that is not a new issue.  People know that.

The problem is in your example output were that it would break _existing
git tools_ with a backward incompatible change, when you did not have to.
That's the difference.
