From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 05 May 2014 19:39:46 -0500
Message-ID: <53682f52da35b_287c15bd30cc8@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <53682ae027b7d_24f8d2930881@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 20:21:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiFx-0007Xo-9S
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933390AbaEFAuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 20:50:32 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:57248 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013AbaEFAub (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 20:50:31 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so6686816oag.26
        for <git@vger.kernel.org>; Mon, 05 May 2014 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+N3BV1E1MbRxWnXI1EL+vtlu8VHWTfmDMJq368OwXFE=;
        b=JhSdCXFopaUr5CbGiA+2hPAe/cU5syWtsVZPOYNHzoN0TLBNnuqefP9fYL9Vve3ZEi
         bsPDTjb8ttFEraD6TwUeOO6b4R15Pk081yM/TKrIpsXViyolV8k0SPJyXsUkIoSaguNB
         v7MuJPVUfNsWV2CDpc07hYfN+KTe/1JTK7/xGEy/KL7WWnDowM9nz3DNG34mCsj6M2qR
         Ctx4ExwBalmL9Uh4t2CB9beV4hgv8TgxeUXY06H6dC+4kjvmDZTGJNmEjkYf/8m5aUek
         oqYc7X5VEJB+INev+fYpobtdLE7lETAdgeo5rg/jalB1gkVyknPN2VB4k2a2gj1oJyj8
         mF1Q==
X-Received: by 10.182.40.201 with SMTP id z9mr34637691obk.45.1399337431437;
        Mon, 05 May 2014 17:50:31 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm44755467oej.5.2014.05.05.17.50.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 17:50:29 -0700 (PDT)
In-Reply-To: <53682ae027b7d_24f8d2930881@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248205>

Felipe Contreras wrote:
> Having said that alignment issues do happen, and we have one of those
> in Git v2.0, but I don't think they are a major concern (at least for
> remote-hg/bzr).

Actually I just noticed that the remote-helpers side is not in the
"master" branch.

I don't know what is your plan with fc/remote-helpers-hg-bzr-graduation,
but for v2.0 we really want the patch 'remote-{hg,bzr}: store marks only
on success'. Explaining precisely why would take a lot of effort, but
basically it's related to 3994e64 (transport-helper: fix sync issue on
crashes).

If you are worried about merging the whole branch, I could pick only the
important patches and reroll.

-- 
Felipe Contreras
