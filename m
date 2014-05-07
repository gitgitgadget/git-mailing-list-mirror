From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 07 May 2014 14:50:20 -0500
Message-ID: <536a8e7cc2abc_76ff7a52ec74@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
 <20140507080558.GH23935@serenity.lan>
 <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
 <20140507192805.GA9035@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:01:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi81g-0000OQ-RX
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbaEGUBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:01:08 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaEGUBH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:01:07 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so1837432obc.5
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=IkPThuxyaF+09YR2ROYtOLkoC8I5DDK7vcWnKbrKnxc=;
        b=GRM5ThJxITD32ClzqXZZmfb6+ewWZboH5YKcXQRLV3GS+UZbouRuJYSCH8I88dGhZP
         EPISF1GV4uIZuoKtSQvzspqdowotZ2gzDkBkZfZGXZhHUG62ae32JsedJVu35CzK70jb
         dpM+q4L328d86H6Li8HON0jbE9T7rlw3/2uxvmAwQpMl3XS9acLHeWN8whQg3xiGpGDC
         EVzetWGzDPOuE7B7+ZZHFCfDPFCWBijsTYPJhDl2bvDBJtWlwNTX/wkasjmdMPCJo76A
         LI73NE1nIa0pOjq7iJyUYsHykeT/ddfCbRM5eTbfaV8sPMY9lldMo7HBDytEioUN566/
         3aUg==
X-Received: by 10.182.22.33 with SMTP id a1mr11935671obf.60.1399492867160;
        Wed, 07 May 2014 13:01:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm70002495oeb.3.2014.05.07.13.01.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 13:01:05 -0700 (PDT)
In-Reply-To: <20140507192805.GA9035@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248353>

John Keeping wrote:
> Having thought about it a bit more after reading Felipe's reply, it
> would be nice if there were some way for third-party tools to install
> HTML documentation without relying on `git --html-path` but I cannot
> see an obvious way to do that as there isn't a standard $HTML_PATH to
> match $MAN_PATH and $PATH.

Using `git --html-path` for that is wrong.

-- 
Felipe Contreras
