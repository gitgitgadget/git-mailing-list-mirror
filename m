From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How do gmail users try out patches from this list?
Date: Wed, 12 Aug 2009 14:51:46 +0200
Message-ID: <81b0412b0908120551x43c9c429k3dad24616acf7de@mail.gmail.com>
References: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Aug 12 14:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbDJ8-0006v8-Ot
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 14:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZHLMvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 08:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbZHLMvq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 08:51:46 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:43233 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZHLMvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 08:51:46 -0400
Received: by fxm28 with SMTP id 28so2098777fxm.17
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0m6gFcznOWkG+sbwAgnG/seZhq3u41jZKF3nPbVnM2c=;
        b=rF6Qy4kusftteb1qjZvGa/LNLMW9whC36EO4kySpGG4/ekMyI1IGZuDm5JfFq92vgw
         b3YnvNx7Wm4Q55UG9QhKRnrm+VTOj0va2qxpP5LRv6rf9+CNK0GliFQyjp+fM+x8nokK
         WO+I5mhzUFHEppJVUUG4wt+Ct3g1KjixNbeRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L/2cqSS8ZDUlAQ8mzwyb2qPgr4u5JfZ5209gbO82lyOQ5CcFiPMVCMFexRDvUXJ8Dy
         LOLnV1cGGjOrG50ckXK1hBi4Jtly+ucQ4pPfHVTFuYNVZfU4TCHhrOJfh7ZFejVcInJz
         BHiWgSU4Jgj/S4vwj4A6WZRRQgbBFDWoYlMY4=
Received: by 10.204.57.19 with SMTP id a19mr34195bkh.194.1250081506299; Wed, 
	12 Aug 2009 05:51:46 -0700 (PDT)
In-Reply-To: <2729632a0908111343v73fa475fqb6353dcf2f718101@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125695>

On Tue, Aug 11, 2009 at 22:43, <skillzero@gmail.com> wrote:
> Sorry if this is dumb question, but I didn't see any good info in my searches.
>
> How do gmail users normally apply patches that come through the list?
> Do you just manually copy and paste the email to patch files and use
> git apply? Do you use a tool to export to mbox files and use git am?
>
> I've been just doing it manually via copy and paste, but it's kinda tedious.

"Show original", save the page into a file (it's text/plain), remove
the first line
of spaces, and do "git am" on the file. Works every time.
