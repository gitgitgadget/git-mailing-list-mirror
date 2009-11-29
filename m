From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git merge" merges too much!
Date: Sat, 28 Nov 2009 21:15:05 -0800
Message-ID: <7vskbxewti.fsf@alter.siamese.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: The Git Mailing List <git@vger.kernel.org>
To: "Greg A. Woods" <woods@planix.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 06:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEc80-0000dx-4u
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 06:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbZK2FPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 00:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbZK2FPI
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 00:15:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZK2FPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 00:15:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AA2883038;
	Sun, 29 Nov 2009 00:15:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lM6Q+qrR1CaQ0jjTXI4o9V8BhBM=; b=Bc4NiT
	3BtAxhHIY9Li9MHIy41o5YQ8eYWr4iUKLVuj9+zg/GD0N/vhavm83fjDNI25yCUu
	7Z7CxaTs5qg/T8UOXBR96nbovwaZ4oeBmEdKYa1oG1ssv1Ef+d1X7BdHhFknrV0r
	Pp4jtmHa57kr54UThlYhMd3tN+plKajb/XMG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mfU0OR5tpWbfqClEPDf6/RZC01jV9q9J
	0oUSIw/L/CfXDObWxD/KQRECjrm5aCYHV/mvUjeBmvJxtQZgLVkordkP5zzbzKKx
	y3Q4IQiSK78tevSu/Dce3lV3mpWDyDYRDwhkYBAVSvw+6lEgUilF2zRKW/cikyEv
	UmBxKjNCzSo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68B3883037;
	Sun, 29 Nov 2009 00:15:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8194483035; Sun, 29 Nov
 2009 00:15:06 -0500 (EST)
In-Reply-To: <m1NEaLp-000kn1C@most.weird.com> (Greg A. Woods's message of
 "Sat\, 28 Nov 2009 22\:21\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 29F03CC8-DCA6-11DE-BBDC-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133994>

In order to make things smoother and easier in the future, you may want to
learn "topic branch" workflows (found in many git tutorial material).

But it is too late for the history you already created; "cherry-pick" is
your friend to recover from the shape of your existing history.
