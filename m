From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] i18n: add stub Q_() wrapper for ngettext
Date: Wed, 09 Mar 2011 23:59:09 -0800
Message-ID: <7vd3lz76eq.fsf@alter.siamese.dyndns.org>
References: <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org> <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie> <20110309105236.GC30980@elie>
 <7vfwqw9g9b.fsf@alter.siamese.dyndns.org> <20110309205155.GC22292@elie>
 <7v7hc89fp7.fsf@alter.siamese.dyndns.org> <20110310031734.GA24781@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 08:59:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxamM-0007Ev-PF
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 08:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab1CJH7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 02:59:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab1CJH7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 02:59:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4F5AB2935;
	Thu, 10 Mar 2011 03:00:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WFFGeTV23SP09evg+Sa238AT1YM=; b=uSYZn4
	K55jLY62nLic0i9HEXE43ZYYd9qRvn1l7wvyRiaH01CVHBMnB9nHpUYguAdRSIt5
	Vm3bnryCu2UU41cUCozLkoJBkb9HW4dOLGZ3JvPluLnYGLT3S8M6CqNpGhxeh2iP
	inSnu9TSTlt56P5/hdQrkSlcM0PLbjWXZIJLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyalkG7R9s3mgEHdI+ET8CpQhO2anEXG
	3NXrrONj8Os9Bxh9yOrGATtTmAoeoogMobrEi83paFNnyfG8rDjphRocBJCaOqoe
	/ZF8BilgW9XYb5yQ896woXxB4BOCutyFJ4+/TbDf2xassC8gWJg55ty22cLQmiKb
	VTKwOjWlhdU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E8F22934;
	Thu, 10 Mar 2011 03:00:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 026072933; Thu, 10 Mar 2011
 03:00:40 -0500 (EST)
In-Reply-To: <20110310031734.GA24781@elie> (Jonathan Nieder's message of
 "Wed, 9 Mar 2011 21:17:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 808A1300-4AEC-11E0-AFFE-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168795>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I suppose Q_ is as good a name as any.

Ok, let's run with this for now, as we hopefully don't have too many
places that might want to use ngettext(), and they should wait until the
early parts of the series settles and in-flight topics are adjusted to the
barebones infrastructure.

Thanks.
