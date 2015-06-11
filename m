From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Thu, 11 Jun 2015 11:23:04 -0700
Message-ID: <xmqqoakmf6k7.fsf@gitster.dls.corp.google.com>
References: <5575F948.4060400@web.de>
	<xmqqioavob7n.fsf@gitster.dls.corp.google.com> <55788190.80106@web.de>
	<xmqqegligv45.fsf@gitster.dls.corp.google.com>
	<loom.20150611T164935-263@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 20:23:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z378E-0001e6-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 20:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbbFKSXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 14:23:10 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:33187 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426AbbFKSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 14:23:08 -0400
Received: by ierx19 with SMTP id x19so4063090ier.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=56R9/XyxQfVvInpqRSOA70fUqvC8LQ0fmoFUybxv/f4=;
        b=vy3wPWAIs6fBQ2QAx8tA+71Z0Lk5gQtGwfB57WnVqr+O2RFDJGUbYUBdm8jE7ALi/s
         t7JegyMQbbKWF+vI3UlSHJYCChPfaQ2aIEuR8HwpNpWAY/S7ospI34U+zuRDPXJ47lrC
         izVpvxH14teonfK5Fv+1SAqZqiFs1aDZrCuvtxladGOpX/Ql+6nFCeod5VkcNHX9yRwM
         J7wtMwxI9pTrIkl8i5PDNBB9Odh+IgcZaXC08h+UqXTv9ioxjfviTxLZtjlTicBJIpcz
         uBV2Rv1EHyg2/9UhkGZ3wOJtmz7K+RNshbh8y2Le5JZVsXU+A65B4DglrE3OdCllVXc8
         7dnA==
X-Received: by 10.107.137.42 with SMTP id l42mr12809437iod.60.1434046986865;
        Thu, 11 Jun 2015 11:23:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id k81sm863981iod.31.2015.06.11.11.23.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 11:23:06 -0700 (PDT)
In-Reply-To: <loom.20150611T164935-263@post.gmane.org> (Ed Avis's message of
	"Thu, 11 Jun 2015 14:52:21 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271449>

Ed Avis <eda@waniasset.com> writes:

> I guess 'replace' would be a better word than 'restore' for the current
> behaviour.

Hmm, but wouldn't replace have the same issue as overwrite, namely,
'replace with what?'.
