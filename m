From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Helping on Git development
Date: Thu, 15 Sep 2011 08:50:13 -0700
Message-ID: <7v4o0dreiy.fsf@alter.siamese.dyndns.org>
References: <CAOz-D1JW8RSR8kVWhT7v-DCbWayU8KhbePJwWrWvJwbmueRezQ@mail.gmail.com>
 <CAOz-D1+77JZRXa57GLz=vZyrcGs4Ojj6Wa0cSD4QcEkMP3PPsA@mail.gmail.com>
 <CAH5451me+MDe34Boak=UDjH9T_WAnO6wxa6pW+JHOoGADoNfkQ@mail.gmail.com>
 <7vehzjugdz.fsf@alter.siamese.dyndns.org>
 <20110914231427.GA5611@sigill.intra.peff.net>
 <7vd3f2snox.fsf@alter.siamese.dyndns.org>
 <20110915000851.GA6238@sigill.intra.peff.net>
 <CAH5451n=yEYYb0jO85+5_0dkuupQA2_WLvnH-fwPESS1GWy4Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Eduardo D'Avila" <erdavila@gmail.com>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:50:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4ECn-0005sr-7G
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090Ab1IOPuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 11:50:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934067Ab1IOPuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 11:50:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 977F54DA7;
	Thu, 15 Sep 2011 11:50:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/C1FW7FA747jLKdd/j2bIECR4+s=; b=G7O3/9
	/9MFbf31UCVnFU4Y6nPWNMrNY793U29rMfp+YLkHJSHLXi4dQ50HiXQIJW9Be+61
	IiZn5HEqp5ZUy9pRclmgdd0vR+KOErkJ9eM2M1+ZZUE5D3buaB/MgXTwt4vs5J4q
	m9Ujh0XQ+2COx8I967scdeJ8Jbnp3CM8jIgH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wr9B8G2LSrfrC7Ev+aCirGAd7nFdnzLr
	tK/+j+64Phd5Pkyvoy0Hb0MM3Cehb/Cx1m3+DNrxP3Fiz9l8DIHBrRjoio+w/Mhl
	+hJ/tGGSalOvxxwfqHMkKJYEWyeNOB9AvQlvP8X2jLcq9xlsqMLoAEXGvYvUc8z2
	qSngSclMWWY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD364DA6;
	Thu, 15 Sep 2011 11:50:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 217324DA4; Thu, 15 Sep 2011
 11:50:15 -0400 (EDT)
In-Reply-To: <CAH5451n=yEYYb0jO85+5_0dkuupQA2_WLvnH-fwPESS1GWy4Sg@mail.gmail.com> (Andrew
 Ardill's message of "Thu, 15 Sep 2011 16:24:22 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 674E6D86-DFB2-11E0-82C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181474>

Andrew Ardill <andrew.ardill@gmail.com> writes:

>> I am moderately averse to hardcoding that URL that is guaranteed not to
>> survive the maintainer change in our README file. The howto/maintain-git
>> document mentions the periodical "A note from the maintainer" posting to
>> the list that has the same text, which is a more appropriate reference.
>
> Would a link to the wiki be more appropriate? Perhaps even a 'getting
> started' page that collates information like this?
> ...
> When kernel.org comes back online I may have a go at creating such a
> page. Any thoughts?

"Getting started" that describes how they got started, collectively
maintained by people who got started recently, may serve as a good guide
for people who follow. And if it is done as a wiki, you are free to create
and update without asking permission from the community ;-).
