From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git apply" can't add new files to repo ?
Date: Fri, 15 Jul 2011 13:13:27 -0700
Message-ID: <7v4o2n1evs.fsf@alter.siamese.dyndns.org>
References: <CAAnh3_-ayozWnHR-ViJ3zjXQvPQA1kd9spGV_TEU=-kFzBytvw@mail.gmail.com>
 <1310758497.7308.20.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yang <teddyyyy123@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Jul 15 22:13:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qholg-00085O-7V
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab1GOUNj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 16:13:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37392 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756008Ab1GOUNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 16:13:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 817CD4E38;
	Fri, 15 Jul 2011 16:13:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yLUYamP+sP6O
	88Hgn6RkB3LlkS4=; b=fWSRTdJDWJKrxv17nILTHlM4fT3F1XWHTJDvDNfOP+DD
	zsI6WPKKP8SpVuPKw8Ix/hw8/83mCobbI+Vk4/1goNJM4s3YEKYYw9sLDX0Zc8Iq
	+KYSySnDNaBnQsoi3knrwA9A+jY7uPvc4A3eTaslmYjyYJK52Y7/Sc1qulMalNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qkN4fu
	wbUbtINgjJx0ccN6OJg2FHvxfA4/IhLWb8bp2lxzOKeye+g+iwJwd9ADrQbTeD/W
	nAk/2vgqbg+8A0/WBuB2rbroZxrj5cZ+Ec8BHo6jPPOJ5egm4/LQINKhOGP1txYG
	4T7R7bOFtZ6Fom1BTwqopzzM0JULc6KBV9q34=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 796024E37;
	Fri, 15 Jul 2011 16:13:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F6894E35; Fri, 15 Jul 2011
 16:13:28 -0400 (EDT)
In-Reply-To: <1310758497.7308.20.camel@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 15 Jul 2011 21:34:57
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E79BCEEE-AF1E-11E0-8B7E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177223>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> git-apply is just a wrapper around the patch(1) utility.

Huh?
