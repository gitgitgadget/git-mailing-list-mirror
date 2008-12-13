From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 12 Dec 2008 21:51:43 -0800
Message-ID: <7vvdto7hcg.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0812070427s64438216s41bf1294aa6398a3@mail.gmail.com>
 <alpine.LNX.1.00.0812071455020.19665@iabervon.org>
 <fcaeb9bf0812080451k6e213d0fo8d1da9bbac872649@mail.gmail.com>
 <alpine.LNX.1.00.0812081223140.19665@iabervon.org>
 <fcaeb9bf0812110504u1acfb612he3edae1df3774045@mail.gmail.com>
 <alpine.LNX.1.00.0812111520490.19665@iabervon.org>
 <7vy6ym9nm8.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0812120813m2949e36ar7905d5688b8f6ecb@mail.gmail.com>
 <4942952E.1060706@viscovery.net>
 <fcaeb9bf0812120854k1c366327o9bc696184ea4f02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 06:53:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBNRF-0001ki-Mr
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 06:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbYLMFwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 00:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbYLMFwA
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 00:52:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbYLMFv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 00:51:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 604B0180F4;
	Sat, 13 Dec 2008 00:51:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1BAD819AE9; Sat,
 13 Dec 2008 00:51:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2701645A-C8DA-11DD-B9F9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102986>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 12/12/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> ...
>> But what if the same persion notices a #define in a kdeutils header file
>>  and want's to know whether it is unused in order to remove it:
>>
>>     $ git grep FOO
>>     kdeutils/foo.h:#define FOO bar
>
> "git grep --cached FOO" ?

That should behave identically when the work tree does not have change
since the index, and by definition paths outside the checkout area in the
"sparse" mode cannot have changes, so "git grep FOO" should behave the
same and should find it.
