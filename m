From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] Add --reference option to git submodule.
Date: Tue, 28 Apr 2009 11:52:09 -0700
Message-ID: <7vskjslig6.fsf@gitster.siamese.dyndns.org>
References: <20090428123033.GA6839@redhat.com>
 <49F702C0.8030206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 20:52:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LysQ1-0004XJ-He
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 20:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbZD1SwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbZD1SwT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 14:52:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZD1SwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 14:52:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 27FCFAE4FF;
	Tue, 28 Apr 2009 14:52:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D70BFAE4FE; Tue,
 28 Apr 2009 14:52:10 -0400 (EDT)
In-Reply-To: <49F702C0.8030206@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Tue, 28 Apr 2009 15:21:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0BE7B18-3425-11DE-BE4A-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117803>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Michael S. Tsirkin venit, vidit, dixit 28.04.2009 14:30:
>> This adds --reference option to git submodule add and
>> git submodule update commands, which is passed on to git clone.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> 
>> Here's v2. Ack?
>
> I don't think it's up to me to Ack but you addressed my remarks.

You can certainly say "Reviewed-by: me" and/or "Tested-by: me".

> BTW, even dash has "test STRING" so portability doesn't require -n but I
> think it's OK either way.

It always is a good discipline and style.
