From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:54:49 -0800
Message-ID: <7vmxzwh906.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <hjvgs1$rep$1@ger.gmane.org> <ron1-953427.13240429012010@news.gmane.org>
 <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:55:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nayo0-0007S0-B5
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab0A2Vy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806Ab0A2Vy7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:54:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0A2Vy6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 16:54:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1733F95F31;
	Fri, 29 Jan 2010 16:54:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ydN1Lj4Wf9nY
	RWRJRYwGbvnv02w=; b=DR4B+tOcboxPhHBjDG5s9cCARY9Tprebg1aJEqF8Kui9
	WuBE/pfFO7XWRoHjSHCPc/m0gyiIKAT9T0NnuiqcJs2Us0LG/TdNgN8cqBp4WHOV
	HuVChJ5cVU0N06rPRo5jZ6VX3Sk76oNNDDLFi0AUl9rmkwajCG/mPi9eAWCnhLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yYKfdj
	SyK/xTxRWxPxyT9AARAJTNrlFqHtct59OYmmFBYRERC9fqmQBWSjx2+s2iUvEt7Y
	e0OADMGQURtWzZtibVC2Y4V+QUa/FxaGOklNq7P+zcvgYRebWZS6o3XlZiQgMflS
	k/XWBKKlys62V/RwpbCvbgPxYEx2dhkh02FuY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA84195F30;
	Fri, 29 Jan 2010 16:54:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2882195F2E; Fri, 29 Jan
 2010 16:54:51 -0500 (EST)
In-Reply-To: <fabb9a1e1001291328s1df443d6jdf0501cda17072de@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 29 Jan 2010 22\:28\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF430D66-0D20-11DF-B723-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138378>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Jan 29, 2010 at 22:24, Ron Garret <ron1@flownet.com> wrote:
>> Yes, I read that. =C2=A0But what I'm trying to do is not just *look*=
 at the
>> history, I want to restore my working tree to a previous version. =C2=
=A0The
>> "Exploring History" section of the docs doesn't say how to do that.
>
> Do you want to restore your working tree only, or also throw away the
> history? If the former, you could look at 'git revert',...

I think he wanted to check paths out of a commit and the set of paths
happened to be "everything".

IOW, "checkout $commit ."
