From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull l10n updates for 1.8.2 round 2
Date: Mon, 18 Feb 2013 00:02:10 -0800
Message-ID: <7vwqu6aw3h.fsf@alter.siamese.dyndns.org>
References: <CANYiYbHRzS6EUgRBekc+m0Sf3nYDcb9108xk1goH+=QDw36EDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	David =?utf-8?B?SHJiw6HEjQ==?= <david@hrbac.cz>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:02:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7LgM-0004BE-I8
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 09:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab3BRICO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 03:02:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43182 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab3BRICN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 03:02:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B13A0C3;
	Mon, 18 Feb 2013 03:02:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ijdgWpF1+kGduXblaGU4Pe4zzjw=; b=ocXhCo
	9/zkaH3guu+RcaVt7v3X3EQkKzWbCnPIYTQhmtZdptqCvR3qrTePZWMSyOFytLin
	X2Af7oT9BU7RNLsUQ1+7O3Lsal9SVpMPz8FzNX5GkHlfYPj5BQFRtsX8d67Xj2DT
	2tno+t5TbKPcZK0kaN2+VG1IDhtAmpPvhgN0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sKu+/pFCEDe+0aSk0CvPWnqiEQaUeMr/
	PKXNMhNLuV6u82PI9F03wZr0CVvDVlwAH2pSmPQ+Eu2YLglQVHe2zsfuOj9+hFyK
	eF+jgREwdkrbkRIOXTjqO7wo+24yDcuFcI7s3Wke5qCVpHX+8X/xbQRQWEJOvg/i
	OpVxZWg8ymc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9A65A0C2;
	Mon, 18 Feb 2013 03:02:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 651C3A0C1; Mon, 18 Feb 2013
 03:02:12 -0500 (EST)
In-Reply-To: <CANYiYbHRzS6EUgRBekc+m0Sf3nYDcb9108xk1goH+=QDw36EDA@mail.gmail.com> (Jiang
 Xin's message of "Mon, 18 Feb 2013 14:41:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 805C902A-79A1-11E2-B6F6-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216441>

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull l10n updates for git 1.8.2 round 2.
>
> BTW, I find there are new updates in master branch and next branch:
>
>     $ po-helper.sh check update
>     New l10n updates found in "master" branch of remote "<kernel>":
>         5 new messages.
>
>     New l10n updates found in "next" branch of remote "<kernel>":
>         6 new, 2 removed messages.
>
> So there will be another 1 or 2 rounds of translations.

Thanks.
