From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH da/difftool-mergtool-refactor] Makefile: fix permissions
 of mergetools/ checked out with permissive umask
Date: Mon, 10 Oct 2011 17:00:48 -0700
Message-ID: <7v8vosiehb.fsf@alter.siamese.dyndns.org>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-4-git-send-email-davvid@gmail.com>
 <20111009091617.GA29150@elie.hsd1.il.comcast.net>
 <20111009114333.GA29829@elie.hsd1.il.comcast.net>
 <1C9F1683-4C6E-4D49-86D3-3A47B2843F23@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	SebastianSchuberth <sschuberth@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPmB-00050u-7E
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab1JKAAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:00:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59610 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1JKAAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:00:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C3EA5607;
	Mon, 10 Oct 2011 20:00:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=SpT8ynbM8xol1mtD7yDRKrcjVhw=; b=H+00oSV71rzM+A/oZCwJ
	czCTnzdaN3ZNfyr/wRtJOiqB8O6VhTmWDvWa04MElKS95qUTmE4oVR5FC/L8cOXb
	bTa4uO/8ULCgtW3ImTGppRAPbrUjY/WzpZy0zUXXSL9MkM+izEE4rSdnHmaFB7IQ
	FMdi8sB3ZQ3mwf/LkfVev9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vGd38n9yIIDvHBdbjxefDuIUYSTw6M0BI2cR1KVwp3tXdz
	et9coLMGC1ABn0MyTwtJbOc8UrA9jJl6uUG3ZG0w8V05fmRoiuP6XE5XgznCOfYr
	2syI/k0BJDgiL5y36L6oLKQFEBDVQa8e0i9M2NXIOGo8ZgE5WZ60bpYIb7yQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02B8F5606;
	Mon, 10 Oct 2011 20:00:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8EC8A5605; Mon, 10 Oct 2011
 20:00:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13EE93C0-F39C-11E0-9E5A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183274>

David Aguilar <davvid@gmail.com> writes:

> thanks. I agree that the tar is overkill. I think I copied that snippet
> from templates/makefile. does that have the same bug?

Likely, as I recall that I wrote the installation of templates in an
expecially sloppy way, thinking somebody would fix it in short order
anyway. Instead the sloppiness seems to have been copied and pasted to
make things worse...

Thanks for fixing the mess---all's well that ends well.
