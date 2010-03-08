From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Regression in `git add' in 1.7's 48ffef966c with a wildcard in 
 .gitignore
Date: Mon, 08 Mar 2010 12:20:30 -0800
Message-ID: <7vzl2ir2ep.fsf@alter.siamese.dyndns.org>
References: <51dd1af81003080908i3bc94f27lc99e146bb57993ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 21:20:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NojRV-0003QE-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab0CHUUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 15:20:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755656Ab0CHUUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 15:20:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D011A0C63;
	Mon,  8 Mar 2010 15:20:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wr5CV+xTxHNe5TeUUe9UdpEYgdg=; b=j4PcRd
	vANN0dCicI5Js+Z6wJ96NzHcsFEi2TIUnd+nO3rD4liHQKIreK8fgXhY0iTLR0qP
	jvD+ZEaVzMvD8WFoKScx0hBm3zYOXS4Zdot2IkqeGR1ha/wGqfE+42DwzAK+drLe
	hySC+OKUM8MBMo1O38yRNy+DJ06L0UcCGYX6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f3aEd3sjl/wBYYAryyLRWXnEizdoR2fz
	3S8BUuwPI+fss2suLE2zpk6p+/qJih5zglwx09gmB7Lgk7YuhyS+XLBq5MgFjxb6
	H0TeMx/h3DphPbdJ93zYFbZn/yvpzrHDMvK/5WfqbbvEh9a2SgLS8KDItS3X6wXK
	VAghsE0+S0Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0969AA0C61;
	Mon,  8 Mar 2010 15:20:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B60BA0C60; Mon,  8 Mar
 2010 15:20:32 -0500 (EST)
In-Reply-To: <51dd1af81003080908i3bc94f27lc99e146bb57993ba@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 8 Mar
 2010 17\:08\:23 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D6B2B38-2AF0-11DF-B277-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141783>

I think this is the same one as what we discussed earlier.  Does 13bb0ce
(builtin-add: fix exclude handling, 2010-02-28) that is already queued in
'pu' help?
