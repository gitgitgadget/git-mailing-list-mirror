From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Add support for the google-chrome web browser
Date: Tue, 05 Jan 2010 10:39:23 -0800
Message-ID: <7v8wccz99g.fsf@alter.siamese.dyndns.org>
References: <20100105051906.GA22799@efarrerlx.appsig.com>
 <7vr5q56rew.fsf@alter.siamese.dyndns.org>
 <32541b131001050920j2a569ec8u8811f1b0358f21ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Evan Farrer <evan.farrer@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSEJl-0007Hs-12
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 19:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0AESjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 13:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755194Ab0AESjj
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 13:39:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab0AESji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 13:39:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 54779AD5AE;
	Tue,  5 Jan 2010 13:39:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8IsNmlg3zbEJ12PnoLPpoU93EBs=; b=SCU/5y
	weGpip+kwefkNdWbg0gBqyeDck8BwX+CfcW70JOz/R3bA8rZZPWH574+VZm1oZdn
	CCM4NpSNCuAgSn1/8C7XtbNozsthZGVef3NhP3xlIJARVqfZNPvpwLLhiIxCxsTW
	qgqfe9/jbvyyezEt6acHbb0U/z0YaFujO2biE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=my99mKETaa3pb2rs00Oik4Hg9aRLVfVO
	+fAaao5QIyoqldDUcJ/dnP8rImMsX/SsdV1gcE6bZ/rPIJ85i5CF806djLaV6x+G
	a0WHpi0FDvGNwvu/ocLnU6A64G11UHCyxtfHhhgMdKwkS5jLkMFN16cf5TVS2MUP
	UwXZWmADZhU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16776AD5A9;
	Tue,  5 Jan 2010 13:39:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 33860AD5A8; Tue,  5 Jan 2010
 13:39:24 -0500 (EST)
In-Reply-To: <32541b131001050920j2a569ec8u8811f1b0358f21ef@mail.gmail.com>
 (Avery Pennarun's message of "Tue\, 5 Jan 2010 12\:20\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A967A89C-FA29-11DE-A94B-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136201>

Avery Pennarun <apenwarr@gmail.com> writes:

> On Tue, Jan 5, 2010 at 12:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Then we don't even have to add any specific support for "google-chrome" or
>> anything that takes "$command $path..." and opens the documents.
>>
>> Is there a downside in this approach?
>
> If someone has another firefox-derived browser installed with a
> different name and tries to use it, this default wouldn't do the right
> "firefoxy" thing, and would instead fail strangely.  On the other
> hand, right now it'll fail anyway, just not strangely.

You probably didn't notice/understand why I singled out w3m/links/open and
excluded firefox from the set.  There is no question that the ones that
need custom command line need custom support.  But to support a new
browser that takes a bog standard "command then args" command line, there
is no reason to add cruft, every time somebody comes up with a new browser.
