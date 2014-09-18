From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Thu, 18 Sep 2014 10:26:19 -0700
Message-ID: <xmqq4mw4q1qc.fsf@gitster.dls.corp.google.com>
References: <20140911030318.GD18279@google.com>
	<xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
	<20140912004717.GY18279@google.com>
	<xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
	<20140912191812.GZ18279@google.com>
	<xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
	<54136B10.4050001@alum.mit.edu> <20140912235745.GB18279@google.com>
	<54198B39.8020405@alum.mit.edu>
	<xmqqfvfoq3ra.fsf@gitster.dls.corp.google.com>
	<20140918165721.GA772@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:26:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUfTO-0000cJ-CA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 19:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbaIRR0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2014 13:26:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59212 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbaIRR0W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Sep 2014 13:26:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76BF43A142;
	Thu, 18 Sep 2014 13:26:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VUS3yCrWPkp6
	qJlFdvLW3a0KfJM=; b=qkW7EPNfaidX0lh/IKMyO0mjcr85btsCT1U9+p9O141A
	IK3IYyVRQ0fsRVwboGcR+qjHOVOp40a13XzgdEa4qpBqCh17mT6gGyb0ThFsTM4W
	haQSpTw7ql5uFf1DQ3qTUXaTYZWGmxH+QcnDYJlz5GC2KDYNqbm9h7A7e1BeZXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gircAg
	4ACSvWoIsASJEcz1MeLoTPkLpBUadUOsp90ZY4Mti27lzZ6zoobRR26gjdRgc5Aa
	+W4a3HfKBiG1kxo2cncyzMSc9vSpOXknLSlD6MZOrWI1QmQfbLGuadXp4bDmdg2T
	gw+Oaw2x4EVo16OVGmUz0F6em36jA57RzSD+8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 692873A141;
	Thu, 18 Sep 2014 13:26:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA1CF3A140;
	Thu, 18 Sep 2014 13:26:20 -0400 (EDT)
In-Reply-To: <20140918165721.GA772@google.com> (Jonathan Nieder's message of
	"Thu, 18 Sep 2014 09:57:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7F28702-3F58-11E4-8FCD-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257268>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jonathan: Is a current version of this patch series set up to be
>> fetched so that it can be reviewed outside Gerrit?
>
> The current tip is 06d707cb63e34fc55a18ecc47e668f3c44acae57 from
> https://code.googlesource.com/git (fetch-by-sha1 should work).  Each
> reroll gets its own refname of the form refs/changes/62/1062/<number>
> with <number> increasing.  The "Download" widget in the top-right
> corner of https://code-review.googlesource.com/1062 shows the refname=
=2E

While I am showing my naivet=C3=A9, how does one figure out that 1062 i=
s
the last one in the series?

Does the order of changes that appear in

https://code-review.googlesource.com/#/q/project:git+branch:master+topi=
c:ref-transaction

have any significance?  e.g. is a "topic" supposed to be a single
strand of pearls on top of the "branch", and the top one is the tip,
or something?

> There are plenty of unaddressed comments from Michael, so I'd hold of=
f
> on picking up the latest for pu for now.

Oh, the request was not for that.  I simply cannot read the patch
with only limited context in the web browser without having a ready
access to a coherent whole, i.e. a full tree with history, to review
a change like this.
