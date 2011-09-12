From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Mon, 12 Sep 2011 14:59:49 -0700
Message-ID: <7vipox2wd6.fsf@alter.siamese.dyndns.org>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathon Mah <me@JonathonMah.com>, Dan McGee <dpmcgee@gmail.com>,
	David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 01:07:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Fb4-00075K-Us
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 01:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab1ILXHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 19:07:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab1ILXHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 19:07:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D88594A96;
	Mon, 12 Sep 2011 19:07:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=V26GWTBckjw3/bIZz9GJ7a4MgjU=; b=o+Egq/mD7G/KNJddujsC
	mXiOuwBfQI1l2nlp85Ffq8G7gAgPPmyoNaNVGkJxY0VV0hxUVzkUxhA/CJahugDN
	wZ7UF6xdYDRb91sH7qao7RG7JOcwvkTEplN05ABI4hVOZCpgJfj235hZZ9aGa/5i
	olOp12a856QWexFTQhZ0JlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pp2LM/ajotPpiP/hZR3IG3IXu0Sgqrm0S353yRoBUT2xex
	koPEZJRE5a2o8ybiX9HRs7RXasiJILa1WHz1HORCrNb3B6R+FXIcFD8HO+EeH1dr
	Vf2LRlu5KMeXstXHc+PA6QcPnCGs8p+bmjFiT4nVoj8HgwEYoD8+nxUHeGGXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFE0F4A93;
	Mon, 12 Sep 2011 19:07:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65DFC4A92; Mon, 12 Sep 2011
 19:07:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F65C2E8A-DD93-11E0-A36B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181248>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * jm/mergetool-pathspec (2011-06-22) 2 commits
>  - mergetool: Don't assume paths are unmerged
>  - mergetool: Add tests for filename with whitespace
>
> I think this is a good idea, but it probably needs a re-roll.
> Cf. $gmane/176254, 176255, 166256

What's the plan for this series? Do we still want to pursue it within the
timeframe for the next round?

Is there any mergetool/difftool expert who volunteers to help moving this
topic forward?
