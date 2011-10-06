From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2011, #01; Tue, 4)
Date: Thu, 06 Oct 2011 10:24:41 -0700
Message-ID: <7vlisy119i.fsf@alter.siamese.dyndns.org>
References: <7vvcs49ofl.fsf@alter.siamese.dyndns.org>
 <4E8DC01A.8060406@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Thu Oct 06 19:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrhR-00044r-Mq
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761Ab1JFRZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:25:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758814Ab1JFRYo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:24:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C8666446;
	Thu,  6 Oct 2011 13:24:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f3sqX9Rxy+VTFUkdAsqKki9NZNY=; b=hLBtDm
	W0JUPx+S4kyhH2jp3rHz3RVGDvZelyO58zvBOTF1EGjcgwuUfaZAs1xGwz/jB0af
	deSwdmMUZEA+YWkIq1bmYGOA7mzbH5JhjjH3tNgXVtKzFfFWJTvWwnt0urXlnAqY
	WHNv9ChbmAegOCcMg8zSnaOzZA/21Ix4mqULM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tz7O9Hdz6mQD8P2ojqV4Ls2B32WzpuYC
	htVhh8VqV2aor9FDFKJOCRwxUP025QqKnljO5Ew8QaokCvU+TvpwnIs0UO/fTbUp
	XMB/rYaaEgJnaPN5kR8NrrSWgVFvfcEIeQFePPIChdZQX/c2B6vqpl+Kftw8bscM
	Jc++AN2i5Nw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5146445;
	Thu,  6 Oct 2011 13:24:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E314B6442; Thu,  6 Oct 2011
 13:24:42 -0400 (EDT)
In-Reply-To: <4E8DC01A.8060406@obry.net> (Pascal Obry's message of "Thu, 06
 Oct 2011 16:50:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 143FAC4C-F040-11E0-8421-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182991>

Pascal Obry <pascal@obry.net> writes:

>> Incomplete with respect to backslash processing in prefix_filename(), and
>> also loses the ability to escape glob specials.
>> Will discard.
>
> Sorry but this is letting best be enemy of good!

The impression I got from the discussion was quite different, which was
that the patch was not even "good" by making certain things impossible to
do by catering to a narrow corner case.
