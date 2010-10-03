From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2010, #07; Wed, 29)
Date: Sun, 03 Oct 2010 16:34:15 -0700
Message-ID: <7vbp7aetqg.fsf@alter.siamese.dyndns.org>
References: <7vocbgkrw5.fsf@alter.siamese.dyndns.org>
 <AANLkTim+GTjaCDHAGG1MGxyZ4sTSPan0eZHY_5Q1BZh2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Y4a-000625-9J
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab0JCXeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 19:34:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0JCXeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 19:34:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F640DB24D;
	Sun,  3 Oct 2010 19:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=pSuzezP/me/SnE2yAvRhMx/ea
	vA=; b=ro3DQj3Q+HQmYFU9qKKg6VUb2oZOQ7uVPhNzLi8X7OtAesbTtNxBH7TRx
	oimvDif0CX2/LER7TC1g9PahD/54NI7czFqflnlZdV+u3eE+VTjvPbRerCpbDQdy
	RU2kHQCQuwnK7AqrurW0fF+Aopw34CPdCbekiOfeM3S8uvA2Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=v96QM/xF7V2cBqrfrb1
	iyN5DPnhOMY7CtvxO66X1dS2jpmhNoPS014O5QnDg7+Y07XmyGgQQaRl33dLOGu6
	C3iMzhYA5bQYP/V39W4kb0RxtEUBFWDXShLR+pPaUA3RAR/T/hkfzyUIgTzg084f
	CJ5XhKpk2bGI+GQjeoPF0pt8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 62B26DB24A;
	Sun,  3 Oct 2010 19:34:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96A38DB248; Sun,  3 Oct
 2010 19:34:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BE6B5F98-CF46-11DF-8192-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157950>

Elijah Newren <newren@gmail.com> writes:

> On Wed, Sep 29, 2010 at 6:16 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> What's cooking in git.git (Sep 2010, #07; Wed, 29)
>> --------------------------------------------------
>>
>> * en/object-list-with-pathspec (2010-09-20) 8 commits
>>  - Add testcases showing how pathspecs are handled with rev-list --o=
bjects
>>  - Make rev-list --objects work together with pathspecs
>
> These two commits (a3481510, facc50e04) each have two signoffs from
> you, Junio (in addition to one from Nguy=E1=BB=85n and one from me). =
 Was this
> double sign-off intentional?

Yes.  With the last one I am saying that Duy took two that originally c=
ame
from you that I took, and sent it out possibly with cleanups.
