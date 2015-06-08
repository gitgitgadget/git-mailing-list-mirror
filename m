From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] read_loose_refs(): treat NULL_SHA1 loose references as broken
Date: Mon, 08 Jun 2015 10:37:39 -0700
Message-ID: <xmqqpp56ayos.fsf@gitster.dls.corp.google.com>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
	<eb79f7d96ec74445f7adf62757119273280e09c9.1433339279.git.mhagger@alum.mit.edu>
	<20150603140803.GA23901@peff.net>
	<xmqqr3pswrpc.fsf@gitster.dls.corp.google.com>
	<20150603201511.GA31157@peff.net>
	<xmqqmw0gwktt.fsf@gitster.dls.corp.google.com>
	<55755FC9.7040507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:38:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20zk-0000yC-LB
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbbFHRhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:37:54 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34252 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbFHRhm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:37:42 -0400
Received: by iebmu5 with SMTP id mu5so67842501ieb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mobnzbAWF1BVsdD3+sBlSlPFpmypfOk426AwHiICkxs=;
        b=xkpVsLcmeq8RhSX/qKwdWs+pRyo2zwDjcrGjHP+2529psM6q2PtpChNdMnEML2oBaS
         iT+F+GR3HoDF1CMYhBgm1FwP6XrEhQpAxYp6DO9zApKnLbcUZq5SM9vsZvBCWAO/3NyU
         qOQqEW8WBdMDOQE+ICHCQ2yR3hlN1OFtObBGk6VoMz4RdFGQWzZyPrcEQltYbJvreGpm
         L+K+xKQReup5BOEYcXl+73U0MQUAzBGSIDg6H1k63QEJDfvndVnMkkPUi943/0/CDspo
         AOwZmbWWmShb1KBeMUb9bGrGLeRcl2D4LEzh1fFWi+0Dpit/2mOQu6tHwVO43rilKgXt
         d5+w==
X-Received: by 10.42.85.207 with SMTP id r15mr24760699icl.94.1433785061327;
        Mon, 08 Jun 2015 10:37:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id z22sm2157772ioi.3.2015.06.08.10.37.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 10:37:40 -0700 (PDT)
In-Reply-To: <55755FC9.7040507@alum.mit.edu> (Michael Haggerty's message of
	"Mon, 08 Jun 2015 11:26:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271094>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Thanks for all the comments. Taking them into consideration, I suggest
> changing the last commit message to
> ...
> Since the only comments were about this one commit message,...

Yeah, this round looked good otherwise.  Will amend in-place.

Thanks.
