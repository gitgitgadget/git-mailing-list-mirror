From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Thu, 08 Dec 2011 13:25:56 -0800
Message-ID: <7vr50ehi1n.fsf@alter.siamese.dyndns.org>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
 <20111206055239.GA20671@sigill.intra.peff.net>
 <CABPQNSbOReM71HaPmce3v_98NDu17fT3YnySR4pWzJEDa-RKnA@mail.gmail.com>
 <20111206185218.GB9492@sigill.intra.peff.net>
 <CABPQNSYQ=nt9LYzXpQgfwV00e9AxOV3LKj6VCCO8xkMAXb-Lfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Stephan Beyer <s-beyer@gmx.net>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 08 22:26:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYlTh-000080-Qs
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 22:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab1LHV0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 16:26:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632Ab1LHVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 16:25:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E4697DB7;
	Thu,  8 Dec 2011 16:25:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EIW8BIAYUhjO5wcnfFrVgEPAKIQ=; b=E8tIv0
	BSbGBluMSSaKG3f55IkrMpoeiX7oUxK9qVogGVZB6yuLOditmAZ1+JHS2wrLyPye
	U+lXkcZ9aKpUf9W1y5EMxjfiwB8r4J4KqYQEz3/c4FQJCYDz6wDpb27GNCQOdB41
	XyvClO+TpFx421z7eCsIcZZZYaLhPExZsUOZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QEKsN6mDogSCA6JEJnVulRSxCL1hVDu/
	yZKrdg4a8qGpOOVrU3bi4gAWmx6qYarNjsa/z8lZyNPI0jKvds3ZDadIeqsZNosO
	MeGUyNGx9zwlrimMqqQcQbs0kv/CB4NEFwwCCb3UIvoF62RO09iTGjdz3wLCtT8W
	8nAiBpw9AHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75B2B7DB6;
	Thu,  8 Dec 2011 16:25:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07BCF7DB5; Thu,  8 Dec 2011
 16:25:57 -0500 (EST)
In-Reply-To: <CABPQNSYQ=nt9LYzXpQgfwV00e9AxOV3LKj6VCCO8xkMAXb-Lfg@mail.gmail.com> (Erik
 Faye-Lund's message of "Thu, 8 Dec 2011 20:44:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 381B428C-21E3-11E1-9C0E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186595>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> The topic in question is jk/upload-archive-use-start-command, which is
>> at 1bc01ef, and should be based on recent-ish master.
>
> t5000-tar-tree pass for that one as well. No warnings this time :P

Thanks; let's move it forward, then.
