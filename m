From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Document author/committer/tagger name is
 optional
Date: Thu, 31 Dec 2009 15:08:37 -0800
Message-ID: <7vhbr6rbbe.fsf@alter.siamese.dyndns.org>
References: <4B304987.7030201@facebook.com>
 <20091222150649.GI10687@spearce.org> <4B3AED66.3030803@facebook.com>
 <20091230150348.GF6914@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Reiss <dreiss@facebook.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 00:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQUAQ-0001iM-5W
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 00:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbZLaXIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 18:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZLaXIt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 18:08:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbZLaXIs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 18:08:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BD13FAB06B;
	Thu, 31 Dec 2009 18:08:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=nUkXld40NZlMrDBzcBR+9eeAuR8=; b=vUUbtNjGkCFNpzFwLGio6Fy
	Xy6GCxzTjUrzwMCpbyD+KvjY/6ASR/ZbwvIwc9uWC5dCccBpej6PWjli4TTs+phf
	kR9fv4mLIB2SUBbT3pK5XfeSWoFm01LlQCwnu1Fq1lxBdPYKCZhsYDwc22mOglsU
	g9c2o/J4RncTpBDaXdZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=iTfFNfVmKOtcuoo5L8B8LH2x3ek/j7EcaLxF8B7I3K+Cb1S7g
	qAtkqaB6s3pLjT5zkQ2cmBXaj1bgeHVjgQb9auxHm+xEc+ntSGRhMIFURuEbCxGA
	63uGnM7AAOTNZHtpytIqQf82Tuqw7l+PjBvJv5LBtl9NhDhlBpaHKdZyao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8CCFDAB06A;
	Thu, 31 Dec 2009 18:08:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 376DFAB065; Thu, 31 Dec 2009
 18:08:39 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 717E8A16-F661-11DE-9A70-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135982>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>    David Reiss <dreiss@facebook.com> wrote:
>    > >> author <somename> 1261454209 +0000
>    > >> committer <somename> 1261454209 +0000
>    > > a foreign system where the data might not reasonably exist.
>    > But shouldn't there still be an extra space?  One to separate "author"
>    > from the empty name, and one to separate the empty name from the email?
>    > If not, then I think this change should be made.  (I couldn't find any
>    > authoritative documentation on what constitutes a valid commit object.)
>    
>    Yes, we should do this.

Thanks.
