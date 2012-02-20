From: Chris Leong <walkraft@gmail.com>
Subject: Re: [PATCH 0/5] diff --ignore-case
Date: Tue, 21 Feb 2012 09:10:37 +1100
Message-ID: <CAJ6vYjfrRxh9A6Tvp=9y87WkjGapj4vQE-6++bSgC+rT5sDBJg@mail.gmail.com>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
 <4F420749.9010206@kdbg.org> <7v8vjxnayn.fsf@alter.siamese.dyndns.org>
 <871upp4n15.fsf@thomas.inf.ethz.ch> <7vvcn1l21d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:11:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbRn-00027U-En
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2BTWK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:10:59 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38275 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab2BTWK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:10:58 -0500
Received: by bkcjm19 with SMTP id jm19so4889049bkc.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 14:10:57 -0800 (PST)
Received-SPF: pass (google.com: domain of walkraft@gmail.com designates 10.204.154.211 as permitted sender) client-ip=10.204.154.211;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of walkraft@gmail.com designates 10.204.154.211 as permitted sender) smtp.mail=walkraft@gmail.com; dkim=pass header.i=walkraft@gmail.com
Received: from mr.google.com ([10.204.154.211])
        by 10.204.154.211 with SMTP id p19mr12407141bkw.130.1329775857323 (num_hops = 1);
        Mon, 20 Feb 2012 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kiSdaL7Iho5nu0Hgqb9Nukvre78lKIJ25ZSfvOXTiMU=;
        b=HVO0bpkMSmdrRumzxh54v2CztXoSm0beP84YkygxLRLYDAxjeb/FkaWlRrUphJto0h
         q33E/v6fluFwabUYyhgaEkvrLwlxWV8sFSchecmElJhNpKKluo7ZGu6IjbvtmzewpZUP
         O93cVV6JMuiRj8y/dfya8R+slBpTQS5xQ+wK8=
Received: by 10.204.154.211 with SMTP id p19mr10003201bkw.130.1329775857251;
 Mon, 20 Feb 2012 14:10:57 -0800 (PST)
Received: by 10.205.34.200 with HTTP; Mon, 20 Feb 2012 14:10:37 -0800 (PST)
In-Reply-To: <7vvcn1l21d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191120>

It was about not worrying about the exact case of matches.

On Tue, Feb 21, 2012 at 6:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Want to try and see how well it works?
>
