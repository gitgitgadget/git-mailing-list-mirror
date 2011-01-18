From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/fast-import: put explanation of M 040000
 <dataref> "" in context
Date: Tue, 18 Jan 2011 13:43:22 -0800
Message-ID: <7vk4i1khvp.fsf@alter.siamese.dyndns.org>
References: <AANLkTinsnMRyoeGzCn1Rkk7tc+zwVa5j3AGqVZCdDGDv@mail.gmail.com>
 <1286681415-1831-1-git-send-email-david.barr@cordelta.com>
 <20110116022234.GA28452@burratino> <7v1v4amex6.fsf@alter.siamese.dyndns.org>
 <20110118211654.GA22763@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Gabriel Filion <lelutin@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 22:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfJLD-0003vJ-Im
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 22:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab1ARVno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 16:43:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab1ARVnn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 16:43:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DDA3236F;
	Tue, 18 Jan 2011 16:44:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pemr/WKNR9SbEikP2E+Dy2Hjun8=; b=p+wJvP
	F85/x6hwlOlo+26Zbkm/gc6ZT9X7nqW6HHIE58BTVFJ8LhNXf9quzetjPM8/CJSJ
	aBHHGwnjdp0+kFyY8k2CkDl+KvRZeb061tRPwIrXxcKezuIE6uKbh7DBxrJUDz4u
	T2GQUrxjNFgn0kgQm10OQ0TT/8X7CQqKjOO7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhrBm8KXmg/FAsB/Tpnmc6lSE6mW+PlP
	yN5AA0RCqAWSm79JMur/eJwQCt3auKcF9wr7w9xuOZuyqTT/sf1F50l5NAptUoyg
	xHprZFEtmqQ4KDHPXtWsgH4gQlAmR5v/Ilz3a4eyhh3D2iOOcVaU1JAL8laRtdPt
	ivxPbhf+AQ0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95C57236E;
	Tue, 18 Jan 2011 16:44:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB44D236D; Tue, 18 Jan 2011
 16:44:09 -0500 (EST)
In-Reply-To: <20110118211654.GA22763@burratino> (Jonathan Nieder's message of
 "Tue\, 18 Jan 2011 15\:16\:54 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B6CF108-234C-11E0-A5BD-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165226>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 43d2174..7068de3 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -542,7 +542,7 @@ The value of `<path>` must be in canonical form. That is it must not:
>  * contain the special component `.` or `..` (e.g. `foo/./bar` and
>    `foo/../bar` are invalid).
>  
> -In `040000` mode, `<path>` can be the empty string (`""`)
> +If `<mode>` is `040000`, `<path>` can be the empty string (`""`)
>  to specify the root of the tree.

For whom is this paragraph written?  People who produce g-f-i streams, or
people who interpret somebody else's g-f-i streams?

I am wondering if it is easier to read if we consistently target the
former, something like this:

        The root of the tree can be represented by `<mode> 040000` with an
        empty string as `<path>`.

because all the surrounding description seems to describe rules
(e.g. "quoting should be used", "The value of `<path>` must be ...").
