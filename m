From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: fix spurious error when run directly with
 Solaris /usr/xpg4/bin/sh
Date: Fri, 02 Mar 2012 14:41:14 -0800
Message-ID: <7v62embp85.fsf@alter.siamese.dyndns.org>
References: <7vd38uetls.fsf@alter.siamese.dyndns.org>
 <f2243a179ce49eed668341a6c0e3a452bf7ae79f.1330713761.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 23:41:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3bA9-0001i8-IS
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 23:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842Ab2CBWlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 17:41:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964821Ab2CBWlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 17:41:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8138176B7;
	Fri,  2 Mar 2012 17:41:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=uZXayV
	/bBhZ4PeAwBRMf9wiXErAk2hcn5NNnoEV0HNYku34nbsJBPQbkQDTR7tXExngZCg
	CNwVoVEUKA4ysbP9x4lyBxnHUen2CZ/Albo38T+VFRwp5dsQ0m8YqsF1Oryi2/jy
	O3ZwTv5oAmCBgEKUpcQhw3R+pz5CDuQ0CDm+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ko5dzGOchGRbYfkpHZ72Kpo6q3Z/DhuE
	fGH9x7v7I8oqLoWR7jkMhHw8924OCIcZFoeuBULRiXXYO6XXvvfAYOCBlSRbvSb7
	9NAgaT9hMQ5oMn+pPux3kjvtdp1yBHiwjIF5bEQBwf7+92AfA3JTbzxAE2W1ycG/
	1Gak9x5jaas=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7966776B6;
	Fri,  2 Mar 2012 17:41:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1288C76B5; Fri,  2 Mar 2012
 17:41:15 -0500 (EST)
In-Reply-To: <f2243a179ce49eed668341a6c0e3a452bf7ae79f.1330713761.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 2 Mar 2012 19:48:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D22EAE1E-64B8-11E1-AE0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192071>

Thanks.
