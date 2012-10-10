From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/12] Wildmatch v4
Date: Wed, 10 Oct 2012 16:48:35 -0700
Message-ID: <7vd30panxo.fsf@alter.siamese.dyndns.org>
References: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:48:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM61D-0000RM-R7
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 01:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757628Ab2JJXso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 19:48:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198Ab2JJXsk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 19:48:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97EC291F5;
	Wed, 10 Oct 2012 19:48:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=h260KABdOk8D
	yUqNBzIkqMnv7QU=; b=UyZCAGJ3GJAY7mgZXdTcxUPD/HBhUWXIeV9WCP9b7jKn
	wkeGQ7v1oJCgnlLcK5GOSYZGX8gPXeht5eXLXDzT8mRJsGwR6/W60OHd/3VoPN0D
	9KQ8H8/wqp6bMls3wXIW2bujIf/MR956HYECPCMuSIwdUdljx1YXt9jNCbHRGPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AuTelE
	bdZQLgYXs05CTVBO0bUr+MVOI71z66sdwKQ3TwS1tGt7QBXzxBUdUTOZAn5Gb4aD
	YciD5XQcweROJpK6PvxOfUGT0ryQdA3/Hw4Fzv9ALQVHbet53jQ3cOhtd2IC/4MQ
	o6OqyxqvGdvYQybIzApmw2ofw0IpZTHEs4NXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85B1F91F4;
	Wed, 10 Oct 2012 19:48:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFCFE91F3; Wed, 10 Oct 2012
 19:48:36 -0400 (EDT)
In-Reply-To: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 10 Oct
 2012 17:40:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 027439F6-1335-11E2-BD4D-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207452>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Really small updates. I did not want to resend it this soon but this
> may fix the compile errors for Junio.

Thanks; queued and pushed out on 'pu'.  Comments later.
