From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sat, 05 Jan 2008 18:56:07 -0800
Message-ID: <7v4pdr7jco.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<449c10960801051321g785e45e3v8f7b129bb087e1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Tsugikazu Shibata" <tshibata@ab.jp.nec.com>,
	"Marco Costalba" <mcostalba@gmail.com>,
	"Jeff King" <peff@peff.net>, "Dmitry Potapov" <dpotapov@gmail.com>
To: "Dan McGee" <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 03:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBLgz-0000Hf-VL
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 03:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbYAFC4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYAFC4Z
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 21:56:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbYAFC4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 21:56:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 89FE78E31;
	Sat,  5 Jan 2008 21:56:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DDC0B8E30;
	Sat,  5 Jan 2008 21:56:14 -0500 (EST)
In-Reply-To: <449c10960801051321g785e45e3v8f7b129bb087e1ca@mail.gmail.com>
	(Dan McGee's message of "Sat, 5 Jan 2008 15:21:50 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69706>

"Dan McGee" <dpmcgee@gmail.com> writes:

> On Jan 5, 2008 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> We are not at -rc3 yet, but we will be soon.  What we have
>> accumulated in 'master' are mostly fixes, and the official
>> git-gui 0.9.1 is also included tonight.
>>  * Dan McGee's workaround to breakage caused by changes in
>>    AsciiDoc 8.2.3.
>>
>>    I have to do my usual "before-and-after comparison" with
>>    copies of AsciiDoc versions that should not be affected by
>>    the breakage, which I did not have time to do so far.  But
>>    this is probably a must-have before the release.
>
> I've updated the patch a bit as I noticed I completely missed the
> user-manual.txt and a handful of other files that weren't named
> git-*.txt. The new version is attached (gzipped).

The asciidoc.conf change I resurrected from the earlier one but
it appears this breaks build with asciidoc 7.1.2 for some reason
(I haven't looked into that myself yet, and I won't be for the
next 12 hours or so).
