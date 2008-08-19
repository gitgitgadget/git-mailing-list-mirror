From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 11:15:55 -0700
Message-ID: <7v4p5gdg6c.fsf@gitster.siamese.dyndns.org>
References: <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
 <660749.49882.qm@web27803.mail.ukl.yahoo.com>
 <ee521d6f0808190504u12be6195o71eb2f3a38f73a5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mark Struberg" <struberg@yahoo.de>,
	"" Peter Valdemar =?utf-8?Q?M?= =?utf-8?Q?=C3=B8rch?= (Lists) "" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Alexander E Genaud" <alex@genaud.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVll-0000Ye-0z
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbYHSSQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbYHSSQK
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:16:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbYHSSQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:16:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7676453F2C;
	Tue, 19 Aug 2008 14:16:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CAC2753F28; Tue, 19 Aug 2008 14:15:58 -0400 (EDT)
In-Reply-To: <ee521d6f0808190504u12be6195o71eb2f3a38f73a5f@mail.gmail.com>
 (Alexander E. Genaud's message of "Tue, 19 Aug 2008 14:04:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E49D9706-6E1A-11DD-B8A7-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92891>

"Alexander E Genaud" <alex@genaud.net> writes:

> Thanks for pointing me to 'git-rm --cached'.
>
>> The changes are "cached" in the "Index". But I wouldn't name
>> the "Index" really a "Cache" because it is a lot more. All
>> comments for --cached in the manpages mention the Index
>> mechanism. Additionally there is a more detailed introduction
>> to the Index in section 7 (Git concepts) of the Git User's
>> Manual
>
> Funny the first example shows the contents of the index using a '--stage' flag.
>
> $ git ls-files --stage

For ls-files, --cached mode is the default so you did not even have to say
it in your example.

With the option --stage, you are specifying how that --cached state is
shown.  Normally we do not show the object name nor their merge stages,
but we do when you give the --stage option.

Also look at the end of gitcli(7) documentation.
