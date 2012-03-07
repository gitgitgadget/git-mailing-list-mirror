From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unable to make git with https support
Date: Wed, 07 Mar 2012 12:05:04 -0800
Message-ID: <7vk42wmb2n.fsf@alter.siamese.dyndns.org>
References: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nate Parsons <parsons.nate@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5N6o-0006ml-U0
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 21:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210Ab2CGUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 15:05:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759790Ab2CGUFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 15:05:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08CE9755F;
	Wed,  7 Mar 2012 15:05:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFtE9Crlo1gnnTduwOVZyoL2J8Y=; b=MleacB
	O0sRbzX+PTaeP8zHZ3pkT8HjmotY+g51xzSlmpX+TQ5KKVADzTvwwyttq5brY+bG
	PWpKzVdsQEhZjjlwjlxyNvDiww/6IX/QkjfvCaZKqbY86UB5fXBFh7wvla/iCPAL
	zlwilyJcWVpSCOLNvp5yegPnusZBQbqDaKI68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q9pzXtj9K28f2DxGCdsLzTMuKmSu+3pY
	0gvfUgr9Rp1VRLdGQUmBCY8UXm0zwXu87olzyIPPspKVZVwx6UjtjPOH6YN6RQf7
	KqGut4Iy6/qsNdWcu1dLXr07RCq1ZownBp0KdKpQXv/EJJRYUkW9r/FDu8zKZ/0A
	NnrCESKsHWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00D05755E;
	Wed,  7 Mar 2012 15:05:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9012D755A; Wed,  7 Mar 2012
 15:05:05 -0500 (EST)
In-Reply-To: <CADjGbJq_HL--_CAuE_Yj3B0srx=WDficot8bgadvW92zz9PJdg@mail.gmail.com> (Nate
 Parsons's message of "Wed, 7 Mar 2012 14:52:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D500E338-6890-11E1-9FA3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192477>

Nate Parsons <parsons.nate@gmail.com> writes:

> I'm trying to make git for myself, but can't seem to get https
> working. This is what I did to make it:
>
>> wget http://git-core.googlecode.com/files/git-1.7.9.3.tar.gz
>> tar -xf git-1.7.9.3.tar.gz
>> cd git-1.7.9.3.tar.gz
>> ./configure --with-curl --prefix=$HOME
>> make
>> make install

I wonder if omitting the whole "configure" thing (remove
config.mak.autogen) and doing

    $ make
    $ make install

may work for you better?
