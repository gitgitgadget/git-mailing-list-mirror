From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 05 Nov 2007 15:54:18 -0800
Message-ID: <7v4pg0meol.fsf@gitster.siamese.dyndns.org>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
	<11942029442710-git-send-email-shawn.bohrer@gmail.com>
	<11942029474058-git-send-email-shawn.bohrer@gmail.com>
	<7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
	<1b46aba20711051410h370072e7he9cbebb54a789dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn Bohrer" <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBmD-0005DY-H6
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbXKEXy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754802AbXKEXy0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:54:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37812 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763AbXKEXyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:54:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A320A2F2;
	Mon,  5 Nov 2007 18:54:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 232AF929EF;
	Mon,  5 Nov 2007 18:54:42 -0500 (EST)
In-Reply-To: <1b46aba20711051410h370072e7he9cbebb54a789dac@mail.gmail.com>
	(Carlos Rica's message of "Mon, 5 Nov 2007 23:10:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63595>

"Carlos Rica" <jasampler@gmail.com> writes:

> 2007/11/5, Junio C Hamano <gitster@pobox.com>:
>> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
>>
>> > +static int show_only = 0;
>> > +static int remove_directories = 0;
>> > +static int quiet = 0;
>> > +static int ignored = 0;
>> > +static int ignored_only = 0;
>>
>> Please do not explicitly initialize static variables to zero.
>
> Is it really needed to declare those variables outside of a function
> in this case?

I do not think so --- I suspect that this is a simple cut &
paste from the standalone ls-files implementation.
