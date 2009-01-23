From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to force a commit date matching info from a mbox ?
Date: Fri, 23 Jan 2009 09:27:40 -0800
Message-ID: <7vprieue43.fsf@gitster.siamese.dyndns.org>
References: <7vtz7qxsxc.fsf@gitster.siamese.dyndns.org>
 <7vwscm1nic.fsf@gitster.siamese.dyndns.org>
 <7vljt26fp9.fsf@gitster.siamese.dyndns.org>
 <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com>
 <20090123094529.6117@nanako3.lavabit.com>
 <20090123172646.6117@nanako3.lavabit.com>
 <20090123185209.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 18:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQPqD-00062x-Pm
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 18:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbZAWR1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 12:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754948AbZAWR1t
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 12:27:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbZAWR1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 12:27:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B6C093D53;
	Fri, 23 Jan 2009 12:27:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4570593D4D; Fri,
 23 Jan 2009 12:27:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26ACA622-E973-11DD-A7C1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106894>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>>> --->8---
>>> Subject: [PATCH] git-am: Add --ignore-date option
>>
>> Good.
>>
>> Leaving "Subject: " in saves me typing, because I do not have to insert it
>> manually when editing the submitted patch in my MUA to chop off everything
>> before the scissors.
>
> I am sorry to ask you a stupid question, but do you mean you want to have
> "Subject: " there, or do you mean you want me to leave that word out?

Sorry for poor use of the language.  I want to see "Subject: " on the
line after the scissors.  That way, I can remove everything up to the
scissors, and the resulting message body will start with a line that
begins with "Subject: ", which overrides the subject of the e-mail.
