From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/5] branch: introduce --list option
Date: Fri, 09 Sep 2011 09:02:34 -0700
Message-ID: <7vlitxvh45.fsf@alter.siamese.dyndns.org>
References: <20110825175301.GC519@sigill.intra.peff.net>
 <0785cac235c3b45537cf161c86dde8e798c4ff3e.1314367414.git.git@drmicha.warpmail.net> <7vfwkodq5s.fsf@alter.siamese.dyndns.org> <4E5A5290.4050005@drmicha.warpmail.net> <20110907195611.GD13364@sigill.intra.peff.net> <4E6889DF.7030404@drmicha.warpmail.net> <7vr53qwxtz.fsf@alter.siamese.dyndns.org> <7vmxeewx7f.fsf@alter.siamese.dyndns.org> <4E69B832.9030503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 09 18:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R23XO-0005RS-0p
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 18:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759331Ab1IIQCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 12:02:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758453Ab1IIQCg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 12:02:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 359B445D9;
	Fri,  9 Sep 2011 12:02:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8+BrdMoCySbRt6u/EtM1EVNgvJk=; b=RivoXj
	mYpIq5KrdJDcIlVj5zd6Ya+uK8OcPdWyvoPct/tOHJjor4ORgbVMkEKKF63C+soq
	XLGgmiZ8/wKuKEYaAVP7Rb+NGPVwWXvogeEvAPCUOB6pXquGXH0B3Tf7NRnRKc1U
	8GyNLYcQgPGiJ4AgD7leXEw+po055VAVwF1Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c7Jsiugfpn0N2NK+t17ttE6e+GXxnrux
	R+58XYMw5YLqx0hFSN9MJuAjGW+7gEPQ6QwHNNfZReBIRwZlm5VMjeyTbApknvyw
	vbmn1HnKhR74tTJHETXl06qwF/SDN57DaqZUN0NLlK1+WlmThi240bk3vtmynYkZ
	tbjRj7rYIEY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DEB945D7;
	Fri,  9 Sep 2011 12:02:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97A7545D6; Fri,  9 Sep 2011
 12:02:35 -0400 (EDT)
In-Reply-To: <4E69B832.9030503@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 09 Sep 2011 08:54:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2230D0A4-DAFD-11E0-A7F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181086>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 08.09.2011 23:17:
>> Ah, nevermind.
>> 
>> As the series is already in 'next', here is what I came up with.
>
> I thought you'll rebuild next anyways after 1.7.7, but either way it's
> fine. Thanks for holding this series in next long enough to really cook
> it (and Jeff for revisiting it), it's much better now, keeping the
> (undocumented, but expected) behavior of "git branch -v foo".

Thank *you* for all the work.

I recall Peff had some comments on your new tests last night, by the way.
