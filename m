From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] log: Do not decorate replacements with
 --no-replace-objects
Date: Thu, 25 Aug 2011 14:22:21 -0700
Message-ID: <7vty95i3ua.fsf@alter.siamese.dyndns.org>
References: <4E566586.5010901@drmicha.warpmail.net>
 <739ff64bdbd0c099b3baf0755c0350de82c1ec0a.1314284204.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 23:22:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwhNf-00056e-FF
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 23:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab1HYVWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 17:22:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755434Ab1HYVWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 17:22:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD30D4CA6;
	Thu, 25 Aug 2011 17:22:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y5M7ECZHhAjjfYSwTTjjtEcW9zg=; b=CSNgUE
	fPy/0CgHnxjwtVCOrTyJlRjh4DEIETX9vf6vkfeSxfGjkOm7Ltuau4BD9j+Di8PY
	E0HnkshuujiCufrL+7hJNn97gjKtIfQLEq9b2SCbWEtX/cV1G5KCZ1XbJgKfwxsg
	ModIurZIWEAlnrEiVLfDAKcRNC4Petqf6eJpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FfUQpBBz/iqxorZ63KaBMnZt8QKiIoaE
	RGuG5eLBnbO6obfbDgs2jzJC/IKcyquKX/pWB7LlkanqtnHnb6GyNBYbF3l69hg3
	B35aP1qP8oR1YxWdXjNmtIonFOsDeGrb504PV5axcw5usirDIjHFv/Iv8ey0whdZ
	OrXfnkSErok=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A464E4CA5;
	Thu, 25 Aug 2011 17:22:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 238D34C9A; Thu, 25 Aug 2011
 17:22:23 -0400 (EDT)
In-Reply-To: <739ff64bdbd0c099b3baf0755c0350de82c1ec0a.1314284204.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 25 Aug 2011 17:09:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52A683DA-CF60-11E0-81A3-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180121>

Thanks, both. Will apply.
