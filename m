From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dates in Commits and other issues of style (Re: [RFC 2/5] Pretty
 Print: show tz when using DATE_LOCAL)
Date: Mon, 25 Apr 2011 11:29:58 -0700
Message-ID: <7vipu2jiah.fsf@alter.siamese.dyndns.org>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
 <acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
 <7vtydrutbq.fsf@alter.siamese.dyndns.org>
 <811b01a9-f10e-4444-9e5e-581adaf059c2-mfwitten@gmail.com>
 <87sjt76rzo.fsf@catnip.gol.com> <7vhb9nkmo1.fsf@alter.siamese.dyndns.org>
 <m3bozuwqyz.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Michael Witten <mfwitten@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEQY9-0001mN-DR
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 20:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808Ab1DYSaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 14:30:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758203Ab1DYSaN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 14:30:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2AB05476;
	Mon, 25 Apr 2011 14:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0TEF6sdakieT2qAq9/dIfAS1leI=; b=tsyBkfovhgkC2wyKyiA0
	k9NlzD+FiNoIPLM3Za5n7cUDtonpcK165CHi/cbdOd3ayWG8dVe1aaxk0HCC/XVo
	hKAzY3DPuMFIdV/nf6D8/2us0OUbhjlGvD9LsZOIAIsXbVCiq4Pf2OwPeWxo1Klv
	eI72jLcmLLHiZu3ucwbGz6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lzuLYAXsvC5XuTOA9zN/hh95bh5giXGVwYsi1pBBsVdGS4
	Q0XVTTMjgc/lLYt8J3nkabMis+bK8FZJJmNvq/Zv/C8nCuC0cdAcg2ZiRKWCX7a8
	JC+PttJc5RAauyVcEt8hIWHAvp1FnV7xXdsIw/Z3kOOu2uX8uW2rOMUmnfek4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEEBA5466;
	Mon, 25 Apr 2011 14:32:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 535045464; Mon, 25 Apr 2011
 14:32:02 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53525166-6F6A-11E0-BF28-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172036>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Enforcing consistency is one of the important tasks the maintainers do...
>
> This information should be put e.g. in SubmittingPatches, or
> CodingGuidelines, or MaintNotes, isn't it?

The above "we value consistency" should be already inferrable by reading
SubmittingPatches and CodingStyle in reverse?  If it were up to the
contributors to ignore them, there is no point to have these guides to
begin with.

If we want to keep these words somewhere, I think the place to put it
would probably be the Policy section of Doc/howto/maintain-git.txt.
