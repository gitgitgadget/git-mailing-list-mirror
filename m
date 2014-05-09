From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 01/17] contrib: remove outdated README
Date: Fri, 09 May 2014 16:54:03 -0500
Message-ID: <536d4e7ba8ea_585ea5308a9@nysa.notmuch>
References: <1399662703-355-1-git-send-email-felipe.contreras@gmail.com>
 <1399662703-355-2-git-send-email-felipe.contreras@gmail.com>
 <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 23:54:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiskA-0002TB-Eq
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 23:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbaEIVyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 17:54:09 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:54339 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452AbaEIVyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 17:54:08 -0400
Received: by mail-yh0-f44.google.com with SMTP id b6so4324817yha.17
        for <git@vger.kernel.org>; Fri, 09 May 2014 14:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qhIquYuNtyqlSGwTUSQJtct0THHdxw9jUmUoPWlbxMY=;
        b=q4hQYD7QPNjF14EbphQ+niY/+Hn68GKytvAS3g3t0n+uLR+v+bGSguIIeYTjlKIEn3
         DtF7C52BqpdroG/Wo9sSY2sGyjXJbrDxcaKAwurILYM3QHBbuPJ0d5vwETOWyHUpcL/L
         b2LqU8XzRDy3FEFrPdGkEQ/rmsioU0BNi6XEl4wMuvxNJhhe1Fdki6v10yUbXx4R/2M0
         ktuffYVh/7a4A/tInWftPQIHav2/FzxvjIMX2iHecpmZyuS97SU9Xydm3cBjuhCo9TC/
         tdHfDZw3a0hfVEzveKyJ/wZotl6RBJOqXuKnXn4awtwEBzynpGEtEDJaCsCTgmIEFfcn
         FtOQ==
X-Received: by 10.236.86.226 with SMTP id w62mr19274874yhe.94.1399672447814;
        Fri, 09 May 2014 14:54:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s26sm8011933yhg.4.2014.05.09.14.54.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 14:54:06 -0700 (PDT)
In-Reply-To: <xmqqbnv6yb9l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248646>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > There is no guideline as for what should be part of contrib.
> >
> > Some tools are actively maintained, others consist of a single commit.
> > Some tools have active user-base, some aren't used by anyone. Some tools
> > are on the path towards the core, others will never get there. Some
> > tools are already out-of-tree and simply mirrored, others probably
> > wouldn't survive out-of-tree. Some tools are production-ready, others
> > don't even run. Some tools have tests, most don't.
> >
> > Junio has explained that he wrote this a long time ago, when Git was a
> > different beast, now this no longer applies.
> >
> > The only way to find out if a tool belongs in contrib or not is to as
> > Junio.
> >
> > Cc: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> 
> This is wrong.
> 
> The reason I suggested splitting remote-hg out of my tree does not

This particular patch has nothing to do with remote-hg.

> have anything to do with "removal of disused and inactive" described
> in the document.  As written elsewhere, it was a response to
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248457
> 
> where you said
> 
>     I don't want to do anything for a "contrib" tool.

You are once more twisting the sequence of events.

*First* you blocked any progres towards graduation 2014-05-06, even
though I told you what John Keeping argued wasn't going to happen.

  http://thread.gmane.org/gmane.comp.version-control.git/247660/focus=248242

*After* that I decided not touch git-remote-hg/bzr on your tree any more
2014-05-08.

  http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248457

Do not attempt to construe the consequence as the cause. You caused it.

-- 
Felipe Contreras
