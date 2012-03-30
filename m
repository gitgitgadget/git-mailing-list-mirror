From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: replace 'vi' for 'editor' to reflect
 build-time option
Date: Thu, 29 Mar 2012 19:16:05 -0700
Message-ID: <7v398qq1ei.fsf@alter.siamese.dyndns.org>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rodrigo Silva \(MestreLion\)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 04:16:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDRNu-000868-RW
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 04:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759944Ab2C3CQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 22:16:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759914Ab2C3CQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 22:16:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A0573DD;
	Thu, 29 Mar 2012 22:16:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VvhE2rPKzQBDOKlxqOH/+ioQj4k=; b=Kzgmvj
	o+12whs4L97Mgzr1AacxGpSjxmSWiPhtgUCSV9EFxWWGwmHgiE7aHvXBFOkrwNnM
	42ZkSIGdlNZX18zXO/8bWm1+PMQ8kmhyhwLN7IX1xnq9GiuRjVLH0K1BWMlmK7wk
	ywD8QXqVOHzN5TmmLjmRic/YOoNsas1T8GK9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UUmW3c8drsKS2C4+uLc1HfdhYuQeAbXj
	hPh9xXuzI9tcUJz6pRbfaPqvYoFLSaEXfqi+q9lRFEuooNgt8B3E/CDpum25uEJv
	/EZIjVhV/Z95xwtH7IgF5mjJvTaX57kWY5FM44r7ocSxs4PGNFOmX2CdOmP54xBF
	tW+qYBTB4Po=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AAB373DC;
	Thu, 29 Mar 2012 22:16:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E03DC73DB; Thu, 29 Mar 2012
 22:16:06 -0400 (EDT)
In-Reply-To: <20120330005523.GA28519@burratino> (Jonathan Nieder's message of
 "Thu, 29 Mar 2012 19:55:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4EE09A52-7A0E-11E1-9F5D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194314>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Filling in the blank at compile time would be possible, but I'm not
> convinced it's a good idea.  Wouldn't the same user be just as puzzled
> when
>
>   http://git.kernel.org/?p=git/git-htmldocs.git;a=blob_plain;f=git-var.html
>
> (or whatever page with a nicer URL arises to replace the old
> www.kernel.org/...  pages) says the fallback is 'vi' and git behaves
> differently?

I've already rejected this patch once, but that was primarily because the
patch was not justified with the above "I read everybody else's git uses
'vi' on the Interweb, and even though my distro's manual page says it uses
'nano', I didn't bother to read it." scenario.
