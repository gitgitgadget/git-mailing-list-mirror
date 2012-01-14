From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/10] nd/clone-detached
Date: Fri, 13 Jan 2012 22:53:11 -0800
Message-ID: <7vhazyyduw.fsf@alter.siamese.dyndns.org>
References: <1326189427-20800-1-git-send-email-pclouds@gmail.com>
 <1326439322-15648-1-git-send-email-pclouds@gmail.com>
 <7vvcofxtv8.fsf@alter.siamese.dyndns.org>
 <CACsJy8DggQdM1aoeL+u=3Wz+5f7hi4eG=6MHXPCJZ6pOmhQJ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 07:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlxUg-0004f2-E4
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 07:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab2ANGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 01:53:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60143 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab2ANGxO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 01:53:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82B6C73CE;
	Sat, 14 Jan 2012 01:53:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hFPmx19VEANsbB4EGXORI3AcMf8=; b=xSWMcG
	ryB+wi3EZyAXGfnVteKOi2byIdL04hGXqkUXFltP8z8Yp3cgYTJEC8BPtZqpEwPb
	3KxhBkyddV7Qf8hQk8NSOg13qNxrJAE04RnlJPVUS+e/f8ORoRnlft4JQ74JHgKU
	I6wNILa9rrx23EglRftDC/iBEeo7/cjmyhUa8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QYFwjjuVNW/grdAGZM7m2rbmtmN4MYIr
	8W8o3XZVOLPPIqOn97jSm12QaJs7efhsmsLTKbZWf+nzTIcJB53k6kaeqN1TUHNw
	ZXSJl/RBy7fV6DQFmbKNYJo54VyeSrb+xaOkeSPsG4O/hmB4XK8LhPVNL7QtipE0
	dLa5lxZTGVk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AC4973CD;
	Sat, 14 Jan 2012 01:53:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1241673CC; Sat, 14 Jan 2012
 01:53:12 -0500 (EST)
In-Reply-To: <CACsJy8DggQdM1aoeL+u=3Wz+5f7hi4eG=6MHXPCJZ6pOmhQJ_w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 14 Jan 2012 11:48:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D7194EE-3E7C-11E1-A60F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188550>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/1/14 Junio C Hamano <gitster@pobox.com>:
>> Thanks, replaced (and updated comment strings read much better).
>>
>> There were some conlicts I had to resolve while merging this to 'pu'.
>> I would appreciate it if you can eyeball it to make sure I didn't make
>> silly mistakes there.
>
> Right, the conflict with nd/clone-single-branch. I kept thinking there
> would not be conflict because clone-single-branch's big change was in
> wanted_peer_refs() and missed write_followtags() call. The merge looks
> good.

Hmm, 'pu' seems to fail its selftest with this merge present, though.
