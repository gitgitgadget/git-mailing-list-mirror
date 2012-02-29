From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Incremental updates to What's cooking
Date: Wed, 29 Feb 2012 12:48:12 -0800
Message-ID: <7vfwdts6wj.fsf@alter.siamese.dyndns.org>
References: <7vy5rn1mar.fsf@alter.siamese.dyndns.org>
 <4F4DD5C1.60604@in.waw.pl> <7vbooiuj6z.fsf@alter.siamese.dyndns.org>
 <4F4E2D32.9030209@in.waw.pl> <7v1updtp57.fsf@alter.siamese.dyndns.org>
 <4F4E8846.6030203@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 29 21:48:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2qRh-0008Ff-Ut
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 21:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859Ab2B2UsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 15:48:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56985 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755760Ab2B2UsP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 15:48:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0E0163C9;
	Wed, 29 Feb 2012 15:48:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TJiykT4nmNHx
	B1MPMEDoJTKrze0=; b=xEJZTdH3vOvK/iQcEOISDod2m6+zJ0XeHwJGb+S1aCtO
	siQdabL1v8+Y9tkVGyCZC6uwUQIR8OIunXYisn+5QskyyT8WCgF0eYtT+PtOI5G5
	r5oeVzJfwkP3sOLZ70RF/RjNHDd4ugdnKLlEApzWBlRe/6+AglApocNw4Uqo1wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mfPKG2
	nodYYydfOHm0zTCzv5jBp8rCvwlbc1nm284vzooKLBAzCD5Lw3YH0uSa83u70N8J
	q7/oXEpaH0CNR9PHj/FOuH30ymoGPH84UjkwpejGqNKYn/wE3UtfLcuVtzWwVo6D
	KTrnaKljUx3PVjQjBOrnzHoG+4Pzrrhcd2d+Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C81B263C8;
	Wed, 29 Feb 2012 15:48:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AA6363C7; Wed, 29 Feb 2012
 15:48:14 -0500 (EST)
In-Reply-To: <4F4E8846.6030203@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Wed, 29 Feb 2012 21:19:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B311304A-6316-11E1-9752-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191854>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> Do you mean move a version of non-duplicated ones from t4014 to t4052
> and remove the duplicated ones?

Err, non-duplicated ones do not have anything to do with your series, n=
o?
They are good copies you inherited from people who touched the file bef=
ore
you, and we can leave the file in the state before this series.

Among the ones added to t4014, there are ones that have moral equivalen=
t
in t4052.  These in t4052 are however less nice.  So I was suggesting t=
o
replace these less nice ones in t4052 with their equivalents in t4014.
With such an update to t4052, the ones in t4014 that are duplicates in =
the
today's code can be removed, as we would have identical copies of them =
in
t4052.
