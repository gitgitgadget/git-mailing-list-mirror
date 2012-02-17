From: Junio C Hamano <gitster@pobox.com>
Subject: Re: diff -G with case insensitivity
Date: Thu, 16 Feb 2012 18:27:28 -0800
Message-ID: <7v62f6w5wv.fsf@alter.siamese.dyndns.org>
References: <CAJ6vYjejtZkupy750rvz6HW_0SNPyBVTa78DO4nY8Bi368neQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Leong <walkraft@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 03:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyDXs-0001xY-UK
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 03:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab2BQC1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 21:27:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64506 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab2BQC1b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 21:27:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 790C37318;
	Thu, 16 Feb 2012 21:27:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MS9uZ5qgV+cP7qkhXnVCBsFpFso=; b=kNlEhE
	gBL2zC2hlNcRHRcl2boEYyPU6k0wRLxr93OGI8ae8lP88UWKD1sXIVSBmI9ScfNJ
	5RiCvi6zqxMTOEaC+jEk0efF0cNu2LDSfhz8IgQliRQVQICj1fzWjY+CStl3jii1
	guI/dZTQyrs9z1il29NiQe6hkv8Zj/3bvkkXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kwhfKCqGzlDJzBgPMxije63IPU1NzT4J
	iCVIUak0KGOX9BMxeI30Pi+c/49ZYy6AUQOLy0eOm205ZSZz824bXc5LppJ6e3LT
	w5TBtqW7CNe13gaUWFhJRkzzQnHo0VJFb8g/leO3D9ME7nBgqOOWbmXTj15QUfsk
	ckGz9O3P8rM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7020F7317;
	Thu, 16 Feb 2012 21:27:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E49247316; Thu, 16 Feb 2012
 21:27:29 -0500 (EST)
In-Reply-To: <CAJ6vYjejtZkupy750rvz6HW_0SNPyBVTa78DO4nY8Bi368neQw@mail.gmail.com> (Chris
 Leong's message of "Thu, 16 Feb 2012 11:18:54 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0A33E38-590E-11E1-A713-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190930>

Chris Leong <walkraft@gmail.com> writes:

> Is there any way to run diff -G with a case insensitivity flag?

Hrm, not that I know of.  Do we even do a case insensitive diff regardless
of the -S/-G option?
