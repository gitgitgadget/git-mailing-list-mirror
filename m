From: Junio C Hamano <gitster@pobox.com>
Subject: Re: COPYING tabs vs whitespaces
Date: Mon, 08 Feb 2016 09:28:36 -0800
Message-ID: <xmqqfux39kmz.fsf@gitster.mtv.corp.google.com>
References: <56B32BDA.4010909@redhat.com>
	<xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com>
	<56B85ECE.4020607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Petr Stodulka <pstodulk@redhat.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 18:28:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSpcE-0003KB-QC
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 18:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307AbcBHR2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 12:28:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753284AbcBHR2j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 12:28:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EDC641381;
	Mon,  8 Feb 2016 12:28:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r2bZej4V6Wp/nEXJ0qtWkr1Dm24=; b=xcrbII
	RU1Z1F7mx4s3Fmsi3OwuSL63YJDC3L7PD9vfegBQzY3E1+xMJCOXJlVLVlS8i8sf
	9AJ4SsTz5ZWeYbCGQa2JmAJlpfYethbcFK2ljOFYh1y68hX/yGHsFcIV6MMeXTxY
	0x9azz0aMu3wLxnKp8ShNIIZoDDwzJKL4EHWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQcjQXC99IaTUYL6OEESLNuJuoI0EO3O
	LvtmTfwo1/AZdofepXOMc+jGnifvPwLx/xKdWJnq8u324EhiQmuIYdDyevRTeNMj
	Gn9vjYVnHRTCpKx+VMw0mD5qGC6mrwS/VGb7ixJ/8z5M9ZwkFYzSKdf5OYixlWlv
	BNy0xm9y00M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 866334137F;
	Mon,  8 Feb 2016 12:28:38 -0500 (EST)
Received: from pobox.com (unknown [104.133.3.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 06E5D4137E;
	Mon,  8 Feb 2016 12:28:37 -0500 (EST)
In-Reply-To: <56B85ECE.4020607@redhat.com> (Petr Stodulka's message of "Mon, 8
	Feb 2016 10:24:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6388BCE0-CE89-11E5-A438-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285782>

Petr Stodulka <pstodulk@redhat.com> writes:

> On 4.2.2016 20:15, Junio C Hamano wrote:
>> Petr Stodulka <pstodulk@redhat.com> writes:
>> 
>>> I found that license file COPYING is different as compared with
>>> http://www.gnu.org/licenses/gpl-2.0.txt If I pass over with
>>> Linus's preamble, change is only about whitespaces - tabs
>>> vs. space.  Probably it's minor non-essential change, but some
>>> projects do this change, so rather I ask about that.
>> 
>> Interesting.  I cannot quite connect "some projects do this change"
>> and "so rather I ask".  Are you asking why this project changed it?
>
> Nope. I apologize for my czenglish. It means: From my colleagues I hear,
> that some projects had same differences (tabs vs. spaces) in their copy
> of the license file and they make it later equivalent with the one in
> gnu.org.

I'd guess that these projects (among which Linux kernel still has
these indentation the same as the copy we have) and we independently
obtained the COPYING file from GNU in some past, and back then the
copy at GNU was indented that way--which later was changed.

The Wayback Machine supports this theory.

https://web.archive.org/web/20070713225446/http://www.gnu.org/licenses/gpl-2.0.txt

i.e. the FSF copy back in 2007-07 indented these section headers
with tabs, so those projects that obtained this copy would have
their sections indented with tabs.

At 703601d6 (Update COPYING with GPLv2 with new FSF address,
2010-01-15), we did a fresh update directly from the URL you cited
above to primarily replace the addresses of the FSF office.

https://web.archive.org/web/20100105100239/http://www.gnu.org/licenses/gpl-2.0.txt

matches what we use (minus Linus's preamble, of course).

The file before that change was what Linus copied from Linux kernel
project.  The kernel project did their equivalent change at their
b3358a11 ([PATCH] update FSF address in COPYING, 2005-09-10), and
the log message says http://www.gnu.org/licenses/gpl.txt was used.

The Wayback Machine agrees.

https://web.archive.org/web/20050901115237/http://www.gnu.org/licenses/gpl.txt

i.e. the FSF copy back in 2005-09 matches what the kernel uses
(again, minus Linus's preamble).

> So I ask rather here / point out this difference, if you know
> about that or you want to have same one.

So the answers are:

 - No, I didn't personally know about the differences, and I suspect
   nobody particularly cared.

 - Not really, unless the difference has more substance.  For an
   example of an update with substance, the update we did in 2010
   had not just the FSF address change but also updated the fully
   spelled name of LGPL from Library to Lesser.

You may want to bug the kernel folks to update their copy; they
still spell it as Library General Public License.
