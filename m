From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Fri, 27 Nov 2009 00:59:44 -0800
Message-ID: <7vmy28s5q7.fsf@alter.siamese.dyndns.org>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
 <7v3a40tl9t.fsf@alter.siamese.dyndns.org>
 <36ca99e90911270044o68375902l3a0d2a4afa726a91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 10:00:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDwgM-0007mo-Ac
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 10:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZK0I7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 03:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZK0I7t
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 03:59:49 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbZK0I7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 03:59:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71A83832BB;
	Fri, 27 Nov 2009 03:59:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rPwS8hc8iJK5iXZCBvN7eA1cvb0=; b=H6hi1u
	Mwp/3nZosAF3Mg40QRSX6OGChK6176ZqDAfQ0gMhhATG/d92Ov3wmc/i+F6cfS7u
	5dYQROTTbOIKuGArKYa60WxxMOUDOYuFhVWi1Ca9bIa5KV44FZ0ybsQGqg3/QLp6
	9tzcN6F0nlf9NsQ/dcuf+dFUFItKa4awC+COY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mGT+GYLCboUFs4OAQOJ2u0vbHKJieXFG
	z5KiW+XVSfnI6Ku3+cJSW9m4VOXNEk/g/k5O7uV2i4m3GS0hEz8iLiYP+pXe1+tK
	ZWA/cmHpHR8mJEktL4WgxFWqUo2wswQvinIhjS/sCkorXAAC/nHEWwKavNflek+z
	6dEeaB1cKKs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B2A5832BA;
	Fri, 27 Nov 2009 03:59:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 706AF832B5; Fri, 27 Nov
 2009 03:59:46 -0500 (EST)
In-Reply-To: <36ca99e90911270044o68375902l3a0d2a4afa726a91@mail.gmail.com>
 (Bert Wesarg's message of "Fri\, 27 Nov 2009 09\:44\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 384CA492-DB33-11DE-B219-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133880>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Maybe you missed v2 (Message-Id:
> <1258557087-31540-1-git-send-email-bert.wesarg@googlemail.com>)? Which
> fixed the test and also a small bug.

Yeah, that was what happened.  Thanks for clarifying.
