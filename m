From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid rename/add conflict when contents are identical
Date: Fri, 03 Sep 2010 11:29:32 -0700
Message-ID: <7vbp8eznn7.fsf@alter.siamese.dyndns.org>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
 <7vd3tnmht0.fsf@alter.siamese.dyndns.org>
 <EF9FEAB3A4B7D245B0801936B6EF4A25262E13@azsmsx503.amr.corp.intel.com>
 <AANLkTik2op0_Cq13EGit17ja+zCdmbM6WXJ=rfhQMnOQ@mail.gmail.com>
 <EF9FEAB3A4B7D245B0801936B6EF4A2533DBB8@azsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Schalk\, Ken" <ken.schalk@intel.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 20:29:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orb1I-0006wP-N4
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 20:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757215Ab0ICS3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 14:29:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082Ab0ICS3m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 14:29:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F8F9D3BA2;
	Fri,  3 Sep 2010 14:29:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wyorV5vKXiaHIGoC37xOcEV5zp8=; b=u1kpOZ
	OgfYX2f+sTqfS7Q5mGktz+ueIQja2GSDCmOEw035HKmo7PzM435HQIcUsbvQXatp
	pNaKkOyAaa19rXm0PCc1OalK4CjWT0GnqNPhtse32jGnXkqedJiDtGFEBVI9JDpH
	kFS4TdQxfHVkV79STtQRAPWpbL+ugOunIPixs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w9/vdH5FG+ysSb3kwjk1QWfBudfrTDFV
	PH4rWqeMCgDeQuGXkdXpEViOcqsb9f5fHd+rzk4J8tJYqgraDHDNzxu6L3SdnKv2
	WWQyqKierdzqct4gTHP6gYqE7n29PTBWVAVZsmVWvAm9wfgW2BykBHpn6VQn22rE
	EfNgqKoJDJk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67767D3B9D;
	Fri,  3 Sep 2010 14:29:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96BD3D3B9B; Fri,  3 Sep
 2010 14:29:34 -0400 (EDT)
In-Reply-To: <EF9FEAB3A4B7D245B0801936B6EF4A2533DBB8@azsmsx503.amr.corp.intel.com> (Ken
 Schalk's message of "Wed\, 1 Sep 2010 13\:15\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35B5E706-B789-11DF-A203-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155260>

Thanks; the patch somehow had all tabs expanded, but I can fix it up.
