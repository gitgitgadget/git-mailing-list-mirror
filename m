From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Documentation: explain push.default option a bit more
Date: Fri, 20 Apr 2012 14:28:28 -0700
Message-ID: <xmqq62cum6tf.fsf@junio.mtv.corp.google.com>
References: <vpqfwbye9re.fsf@bauges.imag.fr>
	<1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1334933944-13446-2-git-send-email-Matthieu.Moy@imag.fr>
	<20120420201357.GA13103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:28:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLLNd-0000jH-6p
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 23:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab2DTV2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 17:28:33 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:34806 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2DTV2b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 17:28:31 -0400
X-Greylist: delayed 7607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Apr 2012 17:28:31 EDT
Received: by lbol12 with SMTP id l12so293171lbo.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 14:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=ZGE7hN3nFoE/xmWzyLZ9GF1yQ7AlAcOMgMH1U4bo2A4=;
        b=Rks72sec7gQywUu6YQ3h/FiBaUPsZIsYlDbbR+wohmPL01FmStAo5CpSpSvdsD7gr4
         We6ElBxrW4X8+S8pXegTXkA1/tNUJVvOSo2RtbDDuZ4gOTeWsWUuNwO5SCFpO8/akTNf
         kAhZb5dY8bGbcvckRDdWzX1fjnr46huHYG1FKwug/IHoo4Srp6nCt9EMdPry06shJPdu
         usUq5BNJo8325yiMTIgDBv2zkcyhpoGDU4ufLk0ip44Vemm4NSEUa+kTYNDNgKUbl+GJ
         cTAHVtpgwLmB3ALl2xayIskh/wxVPyjsft8Y5Qcw3TZazlBoHz1XdPTLJ+UqRkyMsCaO
         Slag==
Received: by 10.14.199.133 with SMTP id x5mr2211235een.7.1334957310039;
        Fri, 20 Apr 2012 14:28:30 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr2211216een.7.1334957309938;
        Fri, 20 Apr 2012 14:28:29 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si6394752eef.2.2012.04.20.14.28.29
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 14:28:29 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id B9E275C00A6;
	Fri, 20 Apr 2012 14:28:29 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 1777EE120A; Fri, 20 Apr 2012 14:28:29 -0700 (PDT)
In-Reply-To: <20120420201357.GA13103@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Apr 2012 13:13:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQl85I4VsFXeAjXQZw/FcBMe7dyFHxAke0JBh43qp3CoUY29ov3hFGfvb0nMQba/TbK0zZeJlxiM95vC8qAJy1YdonflS4dcfmVYQcutVQqeDAKTzbGOCORV3WDabKbnES0d3dPBfhifybmSC14n0Nw5PwPgzqSPQYvz5fVs7r5CZ50qdkM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196026>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 20, 2012 at 04:59:01PM +0200, Matthieu Moy wrote:
>
>> The previous documentation was explaining _what_ the options were doing,
>> but were of little help explaining _why_ a user should set his default to
>> either of the options.
>
> I think your explanations are a definite improvement.

<aol>Me too</aol>

Except for this part.

>  * `current` - push the current branch to a branch of the same name.
> +  This option allows publishing a branch to a remote repository using
> +  the same naming convention locally and remotely, in a more
> +  conservative and safer way than `matching`.

I am not sure if "in a more conservative and safer way than `matching`"
is a good thing to say here.  It sounds as if you are saying "you push
only one, so even if it does what you did not intend to do, you inflict
damage to at most one branch" and without mentioning the downside of
"you push only one, so you need to checkout and push out all the
branches one by one that you care about".

The workflow 'current', 'upstream' and 'simple' are suitable for is
fundamentally different from what 'matching' aims to support.

The former three are for people who want: "I've completed this single
branch, the one I have had in my working tree and have been working on
for all this time. I'll push *that* single branch out. All the other
branches do not participate in this push".

The 'matching' is for people who want: "I've worked on the set of
branches I want to publish until they are _all_ ready.  And now they
are.  Publish all of them with a single connection, atomically, in one
go."

Your text that compares between 'current' and 'matching' does not make
it clear that point.  In a workflow for which 'current' is suitable,
'matching' is not even "a more aggressive and riskier" alternative.  The
text does not make the reader aware of that, and will invite "current is
a more cumbersome and tedious alternative if you want to push out all
than matching", which is a faulty conclusion coming from the same
confusion.

Perhaps make this part a separate paragraph so that it stands out a bit
more, like this,

    * `current` - push the current branch to a branch of the same name.
    +
    The `current` and `upstream` modes are for those who want to
    push out a single branch after finishing work, even when the other
    branches are not yet ready to be pushed out.

and update the description for `matching` to explain why it is suited
for what we claim that it is suited for, like so:

    * `matching` - push all branches having the same name in both ends.
      This is for those who prepare all the branches into a publishable
      shape and push them out atomically, and suitable when pushing to a
      non-shared repository. It is not appropriate to use when pushing into
      a repository shared by multiple users, since locally stalled branches
      will attempt a non-fast forward push if other users updated the branch
      remotely.
    +
    This is the default.
