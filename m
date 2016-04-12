From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: clarify signature verification
Date: Tue, 12 Apr 2016 08:48:58 -0700
Message-ID: <xmqqh9f6su8l.fsf@gitster.mtv.corp.google.com>
References: <20160409200756.GA22694@hashbang.sh>
	<xmqqa8l1ti8d.fsf@gitster.mtv.corp.google.com>
	<20160411003242.GC9034@hashbang.sh>
	<xmqqtwj8rtcd.fsf@gitster.mtv.corp.google.com>
	<20160412010009.GD9034@hashbang.sh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>
To: KellerFuchs <KellerFuchs@hashbang.sh>
X-From: git-owner@vger.kernel.org Tue Apr 12 17:49:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq0ZE-00042h-5V
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 17:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965989AbcDLPtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 11:49:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965012AbcDLPtH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 11:49:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D2E1454DAE;
	Tue, 12 Apr 2016 11:49:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cyvvPFIrePkPWqWhQLe/015sLAQ=; b=wFgNc8
	eUkIO46c3YU8e8qLKY6ivq65nuBuM9DQctyUAMukbynwuUyjJyhl/Z+ke7QSZrJn
	XEi897VwiD27pt1EVXH0vvXSfElbZqmAbgOYBbMmk2+Brk45AOsUz4QZAj9eerSV
	kVtT9wHHE/eSjcfXYU6+aihRB9OICP1ToPkVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sAjwNNMp+YcJ/2pw//fbDsqyBDHyYzTM
	/+2LGdrlGTgU5k4h1N1rzge6gjyS8A4QX7kfwBIZ0+PbQYi/SDUVz7kiTQV3eFpv
	VXG51bCEfDjFlzGqc21x0wtuggblE72gnsTmRrbWY+ek3O+m+fYg3MrivzctEAxo
	X91AOLuo2do=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B306E54DAD;
	Tue, 12 Apr 2016 11:49:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ECCCB54DAB;
	Tue, 12 Apr 2016 11:48:59 -0400 (EDT)
In-Reply-To: <20160412010009.GD9034@hashbang.sh> (KellerFuchs@hashbang.sh's
	message of "Tue, 12 Apr 2016 01:00:09 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12C6060E-00C6-11E6-BC3F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291269>

KellerFuchs <KellerFuchs@hashbang.sh> writes:

> I would rather see something like
>
>>     Verify that the tip commit of the side branch being merged is
>>     signed with a valid key, i.e. a key that has a valid uid: in the
>>     default trust model, this means it has been signed by a trusted key.
>>     If the tip commit of the side branch is not signed with a valid key,
>>     the merge is aborted.
>
> It's unfortunately more verbose, but I don't want to make promises
> about GnuPG's behaviour that depends on the user's configuration.

Good thinking.  Thanks.
