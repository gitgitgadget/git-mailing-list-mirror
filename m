From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] cherry-pick: add --skip-empty option
Date: Thu, 06 Jun 2013 12:21:34 -0700
Message-ID: <7vy5anxcxt.fsf@alter.siamese.dyndns.org>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
	<1370509144-31974-4-git-send-email-felipe.contreras@gmail.com>
	<7vbo7jytv5.fsf@alter.siamese.dyndns.org>
	<CAMP44s3b2K0nbfuhNqB6FNevdPjVByQCpAie5nzAjx8bw5Y+RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:21:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukfkj-0006M4-0b
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab3FFTVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 15:21:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab3FFTVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:21:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3688426949;
	Thu,  6 Jun 2013 19:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9AwYNlmh9eBBb471mHqxCojoTwU=; b=fMrDTF
	l79u0vM8ps/vPvIfUfJOZP+J6lgI+vE0Cr3Lue8oxPNFtfllegwfhz8shfmjmSgO
	3fthpLuEWP52IQJ2JdVyaTb57RDNl4dHKfvGm2WyJUvSTKNHCDj5fvgCFgsngUYR
	VcroQOTGcKT0utn9r6zQ52Ka+z8B9fxIk03UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f0F4yiXicBBdD2qh8T1aOs42JLBtXAMi
	dbI45etpMu0zI62v/xkf+TrbiPKLJZCe/TiQoaJKOuDaUN9oZTCE4/ALh1n3Q/4V
	3iErBO6xRbxE67yfTVRVpnj7b1suCjDYVrEnF7J0znYttjqB0vytu9T0nMXRmJXC
	vVzsJ3YJolI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D4C126948;
	Thu,  6 Jun 2013 19:21:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA52726946;
	Thu,  6 Jun 2013 19:21:35 +0000 (UTC)
In-Reply-To: <CAMP44s3b2K0nbfuhNqB6FNevdPjVByQCpAie5nzAjx8bw5Y+RQ@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 6 Jun 2013 13:34:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC06A0A-CEDE-11E2-91F4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226530>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Jun 6, 2013 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Pretty much what it says on the tin.
>>
>> And a bit more, isn't it?
>>
>> The --keep-redundant-commits option implies the --allow-empty option
>> and it was perfectly acceptable to give both.  By making sure that
>> only at most one of -k-r-d, -a-e or -s-e is given, this forbids that
>> usage.
>>
>> "It is implied so there is no *need* to give it redundantly" is
>> different from "It is implied so you shouldn't give it redundantly".
>
> Remove that line then.

That's what the submitter does.

Thanks.
