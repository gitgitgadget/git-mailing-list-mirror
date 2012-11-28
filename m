From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 11:33:26 -0800
Message-ID: <7v7gp5v7y1.fsf@alter.siamese.dyndns.org>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
 <7vy5hmgovt.fsf@alter.siamese.dyndns.org>
 <CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
 <CAP8UFD08LhywQ9KaNoeG1nORZwtK8MNWqwjfRJPyT2vLkNgs9A@mail.gmail.com>
 <7vmwy1hdgx.fsf@alter.siamese.dyndns.org>
 <CAMP44s3YfLrL+74j5DOVVATK8GWEo1qHnmJDW5dLWJRxK_CVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:33:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnOD-0000gU-AN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab2K1Tdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:33:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab2K1Td3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:33:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 684469B9B;
	Wed, 28 Nov 2012 14:33:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y8iz+CcrFolXhr7zg5Lsm7egoyI=; b=XnT6Xt
	qI3SSEJ87x41+EYVcyIEYsiHeMuIWjILa+uCvdBOyON+BZqnTiokoYTMRM8uH/ds
	iFu4+VARZeaR/Z/Sdg+NLmoU8xDGPG2elQ8s01nRteYbT/3jeDsLub8TLM/tsPMz
	sfxtFzyMiB57/iuDY3eSUFTmv+FO9AjlbzSkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZ1wx/Jgusmtjx6iUE/C+2VkLsZcEu6B
	KwH4i24zPgU9f2ZphzdQ2rCnnWDl74F2NkqwmDzIVH08WKQgHLkpidX0vDVMFlyk
	+goI86btUQhSbrAG+imiqLZxc6vn3BTLuSfSkYCMAeESTeXlyHbEdOQ49f+mrKDM
	7PzX62KBhuo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 570939B9A;
	Wed, 28 Nov 2012 14:33:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB5749B98; Wed, 28 Nov 2012
 14:33:27 -0500 (EST)
In-Reply-To: <CAMP44s3YfLrL+74j5DOVVATK8GWEo1qHnmJDW5dLWJRxK_CVLQ@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 28 Nov 2012 20:19:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BBB2DAA-3992-11E2-A7AD-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210766>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, Nov 28, 2012 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> You need a fix for that; didn't I already say "you need a bit more
>> than that"?
>
> I disagree. Most of the contrib scripts are expected to be used as
> they are.

You are only looking at one of the uses for this script, when there
are two.

You are correct that distros may install with whatever tweaks of
their own, and to help their tweak process (like the one that
specifically notices "/usr/bin/env python" as you wrote), changing
the "#!/usr/bin/python" to match others would be a good change.

But that change alone is not sufficient for this one, which is used
from t/ script.  You cannot treat this one like import-zips and
hg-to-git that we do not use in-tree.  Somewhere before t9020 uses
it, it needs the treatment similar to the rewriting that is done for
git-p4.py to git-p4.
