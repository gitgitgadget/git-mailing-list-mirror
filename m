From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 14:29:39 -0800
Message-ID: <7v7ikdna24.fsf@gitster.siamese.dyndns.org>
References: <1195477504.8093.15.camel@localhost>
	<8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
	<E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
	<8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com>
	<25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr>
	<vpqtznirtlk.fsf@bauges.imag.fr>
	<60891A14-1D6E-4114-ACEF-4C981D326CFA@lrde.epita.fr>
	<vpq63zxq5s2.fsf@bauges.imag.fr>
	<0E0AA90A-2282-4AFE-8B94-EA0E35B57D65@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Lars Hjemli <hjemli@gmail.com>,
	"Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuF88-0008Ht-Rd
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbXKSW3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbXKSW3u
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:29:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:53198 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXKSW3s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:29:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8275F2F0;
	Mon, 19 Nov 2007 17:30:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B65D997960;
	Mon, 19 Nov 2007 17:30:02 -0500 (EST)
In-Reply-To: <0E0AA90A-2282-4AFE-8B94-EA0E35B57D65@lrde.epita.fr> (Benoit
	Sigoure's message of "Mon, 19 Nov 2007 22:51:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65511>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> On Nov 19, 2007, at 10:33 PM, Matthieu Moy wrote:
>
>> Benoit Sigoure <tsuna@lrde.epita.fr> writes:
>>
>>> No please stop adding links from on man page to another.  If you read
>>> man git-reflog, you surely want to learn the HEAD@{N} syntax and see
>>> practical uses cases.
>>
>> I don't understand your point.
>>
>> Yes, if I read man git-reflog, I do surely want to learn HEAD@{N}
>> syntax, but that is _precisely_ what my patch does.
>
> By telling you to read another man page which is annoying and a
> recurring complaint.

Which is a valid point.  We could move that part into a separate
source file and include it from different places appropriately,
just we have done for the common diff options.

However, you need to think about what's appropriate.  Any
command that potentially takes a ref as (one of) its parameter?
That means almost everybody.

I think the ref naming syntax is so commonly used and
fundamental that we could treat it as prerequiste for individual
manual pages.  Maybe move the section to git(7)?  That would
certainly be better than having it in git-rev-parse(1), but does
not reduce the cross referencing complaints.
