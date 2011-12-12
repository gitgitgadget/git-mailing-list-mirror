From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Sun, 11 Dec 2011 21:29:09 -0800
Message-ID: <7v4nx66vl2.fsf@alter.siamese.dyndns.org>
References: <4EDBF4D5.6030908@pcharlan.com>
 <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EDF1631.5090906@pcharlan.com>
 <7vvcpqj4vr.fsf@alter.siamese.dyndns.org> <4EE55D5E.1090908@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:30:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1HK-0004d2-O5
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:30:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab1LLIaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:30:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54859 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1LLIaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:30:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6422893;
	Mon, 12 Dec 2011 03:30:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=g0zPqILN5Qyjt8yeoA4w
	0Q5Q0ARc2XC6G+KaRhvvijRqwgvQKuUDHwSAPp6w8oaFUIlnfG45/g9UJ884R3lW
	2mvJ4dWx7kRLU9WaSNcVvKajx30LRaum7XTGjgYOrpGzFNkjBqZmplcBpDjuJ0h/
	TE+YALKN/Bdz+DiqT60WkdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=MWMk+7IfH+D3/DaKE6PUrTa678VdnSEx9XjGmP1r6mRRly
	nk0r6vwyzsHf8SH0CF66LJbbUGuJ5rCTk4WNdZhIUu3KcAAawVoCg0TCioF3ePui
	RlH0vY1CWXlqfbQ7j93DDTWyqK8/YKzpCDibevNfnFmi5MU0tk4GenSIzP6zM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86CE02892;
	Mon, 12 Dec 2011 03:30:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19BAA2891; Mon, 12 Dec 2011
 03:30:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86658DDE-249B-11E1-B143-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186892>

Thanks, will queue.
