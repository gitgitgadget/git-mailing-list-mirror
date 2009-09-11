From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 17:25:34 -0700
Message-ID: <7vtyza5nup.fsf@alter.siamese.dyndns.org>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com>
 <200909101850.26109.jnareb@gmail.com>
 <43d8ce650909101246l50189c97r4f3fc4a8d7a0bd4@mail.gmail.com>
 <200909102223.31602.jnareb@gmail.com>
 <43d8ce650909101504q32448cb9w562a43969d01b1fe@mail.gmail.com>
 <7v4ora76vr.fsf@alter.siamese.dyndns.org>
 <43d8ce650909101718j2f1f77cbgc347ee755145353f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 02:26:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mltxu-0000Fx-OE
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 02:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbZIKAZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 20:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZIKAZq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 20:25:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55171 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZIKAZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 20:25:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 842C32DED8;
	Thu, 10 Sep 2009 20:25:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L6Rfy/roEmLXQ5N4JAgjiZeWmSU=; b=bIDKV8
	wFvtdz1xbQq+UywcdRL6/d4hOn3rKv8EH0bIkHmEwaKoIsceyui3XfXaVcfzVmKR
	PBpL/AxPNqKggc79lKEXVuMM76oNvklF2viyrCzsYX39BSh29mESDgDebyUJPaUF
	Xn2mbVyz/igz/VZvoWSyWJToemCSVqXB+fJxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vV4RumOd3qkpp4VCKlp3NJyOEgSyS6x7
	KCVst+f4ijU8XHXM92JfM1PjPyhLGhNzFY87Y1K+r3qaGKfyZZKzfqYnOnZfenfm
	0fxwxxoMIckkBFMsNTU5FU3sslHmQokM+0ht3+0MB2J23DZJMtLHkmaoZaUF1pJI
	aOLN9aqWuWo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 423722DED5;
	Thu, 10 Sep 2009 20:25:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CA5A2DED0; Thu, 10 Sep
 2009 20:25:36 -0400 (EDT)
In-Reply-To: <43d8ce650909101718j2f1f77cbgc347ee755145353f@mail.gmail.com>
 (John Tapsell's message of "Fri\, 11 Sep 2009 03\:18\:55 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3AC8952-9E69-11DE-8BC5-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128164>

John Tapsell <johnflux@gmail.com> writes:

>>        git archive >my.file.tar
>
> I thought you didn't like this because then you dump binary to the
> console by default ?

No. That objection came from Jakub and I said it did not make sense to me.

> Why would it be so bad to do:
>
> git archive -f - | down stream commands

Are you seriously asking "why" after I said this?

>> and people who want to pipe (which is 99% of the use pattern for me) can
>> say

If you really need it to be spelled out,...

Because I have to say "-f -" 99% of the time without no good reason.
