From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: fix "git show -C -C" output when renaming a binary
 file
Date: Fri, 28 May 2010 18:11:06 -0700
Message-ID: <7v1vcv5x79.fsf@alter.siamese.dyndns.org>
References: <20100526025013.25696.26816.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Greg Bacon <gbacon@dbresearch.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat May 29 03:11:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIAaF-0005bd-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071Ab0E2BLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 21:11:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0E2BLV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 21:11:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3A4FB77BF;
	Fri, 28 May 2010 21:11:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=cUj+AXUUlyv18m5x/RkHR0z
	gKmwvlWDIoNG0QFKhOaFCQynHWQ7QkBL5TWHav59yXp6eN8ndEEAAHQ8yRsB8LZV
	i4g2UIxU0GkTK/6Hss9sQCKY8JsQ+TNy4uepq7uqv/ZHGNHgyY9xZJOfa5Zt1Q4o
	3JPEO98sCtnx1irtJHZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=c/Q5jjUEQ6Y+l3uVdpwtXWfs77spc3tN+x0oWq+QAc9YlotG2
	3/FrTtwYz4opq7t72jCpKU8R2soasyLjFESeuiMKjEIjqU1RyViG+NyHmxP1KmA9
	2ZGSUvkWk9AyCY2qaIfPxljMDJfwdQL9AFmwlmAhAPw+mS8toa62kDHu0I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71553B77BE;
	Fri, 28 May 2010 21:11:14 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58E7AB77BC; Fri, 28 May
 2010 21:11:07 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1394FF70-6ABF-11DF-B0B3-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147947>

Thanks.
