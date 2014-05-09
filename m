From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: What's cooking in git.git (May 2014, #02; Fri, 9)
Date: Fri, 09 May 2014 16:42:44 -0500
Message-ID: <536d4bd48e3f9_585ea5308b2@nysa.notmuch>
References: <xmqq61lewtkf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 23:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WisZC-00025o-T2
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 23:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600AbaEIVmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 17:42:51 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:58021 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757368AbaEIVmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 17:42:50 -0400
Received: by mail-yk0-f172.google.com with SMTP id 79so3997480ykr.31
        for <git@vger.kernel.org>; Fri, 09 May 2014 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=cLYwLCWwwjmw0FBrlPQS7OvycvUpNl/q4WG8oH20llM=;
        b=WpgANRy9D/Lrr+WmEpF4jmCYWZwdXX0JWPTR2pA3cGPXfwhp3xZWhnD7Ed3L9o+ZOZ
         Cz3v4BdmGaL1hglEDyOACv579M44FAapJXmVAmzgJb1spDi7fSyEFjf4AA57w446m2Ws
         lJzHGpfW3VeztzjYYkOWOL7IzMfOPog4tdoRdqLSTCtJWkDSQT7sHDIg7GlrXwqvj7kZ
         YRViyof8VZ+ZEu1HRFCHTKxX9PoOJypmVDedrqsfNrp9rVzJeKBdYKr4N1jnNbSruCJD
         mFutbx4uvsqh/iQ4wD/ufcXgWnXc65xURzfnSTxynbRuluTvdk6taX6jwB6dvIuQJ0gj
         ciWQ==
X-Received: by 10.236.114.2 with SMTP id b2mr18602923yhh.92.1399671769671;
        Fri, 09 May 2014 14:42:49 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j76sm7957703yhi.33.2014.05.09.14.42.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 14:42:48 -0700 (PDT)
In-Reply-To: <xmqq61lewtkf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248643>

Junio C Hamano wrote:
> * fc/remote-helpers-hg-bzr-graduation (2014-04-29) 11 commits
>  - remote-hg: trivial cleanups
>  - remote-hg: make sure we omit multiple heads
>  - git-remote-hg: use internal clone's hgrc
>  - t: remote-hg: split into setup test
>  - remote-hg: properly detect missing contexts
>  - remote-{hg,bzr}: store marks only on success
>  - remote-hg: update to 'public' phase when pushing
>  - remote-hg: fix parsing of custom committer
>   (merged to 'next' on 2014-04-22 at fed170a)
>  + remote-helpers: move tests out of contrib
>  + remote-helpers: move out of contrib
>  + remote-helpers: squelch python import exceptions
> 
>  As there were announcements for these two to be maintained as
>  independent third-party projects ($gmane/248561, $gmane/248583),

Clarification: after Junio unlilaterally blocked any further progress
towards grauduation to the core, which was the intention since the very
beginning.

-- 
Felipe Contreras
