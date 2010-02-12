From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-am: Add command line parameter `--keep-cr`
 passing it to git-mailsplit.
Date: Fri, 12 Feb 2010 13:54:16 -0800
Message-ID: <7vmxzenmrb.fsf@alter.siamese.dyndns.org>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
 <1265923579-24900-4-git-send-email-stefan.hahn@s-hahn.de>
 <7vocjvqryb.fsf@alter.siamese.dyndns.org> <20100212210546.GC32018@pille.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:54:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3T3-0002eq-6m
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab0BLVyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:54:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0BLVyX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:54:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52CA297566;
	Fri, 12 Feb 2010 16:54:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LMicRsZtkxlS2lx+eXia+IQFM+A=; b=g39+ty
	JIDwlzD7sPD89oUEZqU/cFEJw8JpZKQcNUyQYRcUnXL1OXIxA1I7sE/DbEa9nmP1
	EkGqGmBCB7H5czMBQsO86JW3sEbFNLeph4X8UPEEsCzp5wGB07qFQAMy3XtSoFH1
	Uf0CITgAf1JF2afbdnOpr1mVvKlHChbDth6Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UdQ4bGRo1aP3RiGKjghyRM/I/CGtxoI2
	jJWP0QchlWtKC0fw0rROPFop+fYg2nBSp8uS8B3k8F8tK/4SbtYO/sZsGZ3P9/ae
	Fv6PQd4v/1C8prrfnbOfDLFEbppKZpxxERppJmCVlfMkbcN6DGDHS/swvrHqqbVJ
	qa12nbI6Sl4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BA0597564;
	Fri, 12 Feb 2010 16:54:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50F6897563; Fri, 12 Feb
 2010 16:54:18 -0500 (EST)
In-Reply-To: <20100212210546.GC32018@pille.home> (Stefan-W. Hahn's message of
 "Fri\, 12 Feb 2010 22\:05\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CF2A634-1821-11DF-83D3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139752>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> Also sprach Junio C Hamano am Thu, 11 Feb 2010 at 15:21:32 -0800:
>> "Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:
>> 
>> > If applying patches with the following command sequence
>> >
>> >    git format-patch --stdout ... | git am ...
>> >
>> > in repositories having files with dos and unix line endings
>> > git-mailsplit, which is called from git-am must be called with
>> > `--keep-cr` parameter since commit c2ca1d79.
>> 
>> Sorry, I cannot parse this.
>
> What?

What I said.  I wasn't able to parse it.  If it were:

    If applying patches with the following command sequence

       git format-patch --stdout ... | git am ...

    in repositories having files with dos and unix line endings,
    git-mailsplit, which is called from git-am, must be called with
    `--keep-cr` parameter since commit c2ca1d79.

iow, two additional commas, I would have been able to, but I was not
certain that is what you meant.

>> > +e,keep-cr       pass --keep-cr flag to git-mailsplit for mbox format
>> 
>> This short form -e does not make much sense to me.  Why is it -e, and do
>> we even need a short form in the first place?
>
> Just for shortening the commandline.

That much I know already ;-) and you probably know that I knew when I
wrote this, which you somehow omitted from your quote:

    ... We may want to use short-and-sweet 'e' for something more
    important and common, and we would regret for letting this option
    squat on it later.

The shorter one can come later after people find --keep-cr is something
they often need to use and deserve a shorter form, but not until then.
