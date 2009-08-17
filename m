From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 09:05:34 -0700
Message-ID: <7v7hx2xw6p.fsf@alter.siamese.dyndns.org>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
 <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
 <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
 <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
 <4A8932BB.7030002@viscovery.net>
 <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
 <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
 <eaa105840908170552m3eaf0f92j523ddad98dd67a3@mail.gmail.com>
 <alpine.DEB.1.00.0908171522510.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Harris <git@peter.is-a-geek.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4ia-0005NH-Ld
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbZHQQFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbZHQQFn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:05:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395AbZHQQFn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:05:43 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1039E08F;
	Mon, 17 Aug 2009 12:05:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3B04E089; Mon, 17 Aug
 2009 12:05:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0908171522510.4991@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon\, 17 Aug 2009 15\:23\:32 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D1F40022-8B47-11DE-A1C2-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126208>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> That's funny. I have a git tree that would benefit from sparse checkout. 
>> I know which path I _don't_ want. Specifying all the paths I want would 
>> be a rather longer (and more error-prone) list. I suspect it would be 
>> best to support both.
>
> Yes, I agree, but the common case is for people to know what they are 
> working on, right?

I either may be working on Documentation/ (I know I do not care about
everthing else so I can afford to list Makefile and Documentation/ in the
"interesting" list), or I either may be working on code (I do not know how
many code directories there are, and do not care to list them, but I know
I do not need Documentation/ and contrib/).  You need both ways.

And with .gitignore syntax you can have both.
