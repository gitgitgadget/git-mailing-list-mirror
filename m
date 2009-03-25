From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .git/index
Date: Wed, 25 Mar 2009 11:02:03 -0700
Message-ID: <7v1vsl7a78.fsf@gitster.siamese.dyndns.org>
References: <9e4733910903251016n117c37fdp94f91b2862cd7bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXS4-0002Kr-QP
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbZCYSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbZCYSCM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:02:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbZCYSCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:02:11 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 606D3A5B65;
	Wed, 25 Mar 2009 14:02:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D728A5B64; Wed,
 25 Mar 2009 14:02:05 -0400 (EDT)
In-Reply-To: <9e4733910903251016n117c37fdp94f91b2862cd7bf@mail.gmail.com>
 (Jon Smirl's message of "Wed, 25 Mar 2009 13:16:59 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E865A1A-1967-11DE-AB67-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114630>

The index is associated with the work tree.  Since gitweb is supposed to
read and show the history and never the work tree state, it would be a bug
if it required it to operate.
