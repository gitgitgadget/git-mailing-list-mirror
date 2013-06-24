From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff returns fatal error with core.safecrlf is set to true.
Date: Mon, 24 Jun 2013 11:19:52 -0700
Message-ID: <7vbo6v9xrr.fsf@alter.siamese.dyndns.org>
References: <6a3d8a2b19a859d8c969ee434e1d6a89@meuh.org>
	<7vobazo4ds.fsf@alter.siamese.dyndns.org>
	<7vip17ktyz.fsf@alter.siamese.dyndns.org>
	<b8e932cba326588db09ebd0986913ac2@meuh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 20:20:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrBMt-0004HB-C5
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab3FXSTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Jun 2013 14:19:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53821 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470Ab3FXSTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jun 2013 14:19:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E8FD2B72B;
	Mon, 24 Jun 2013 18:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h+XylnrQIYXg
	Im+QZLNcOGmHAgk=; b=xrupUfW+KxLQabbLGhef6ehpNgCCCcIBzWihHEQX7Aik
	wERnQkiOpU4skTFK3MQ2rwMtNIh5fEVs3hVnf3jfzaDveSVyFfDa8CROtjfDmwqz
	EtX3xPYg+sDPKDhIdlfdSG2Nq4W1tVNIJYcutqruCiv3s8/J/iDb0vWygc2mvAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZknOum
	gKxiXd9I3MNf01RzyjtfpRB2RlhBigC5GmGjs9Z/AVUMbjarWZQrYFhYbkmP1y8S
	Swtt6RxC0JE3/fXy0qUB48W6op0VopdnwkXQm8CiPvl5APZ2g4+L/Ak52mxVkKW4
	/VQO0gikamaXhx34wxEA5SxOpmyigfPq0DRx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 425172B72A;
	Mon, 24 Jun 2013 18:19:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B48A02B728;
	Mon, 24 Jun 2013 18:19:53 +0000 (UTC)
In-Reply-To: <b8e932cba326588db09ebd0986913ac2@meuh.org> (Yann Droneaud's
	message of "Mon, 24 Jun 2013 14:42:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AAA637F2-DCFA-11E2-8590-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228889>

Yann Droneaud <ydroneaud@opteya.com> writes:

> Hi,
>
> Le 21.06.2013 23:57, Junio C Hamano a =C3=A9crit=C2=A0:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> The helper may want to learn a way to be told to demote that error
>>> to a warning.
>>
>> Perhaps something like this?
>>
>
> Thanks for the patch.

Care to turn it into an appliable patch with tests?

Thanks.
