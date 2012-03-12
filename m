From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 09:40:48 -0700
Message-ID: <7vfwddu60f.fsf@alter.siamese.dyndns.org>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Jonathan Nieder <jrnieder@gmail.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S78Ir-0005YJ-Np
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab2CLQkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:40:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183Ab2CLQkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:40:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89CE96E9E;
	Mon, 12 Mar 2012 12:40:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTWESIjznAOb+Cz/TOge+cuEn/Y=; b=ULsI+u
	Qj2/nbiZB7T5AwCtWaH4LKivAf9PekUNtdMcBky5ZtY5wAC8RDgxi+m8rmdrP1Qd
	gz48ca7tYojnhsmw6RmYMKPmt4cNUcCmbLzEsT+iFHGVGOVozfCM6ePGRjvxXaFo
	5V3Q1nHiuglx8f4m3GeTH9YSQLkU+MwI5r9U8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p111Jp9D+PefZatbaV9B3vIh6OXDjMro
	BV6IFJ1egaOAwVDZS1lJxfZaqBowYiwdgCetZFrgNFbtgr81nbZ5jr6rsLChtj5V
	gsnqWeqDIWFkMNt82W0jEeovaTGoPZGjSjyHV9WucpZ50rXChZSq3rhDontLtylc
	HWyeMHCtTOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F766E9D;
	Mon, 12 Mar 2012 12:40:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FDF16E9C; Mon, 12 Mar 2012
 12:40:49 -0400 (EDT)
In-Reply-To: <20120312152004.GB9380@kroah.com> (Greg KH's message of "Mon, 12
 Mar 2012 08:20:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20382288-6C62-11E1-9D59-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192903>

Greg KH <greg@kroah.com> writes:

> I don't see a -b option to 'git am' in the manpage, am I missing
> something here?

As this is a recent enhancement, it is very much appreciated if you
try out 1.7.10-rc0 (or 'master').
