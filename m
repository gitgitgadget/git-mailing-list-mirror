From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] contrib/subtree bugfix: Can't `add` annotated tag
Date: Mon, 12 May 2014 07:29:47 +0000
Message-ID: <20140512072947.GA18519@debian>
References: <1399511079-1994-1-git-send-email-nod.helm@gmail.com>
 <xmqqoaz841d3.fsf@gitster.dls.corp.google.com>
 <CAHYYfeFfo=xVDezAGFyCvuhx=bkzMF6KyDCAjZNKNoGnytXDWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kevin Cagle <kcagle@micron.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 09:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjkgP-0006Md-Fw
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 09:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbaELH3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 03:29:53 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:54022 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbaELH3x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 03:29:53 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so6486863wgg.12
        for <git@vger.kernel.org>; Mon, 12 May 2014 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=orQmDgGEJL2e77OQdMiZzkxwUB1giECgVc4c7ilyUag=;
        b=uqtGOuNaMToKmZaxjV+AX5boRRFp0c+eYPo6fpb+HPLL4UYjuCiAqMy93gxR9BSofy
         c2VVgfGMd4hjrflLxMss4XOVtPQSuEV1gfUW5Dcft23ip1zjx+v0UUXcUmuJrd+PHyq5
         xoFPI0Nol7mT6n5ZDpzZoOcca3+pUoDHNhr/eYn8o8ngIal310YUOVJd5ibLJFTJoUbC
         DqirMjlg3sW4OzkAmsIO3aEh5NYhRNEw+q3dbmLt2BCAjAOurwIzW7KUu+T3IYwJR0f3
         4RKnuYguLCtezG5c//HtOonmPMUJa4Tnj9OXPwRbG4vOUyvXasV7of1mvoKXd5nRW9bR
         28pQ==
X-Received: by 10.180.98.232 with SMTP id el8mr14210903wib.27.1399879791735;
        Mon, 12 May 2014 00:29:51 -0700 (PDT)
Received: from debian ([2a04:1980:3100:1aac:21b:21ff:feda:4cbe])
        by mx.google.com with ESMTPSA id gr2sm16760742wjc.12.2014.05.12.00.29.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 May 2014 00:29:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHYYfeFfo=xVDezAGFyCvuhx=bkzMF6KyDCAjZNKNoGnytXDWA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248690>

On Fri, May 09, 2014 at 05:36:15PM +1000, James Denholm wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > Would it be sufficient to do
> >
> >         git commit-tree $tree $headp -p "$rev^0"
> >
> > in that "not squashing" codepath instead?
> 
> On line 561, sure. Do you want me to do a re-roll?

Sorry to bump, but do you want a reroll on this?

---
Regards,
James Denholm.
