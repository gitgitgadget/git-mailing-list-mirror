From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 2/4] t7512-status-help.sh: better advices for git
 status
Date: Mon, 04 Jun 2012 15:07:33 -0700
Message-ID: <7v396aspcq.fsf@alter.siamese.dyndns.org>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-2-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vvcj8xffp.fsf@alter.siamese.dyndns.org>
 <20120604120406.Horde.ge3VMHwdC4BPzIgWN72l8oA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Tue Jun 05 00:07:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbfR7-0008Uz-PC
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 00:07:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121Ab2FDWHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 18:07:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746Ab2FDWHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 18:07:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B82C8778;
	Mon,  4 Jun 2012 18:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ehUaMgbwMD1GgtIcDfXF0paamgQ=; b=RScUA+
	QoQxiSll/GP3w10JYKsCpDP315sIshph3gAsxsOh5Zv5d8PV+VgvNVUm/6+vbzp6
	FM27IL58GumY3/POIIfsNXFow51auPateEEhCmPRl5t2Q2Xg0vTA1Ua1EJdxMszT
	I5JkF53IVstXVhDIHT7dJx6/CDiydYm9POlEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SlY8XAp8VQrHt+qwMGYyA2uyyJT1Yk4s
	Ac8UoRG2uBh7VQvdSVid03uoIi5UR2lkCda9MweDytaikG+0dV/HKu9KjuDQ26C1
	3/VPBTmPBcB3OVZ4H4K4631E0oiMPeJZScdFdB5n+c9Nb/HurGcVf9Sgqaq82Q6j
	41U88shQsTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91EDF8777;
	Mon,  4 Jun 2012 18:07:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 144F98776; Mon,  4 Jun 2012
 18:07:35 -0400 (EDT)
In-Reply-To: <20120604120406.Horde.ge3VMHwdC4BPzIgWN72l8oA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Mon, 04 Jun 2012 12:04:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B075D018-AE91-11E1-9DF0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199192>

konglu@minatec.inpg.fr writes:

> Junio C Hamano <gitster@pobox.com>:
>
>> I thought Matthieu always called himself "Matthieu Moy", not the
>> other way around.  I also inferred the convention used for naming
>> the mailboxes at your institution to be "$First.$Last@$Domain",
>> which tells me that perhaps these names are all spelled backwards,
>> i.e. "$Last $First", which probably goes against the convention used
>> around you and Matthieu?
>
> Hm, yeah it's spelled backwards, I didn't take notice of that.

Oh, another thing.  In your v7 series, your author name (appears on
the From: header of the email) is spelled in K-L order, but your
Sign-off is the other way around, i.e. L-K.

Names of some people are spelled in Family-Given order even in
English context [*1*], and I do not have any objection if you are
following that cultural practice for _your own_ name.

I however want to see it done consistently between Author: and
Signed-off-by: lines.


[Footnote]

*1* Prime minister Lee Myung-bak, chairman Mao Zedong are some
examples.  Somewhat strangely, not prime minister Yoshihiko Noda,
even though some Japanese insist on spelling their names like
"FAMILY Given", with family name in all caps.
