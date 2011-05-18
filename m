From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a debug mode for git-clone https traffic?
Date: Tue, 17 May 2011 22:33:07 -0700
Message-ID: <7v4o4sefos.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=-i063MqrboT1MHrQy-vM0yBTUGg@mail.gmail.com>
 <BANLkTinmoJA6tZDaGD9K9cBm_dbmti=P=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 07:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMZNq-00042o-Ea
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 07:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675Ab1ERFdS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 01:33:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab1ERFdR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 01:33:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B41702420;
	Wed, 18 May 2011 01:35:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wDO4wOHs2hjh
	y0pbscrmyXezdXs=; b=C4d1xOPGPsUHGO4no5l4XI1XmgRYF4JGE+c0OJN4740+
	XrAdo+HqltmwcIHIM107Oj8IIxevugkWlPAAT/kXpSsb+n/BdaCAdTUKJH29Ur2m
	hw7TPliTP4/T4FbYwb3Ek/JUXCZ9Sb4nxBLdkJ2iYmD5jC2ZkHZbKOPyX9J+CvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rejpql
	q4B6TfFL6NJzdFYiJY/3rQ87mgvceNrzvPHM961lbCwuJKK1jiL89RKXT6xBuzxG
	WLkuzULdhuuNUak0c5zurXW/5FM8KMYLrFdIlQ441rD1uhzaikqxST2jlMzyoXCE
	NoKvUvTMAa5CDbPRC0AA/bQAwxxOZbH/RK7Y8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8288D241F;
	Wed, 18 May 2011 01:35:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7CA98241D; Wed, 18 May 2011
 01:35:17 -0400 (EDT)
In-Reply-To: <BANLkTinmoJA6tZDaGD9K9cBm_dbmti=P=w@mail.gmail.com> (Tay Ray
 Chuan's message of "Wed, 18 May 2011 13:29:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F61AF4A-8110-11E0-B437-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173847>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Wed, May 18, 2011 at 7:08 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>>
>> I''m trying to debug a problem where over a https proxy I have
>> "warning: remote HEAD refers to nonexistent ref, unable to checkout.=
"
>> when doing git-clone.
>>
>> I suspect that it might be an overzealous security scanner sitting i=
n
>> the middle.
>>
>> Is there some debugging mode for git-clone where it'll dump the
>> traffic being sent over the wire that I could use to confirm this?
>
> Run the process with GIT_CURL_VERBOSE=3D1. There's also another optio=
n
> to debug communication between transport helpers but I forget what it
> is.

GIT_TRACE_PACKET
