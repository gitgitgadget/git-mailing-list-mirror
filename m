From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2011, #02; Sun, 6)
Date: Tue, 08 Nov 2011 08:21:20 -0800
Message-ID: <7v8vnqzitb.fsf@alter.siamese.dyndns.org>
References: <7vehxl57lt.fsf@alter.siamese.dyndns.org>
 <4EB91D2C.6020504@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan =?utf-8?Q?N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 17:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNoQV-0006hP-Je
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 17:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab1KHQV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 11:21:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43672 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab1KHQVX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 11:21:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E844511C;
	Tue,  8 Nov 2011 11:21:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PJjXAIOoOKjk
	syaiUsdNqhYIVyA=; b=Da3gyLAEeNu1SGVb/a4j5sPATKJQXAX8/Reai98WJBMm
	y9pa3JiwNZmZehfKKCQMgbuukceACSsozol0RBkk1Ydzmy5Zybme2pf1yMA5cM8Z
	qBjx0ZR+b2VnOsUiwvrZ+5u0Ld338IqjIVIMCgNOLcMxJGuLB25nAIATOxM5rjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NGovV+
	FrfCuuuKRYFKcCQUxE9o5ldvk1zdmcT0PTQgBFA+amFFzDBeb0IOWHLHFk0OR2bV
	6ff415uCmvMCqACIQuAIuDXdj0MzcTbPyRXuE0NB9VCbxS7c/0TWvrkmoA9Ngaq+
	ResQMc3se1kcoCmrzSxu5Rc8qoVBIfIlQxPn4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9580D511A;
	Tue,  8 Nov 2011 11:21:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14C925117; Tue,  8 Nov 2011
 11:21:21 -0500 (EST)
In-Reply-To: <4EB91D2C.6020504@atlas-elektronik.com> ("Stefan =?utf-8?Q?N?=
 =?utf-8?Q?=C3=A4we=22's?= message of "Tue, 08 Nov 2011 13:14:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B266C69A-0A25-11E1-A526-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185093>

Stefan N=C3=A4we <stefan.naewe@atlas-elektronik.com> writes:

> This breaks the 'quick-install-{doc,html,man}' make targets, btw.

Thanks. As the "push into kernel.org auto-rebuilds these branches"
infrastructure is no longer available, I think we should remove these
targets and description of them in the INSTALL file in the meantime.

Anybody care to do a big removal patch?
