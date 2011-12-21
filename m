From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/log: remove redundant initialization
Date: Wed, 21 Dec 2011 11:16:03 -0800
Message-ID: <7vaa6lhh1o.fsf@alter.siamese.dyndns.org>
References: <4EF1CB87.8050801@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 20:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdRe8-0007g3-Hv
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 20:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab1LUTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 14:16:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436Ab1LUTQF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 14:16:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12198604B;
	Wed, 21 Dec 2011 14:16:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=SAFf3V
	CfGQ8WDtjJXIxgSkPpjRfmAMQw8o18tlRycI89Px7v8+WrgO9UMBVUz+514vMxlT
	nEFENXwuoNwiaMR/acc4Wqa+BCbj93VskSVylpEPt2zq3kEJlEs5GtvqiuOzuUmR
	RyZYx5mnyQS7682iTOvAI6x7Eeld8o8LkI6hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mx4ZeBmCvlMk/c39DSCT9GUXCFgBPMbD
	f7MROzoMJROB6QhTee9RGOrT5m227b8OoWInHz/pVfHJUubmGMrEIAAblo9SX0wT
	5mAYtrFcpbBG2eoaUjVWBJ8YcWmFSCf/ozVxSCmmO9xrHcqrKoIPdht4OsHcPxfh
	+IsEq3dAB8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09B0D604A;
	Wed, 21 Dec 2011 14:16:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E76D6049; Wed, 21 Dec 2011
 14:16:04 -0500 (EST)
In-Reply-To: <4EF1CB87.8050801@elegosoft.com> (Michael Schubert's message of
 "Wed, 21 Dec 2011 13:05:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A381C64-2C08-11E1-BA32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187582>

Thanks.
