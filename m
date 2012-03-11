From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 04:18:56 -0700
Message-ID: <7vd38jxu5b.fsf@alter.siamese.dyndns.org>
References: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com>
 <7vk42rzfab.fsf@alter.siamese.dyndns.org>
 <CAMXnza12HVFdmji7k-b-G43NWmobqCQEwXZXB=VxJA=tatqX-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: suvayu ali <fatkasuvayu+linux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 12:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6gnp-0008F8-9E
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab2CKLTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:19:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026Ab2CKLS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:18:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43AA26FFA;
	Sun, 11 Mar 2012 07:18:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xp2KCTnkTmC4L/NVDsX0ia9KLE0=; b=WGr7qG
	s7ICQQSb1uFRdSOqZjSA5di0H5bSqY2Cnj38iUUE0RqIdyKkC3mIpTns+N+NSNln
	mZYaL69VSxhbnvQCoSWckPZqTaDhodRCpuL8qGFTO6kqF6E7nUEwZ3PcMnyOWkBL
	PKZUs6X7sYM4RWnjR6FbX0rsSvaYU4tIXWr58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lkCa8DU2QU8GHk/n+QVy8AQPw42ek8DE
	U7djZE5mDAJSS81fhX8UDgbNA+9FtJgTOOKiIClPDKAxIv2fGV1zsXbs+ScNOXFd
	1Q1x8wZJRpG/b1Xw0rCWYqrBGQCHLot0ytW2f1FhEMD2O5v2pEW7PQzc/0aBqWuz
	srTTRR+rC8I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BAC46FF8;
	Sun, 11 Mar 2012 07:18:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D190E6FF7; Sun, 11 Mar 2012
 07:18:57 -0400 (EDT)
In-Reply-To: <CAMXnza12HVFdmji7k-b-G43NWmobqCQEwXZXB=VxJA=tatqX-g@mail.gmail.com> (suvayu
 ali's message of "Sun, 11 Mar 2012 11:10:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FED228B0-6B6B-11E1-A831-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192808>

suvayu ali <fatkasuvayu+linux@gmail.com> writes:

> ... is that discussion on progit talking about
> something else?

Sorry, I do not read or write progit, so I do not know offhand what
it says in the section you read and I cannot judge if it was you who
misread, or if it was book that misspoke.
