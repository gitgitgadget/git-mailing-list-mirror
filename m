From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit-tree documentation incorrect parameter sequence
Date: Wed, 20 Jun 2012 10:58:30 -0700
Message-ID: <7va9zxx3uh.fsf@alter.siamese.dyndns.org>
References: <CAHtLG6S3ZyBV+0KxKLUSCO7yOXLGD1NGhM62sJfKPUMSeQTSoQ@mail.gmail.com>
 <20120620003726.GA6741@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:58:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShPAs-0007Nz-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab2FTR6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 13:58:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753437Ab2FTR6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 13:58:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6527181A3;
	Wed, 20 Jun 2012 13:58:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=c0Az+HCZLJko
	UhYpucWSjiRfb7E=; b=ryy4Tb8bY7PcerRiGz7YJOOlzH2oWwN/UfmZ2yzDS90f
	aRAcXfcPhU+7OnNW46YsU0LpgrKNUop9igWkHqBkWqMfiBd9hjRzUl+1Emgbe3lY
	QZq6GOrfJ0i1UE8GKOHb/V5/VYr2I/o/vU9+hqlcLtFPasIRsrvXsOGHbWsI/k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gX7QHz
	p3bOzwYi+tL2rqAPVvf6BEp+bPNi3B6hE1K445hxtZYvarA/AcundNQOi3agZEyN
	pLEwN4bs0OPbcHEH4AknZDJX7/UsZCaF38ZiYc8fs0j9kV/lZ72phRLaGNnEFk64
	nY+NrTJqEYVM2F48osWS2m4wjKzCbDVJuBMYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B22E81A2;
	Wed, 20 Jun 2012 13:58:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAE9081A0; Wed, 20 Jun 2012
 13:58:31 -0400 (EDT)
In-Reply-To: <20120620003726.GA6741@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 19 Jun 2012 20:37:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C24E682-BB01-11E1-B729-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200310>

Jeff King <peff@peff.net> writes:

> On Sun, Jun 17, 2012 at 09:57:42AM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0=
 wrote:
>
>> In current git commit-tree documentation,
>> the parameter sequence is incorrect.
>>=20
>> git commit-tree <tree> [(-p <parent>)=E2=80=A6] < changelog
>> git commit-tree [(-p <parent>)=E2=80=A6] [(-m <message>)=E2=80=A6] [=
(-F <file>)=E2=80=A6] <tree>
>>=20
>> The second line in incorrect, and <tree> should come first
>> git commit-tree <tree> [(-p <parent>)=E2=80=A6] [(-m <message>)=E2=80=
=A6] [(-F <file>)=E2=80=A6]
>
> Yes, I believe you're right. Would you care to submit a patch?

Done as d28436736.
