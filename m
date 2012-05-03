From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 14:09:41 -0700
Message-ID: <7vipgddl9m.fsf@alter.siamese.dyndns.org>
References: <4F9F128C.5020304@palm.com>
 <201204302331.q3UNVo7o032303@no.baka.org> <4F9F3919.6060805@palm.com>
 <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com>
 <20120501111415.GD5769@thunk.org>
 <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com>
 <4FA02830.3040407@palm.com> <86havzoi8h.fsf@red.stonehenge.com>
 <4FA04D02.6090702@palm.com> <86mx5rmx32.fsf@red.stonehenge.com>
 <7v62cf8v2d.fsf@alter.siamese.dyndns.org> <4FA054BA.80601@palm.com>
 <86ipgfmw05.fsf@red.stonehenge.com> <4FA05C66.2060608@palm.com>
 <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rich Pixley <rich.pixley@palm.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 03 23:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ3HZ-0005iA-5n
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 23:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758603Ab2ECVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 17:09:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754928Ab2ECVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 17:09:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 25BDD7913;
	Thu,  3 May 2012 17:09:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VicBMZ9+Ew3SmPIOUj2ptNL8IgI=; b=QHP92Z
	oo7XdvMcTjk2bkNQOxpTVgCkR9DN+Mp3Fc5KVP8zq5ftBiwOFwQ3/qwafAIM9j97
	bTVq5aqzOW80fiPtb5H8LuMnvPoSEJNNq2xjXjNCqBy7vw6L72JN0WYL97cLeonM
	Gn93gpnHotdnaXW03VBtixosx+vicLJHdnVDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P0K3nKHVKNOI25oll/hsDVKFuAUltmLI
	XMSYIwyGr6q9HIweyPy9HkBW4+13RDTJ3ba7abNXtniGBMhhJdMsClR2bza2lLzR
	UCUOHb9nJu8P7RtCUSfIsPbQpClTvzn+4ooZ5Uyp7/UIX4iddUKMD3RDitMddPW9
	Q/d4sNGgC4U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C8187912;
	Thu,  3 May 2012 17:09:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99DEC7911; Thu,  3 May 2012
 17:09:42 -0400 (EDT)
In-Reply-To: <CAMOZ1BuiznhrzEOHe0N+uu=mLEw5wWTQyDpnwG8PuF1f_aNaXw@mail.gmail.com> (Michael
 Witten's message of "Tue, 1 May 2012 22:56:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D777340-9564-11E1-A8BB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196959>

Michael Witten <mfwitten@gmail.com> writes:

> (Note, though, that Junio has done a laudable job of keeping the
> whole experiment going strong).

You are giving me too much credit, and at the same time insulting the
people who polished Git enough to suit their workflow.  To them, the tool
has past "experiment" stage long time ago.  They found what was lacking
and what would help the need in their workflow.  I just have helped them
shape their ideas into a coherent whole.

That does not mean there is nothing missing, still appears experimental,
or inconsistent in the parts of the system that these people do not use
nor care about, and when you bring in people coming from different
background, they will notice the behaviour or default that do not match
their expectation.  They can do the usual "scratching own itches" thing
the same way to others who have done before. As nobody forces them to do
so, they can instead keep whining.  It's mostly their choice.
