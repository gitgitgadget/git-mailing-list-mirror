From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH v3 0/5] push: update remote tags only with force
Date: Tue, 13 Nov 2012 18:58:28 -0500
Message-ID: <CAM9Z-nmy+4yvTXLoaO5mkyMC0sv3Vv8x6s2O6WgVdN+ev-W2Aw@mail.gmail.com>
References: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYQNP-0007v5-W3
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 00:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab2KMX6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 18:58:30 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37601 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab2KMX63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 18:58:29 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so812640bkw.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=niULlymyikezXgirL3hU/CFkZxX5qFOq9Z8PYhY/SCw=;
        b=WgiAcowi8V+q/16R2zCaLJIndkMmXDrLjLOtK6FbY3gE9FFekeTJYMVLRKGsNGoQ99
         TVsWxJ8chyrb4+zhdKYwMrItvop3tH6L5l3GITAkKs4/EJwuC7EVsr8E6e8MYjEmSo39
         mxXYF+ObJtcinsaIK/DGvW+ppLYVJjVbit3f/0DLcsUvynDORMWQ9mAb2yrVqVxaGcsK
         RtoDknZs5fE40uOWLxtunzkeeeaxXQXHB+dpRD+Uqos/WYmKCyx0mhxYIfbVqmkVqVa7
         uk+dR5eQ12Pj9ScqtzqiLO4aJaHm35No8fnDOUpeRIe+jyURtEhv0TPtaglue64qm9Vs
         aJSg==
Received: by 10.204.13.28 with SMTP id z28mr771209bkz.113.1352851108363; Tue,
 13 Nov 2012 15:58:28 -0800 (PST)
Received: by 10.205.122.144 with HTTP; Tue, 13 Nov 2012 15:58:28 -0800 (PST)
In-Reply-To: <1352693288-7396-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209688>

On Sun, Nov 11, 2012 at 11:08 PM, Chris Rorvick <chris@rorvick.com> wrote:
> Minor changes since from v2 set.
.....

>      An email thread initiated by Angelo Borsotti did not come to a
>      consensus on how push should behave with regard to tag references.

Minor Nit: Without the link to gmane it is an exercise left to the
reviewer to find that you're talking about this thread:
http://thread.gmane.org/gmane.comp.version-control.git/208354

Cheers.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
