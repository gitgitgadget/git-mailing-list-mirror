From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 11:31:59 -0800
Message-ID: <7v7htexuxc.fsf@alter.siamese.dyndns.org>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
 <32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com>
 <20091125080812.6117@nanako3.lavabit.com>
 <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDNbB-00037V-ON
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 20:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759540AbZKYTcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 14:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759528AbZKYTcI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 14:32:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759493AbZKYTcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 14:32:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7473EA1139;
	Wed, 25 Nov 2009 14:32:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yRrPDSLJWLHh/OT12zIVxhNFBZk=; b=yI2ZJc
	zFgqZKn40I/89DSPfo3H1jse8SDFQmKsnjiXVMUc+Jvaz8R4xAO+nPNVD95o125F
	aSPf940PzoaDAIsGPIHNVoEflEwjxW1eM/9TVV6XZ8ozj3FgSt7yYSMuw5Q/BTuQ
	LpwnZWvhqdtPXykczdrx5GeRSgXq0MnQR1y8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=orgZpVaUCDaQ/vT3tz55I9QsmyESqur+
	Qm5Ps3sALRXI9GDRFEBDjtW8wMeh0EzgaS6/CpVr/0Es8M3HHpJM1dh8Nva3tOPv
	HQ3mgcJfilbZ5Ry0WrbbquPt0Lhk3NYtF47Na2boyqm7zFUUk4QMy3pFu4VAQdyw
	1NuZF97nbD8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35E29A1138;
	Wed, 25 Nov 2009 14:32:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7DF57A1136; Wed, 25 Nov 2009
 14:32:01 -0500 (EST)
In-Reply-To: <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com>
 (Avery Pennarun's message of "Wed\, 25 Nov 2009 13\:28\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37AB9696-D9F9-11DE-8253-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133660>

Avery Pennarun <apenwarr@gmail.com> writes:

>> Probably you can save time by using what was already done
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=89021
>
> Hi Nanako,
>
> I've read through the thread (I do remember skimming it awhile ago)
> but can't find patches for the syntax actually under discussion.

I very much prefer gmane threading when following discussion over all the
other mail archives, but this shows one thing I really dislike about it.

It is not easy to find a near-by thread when looking at an old article,
and you have to be willing to bisect the page number at the right hand
side of the web UI.  Often a patch series is posted as a separate thread
after a discussion reaches conclusion or identifies an issue to solve, and
the real patch series lives in a near-by thread.  Very inconvenient.

I don't know how Nana digs up older discussion; maybe she knows better
ways.

In my primary repository, I have an archive of mothballed branches kept
with this alias:

    [alias]
    hold = "!sh -c 'git update-ref refs/hold/$1 refs/heads/$1 && git branch -D $1' -"

and found this series in there.  It applies to v1.6.0-rc0~245 (no, I won't
be rebasing this myself---I don't have time for that while preparing for
the pre-release feature freeze).

    f7713ce Document that merge strategies can now take their own options
    7eda236 Make "subtree" part more orthogonal to the rest of merge-recursive.
    e416d61 Teach git-pull to pass -X<option> to git-merge
    09f7d22 Teach git-merge to pass -X<option> to the backend strategy module
    904288c git-merge-recursive-{ours,theirs}
    e0aafb4 git-merge-file --ours, --theirs
    -d3e977b Merge branch 'maint'

Look at http://github.com/gitster/git/commits/jc/merge-theirs/
