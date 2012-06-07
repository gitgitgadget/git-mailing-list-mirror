From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2012, #02; Wed, 6)
Date: Wed, 06 Jun 2012 22:25:22 -0700
Message-ID: <7vtxynk81p.fsf@alter.siamese.dyndns.org>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScVDu-0007wj-KT
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 07:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab2FGFZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 01:25:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab2FGFZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 01:25:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FF1B9BCC;
	Thu,  7 Jun 2012 01:25:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SoV4GnvRdp0Ionaa1c7BLhMBmHE=; b=aPLGqw
	TKtNBf4pb2jkWQIg0iV1MPbjGFLEEFITpYHwoaUc9MoAnoiAQ6nJoz2hZ5xcjoZ9
	YMYMEt3I5vVQPU+Z63ZFbGc2PTTn9f3gT080DqMsY0z1jkiBOOCHXbEbFquA4d8B
	91zoYJo3+NCW3/gGj/VVLyKv9OL5wyO0MAok4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8G0kTjjy+6CwDv1nTdt0y8CK7BUSRis
	33uynpsUQfBYXp4ucAVySLrYVuSblg4WRjwaGS0kA3+msOu3LXr+kn8oUoge/3Mc
	H0AT0tMIelFNZeHyCmz2RRwZRN3gAigkWFgLD/h5Jk2q3uFhlOIgYtSgXjU+/AdU
	AmHMZPGZoZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370829BCB;
	Thu,  7 Jun 2012 01:25:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4E8C9BCA; Thu,  7 Jun 2012
 01:25:23 -0400 (EDT)
In-Reply-To: <20120607003904.GB4065@burratino> (Jonathan Nieder's message of
 "Wed, 6 Jun 2012 19:39:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E9CF2DE-B061-11E1-BE38-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199370>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> At the end of this series, vcs-svn is static-analyzer clean when
>> merged into svn-dump-fast-export.
>
> Thanks for the cc.  I generally like the code and generally dislike
> the descriptions which amount to "appease the static analyzer" and
> don't reflect the thought you actually put into the patches, which
> sets a bad precedent.  I was planning to munge the descriptions, ask
> you to look it over, and then ask Junio to pull.

That sounds like a good way to go, then.

Thanks.
