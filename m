From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Thu, 16 Aug 2012 16:05:22 -0700
Message-ID: <7v4no2zbd9.fsf@alter.siamese.dyndns.org>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
 <20120702215736.GA5790@sigill.intra.peff.net> <m2vci5n5r5.fsf@igel.home>
 <20120703032345.GA7143@sigill.intra.peff.net>
 <CACsJy8AmCo82YxHA_6+rkbuJOjOG-HqCgjoP2tz753SXH5w8_Q@mail.gmail.com>
 <20120703051426.GA12965@sigill.intra.peff.net>
 <7vvcgizesm.fsf@alter.siamese.dyndns.org>
 <fd74d7233b4b29fe06afad23fb87552a@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>, <git@vger.kernel.org>
To: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>
X-From: git-owner@vger.kernel.org Fri Aug 17 01:05:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2987-0002kV-26
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab2HPXFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:05:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2HPXFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:05:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EDB38AE2;
	Thu, 16 Aug 2012 19:05:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hRrZH3IkW1TQ5MV/PFKHT7KAEOE=; b=tyuYPV
	C3HsoXZ9gXS9WhKMTTvWXWyePJ0dwlsSSa1IP1O4iJhVRyVAzjR7+ZvxUksl6vvj
	atHi6DyooDURpwPU3BA3o7wqrrNPlFyoGJn0ghjXfKgVjWLWQIRzhUTaITAfPasp
	aKYIln+hffFsGvKWVnhc7/m+TaNdax4eVEHZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oo0JAOsAcvw9baNWyZvINS7BbahOrP0k
	7a2wp2LORE4lE0TGp/NhJqF3/qhIFdAMh5CQV8DXZ8gi/bzA6C+42mc0N9rn9e/2
	BuYsnYOvnVzqCQcFFZnkXVoXhF2VVfoyesH+A6fflrDkKJ9XZdSwO0eRdZ86fDSI
	/mHjz4F5Io4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CECE8AE1;
	Thu, 16 Aug 2012 19:05:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5BCB8ADF; Thu, 16 Aug 2012
 19:05:23 -0400 (EDT)
In-Reply-To: <fd74d7233b4b29fe06afad23fb87552a@localhost> (Lars Winterfeld's
 message of "Thu, 16 Aug 2012 15:10:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC1A0272-E7F6-11E1-9D67-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Winterfeld <lars.winterfeld@tu-ilmenau.de> writes:

>> Hrm, has this ever been resolved?
>
> Thank you for asking.
> My local git version is 1.7.5.4, the server version that I actually
> ended up pushing the files to was however still some 1.6.x.
> So it was a false alarm. Sorry about that.

Not really.  Pushing or fetching by a new version of Git against old
version of Git *should* work; otherwise it is a bug.
