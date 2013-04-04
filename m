From: Jed Brown <jed@59A2.org>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 04 Apr 2013 13:17:01 -0500
Message-ID: <87y5cyqhya.fsf@59A2.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com> <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 04 20:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNojM-00059Z-Tr
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764394Ab3DDSRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:17:05 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:60675 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764369Ab3DDSRD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:17:03 -0400
Received: by mail-oa0-f43.google.com with SMTP id l10so3123796oag.30
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=pQ0hICs0vaeQ15VedVDSb8oZUP+hUxjN6R1hu4qXuHU=;
        b=OVO5b2fdRl9teuxu9stCrZ5l3atpJFyFIjvR5e0MtlZNJPiKNIuceyoXqUNJfIn/Q7
         aAoXWAq0tTO+lg9GJucwaem3jSRbUPd3S/JBFh7gbv8XgrXiKs7DXBiQ66YMu9IWUMon
         dhxRjLZKALtPuqQw7yGsGyEo6+JNfE02mBvC82aeXqEUgpkMo6t4nBV6SfUQx2KlrA8B
         oDiFIykpyh+zUypGktL3zZFoOPt4JuEhKgxCN6pgw/PVYcCfElM0Ikki24K1Gvt0YiMB
         TkCLVkBTMsZ4hN0O53j3z/IcbBFNGS9t4/o8r9TfHJmXYwx2/Mv7E1rhLglWLdQadmwQ
         nT8w==
X-Received: by 10.60.98.209 with SMTP id ek17mr5095512oeb.132.1365099422984;
        Thu, 04 Apr 2013 11:17:02 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id v8sm8018274oea.4.2013.04.04.11.17.01
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:17:02 -0700 (PDT)
In-Reply-To: <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220045>

Felipe Contreras <felipe.contreras@gmail.com> writes:
> Ideally we shouldn't do this, as it's not recommended in mercurial
> documentation, but there's no other way to push multiple bookmarks (on
> the same branch), which would be the behavior most similar to git.

The problem is that you're interacting with a Mercurial upstream, not a
Git upstream.  When you're in their playground, you have to play by
their rules.  Creating new heads is disruptive and not likely to be
appreciated.
