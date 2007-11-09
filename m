From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Thu, 08 Nov 2007 17:54:28 -0800
Message-ID: <7vd4ukxjxn.fsf@gitster.siamese.dyndns.org>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	<11945685732608-git-send-email-dsymonds@gmail.com>
	<7vtznwxl59.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20711081744p5d7b46fo88a582b9f5dbdab8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:54:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJ5A-0007rI-Vm
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761759AbXKIByi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761760AbXKIByi
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:54:38 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60361 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761707AbXKIByh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:54:37 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 752452F2;
	Thu,  8 Nov 2007 20:54:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4AD0093B0C;
	Thu,  8 Nov 2007 20:54:52 -0500 (EST)
In-Reply-To: <ee77f5c20711081744p5d7b46fo88a582b9f5dbdab8@mail.gmail.com>
	(David Symonds's message of "Fri, 9 Nov 2007 12:44:53 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64114>

"David Symonds" <dsymonds@gmail.com> writes:

> On Nov 9, 2007 12:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Seriously, that's a long standing limitation in the code, not to
>> deal with arbitrary combination of ups and downs, but I do not
>> think there is any fundamental reason to disallow something
>> like:
>>
>>         cd Documentation && git ls-files --full-name ../t
>>
>> Patches welcome.
>
> So you're otherwise happy with my tests, despite one of them
> triggering an (unrelated to git-checkout) bug? Or would you prefer I
> remove that particular failure from the tests and resend?

Are you really asking my preference?  A patch to ls-files to
make the test pass is my preference, of course ;-).

Haven't read your tests, though, but I see capable people
already commented on the initial round so I do not expect it to
be problematic.
