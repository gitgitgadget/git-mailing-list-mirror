From: "Matt McClure" <mlm@aya.yale.edu>
Subject: Re: tests for git-p4
Date: Sun, 13 Jul 2008 14:40:38 -0400
Message-ID: <e48c5e540807131140k754dbb88k36dd8fb463e6fc6b@mail.gmail.com>
References: <e48c5e540807120524rabdcfa6vd91c16ef1b0f80a0@mail.gmail.com>
	 <200807131426.09688.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Hausmann" <simon@lst.de>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI6Vw-0001pz-Gb
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 20:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbYGMSkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 14:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYGMSkl
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 14:40:41 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:17439 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310AbYGMSkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 14:40:40 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2565321fkq.5
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=uaKJl5KGLuoYfk2ZhHgqQcyElW8lsvbEsmiF/Aei8FE=;
        b=PJKUJVpGnWunT+PbuPfKDBhNwPPUDJh51biBO2/7/ZNM4zUWxqwTCfIiDWTl9641fV
         UjzUyAFJbn+Y172puA7bQWnrCCEpMqD5yUGThCZumNU8H6mzCrfzWDnxg0Ajl3Uzgbjw
         viVVMh/6XenGbn6fNZCNM902h+3TAQniF8EjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=sdausRZ2jRZQKar7Fa6MNJv8KVMFy9XnTMJMcNWKEPvn0jaT74osfGha6Wur49doPN
         cyjln5KRVYu1Njb3hogFQ2Os8ZeXMkakWUWoiYGXB2f0WBz3lH9zGDj4FHwDVnkd9XRs
         bbi/mp6NptAVWifs2UK7Yi6u3ZdEcrqkEMwN0=
Received: by 10.86.91.12 with SMTP id o12mr13154328fgb.1.1215974439022;
        Sun, 13 Jul 2008 11:40:39 -0700 (PDT)
Received: by 10.86.2.12 with HTTP; Sun, 13 Jul 2008 11:40:38 -0700 (PDT)
In-Reply-To: <200807131426.09688.simon@lst.de>
Content-Disposition: inline
X-Google-Sender-Auth: 6797540385b351c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88322>

On Sun, Jul 13, 2008 at 8:26 AM, Simon Hausmann <simon@lst.de> wrote:
> On Saturday 12 July 2008 14:24:10 Matt McClure wrote:
> There are currently no automated tests for git-p4. I would certainly be
> interested, but I forsee difficulties testing the interaction with p4 in a
> general way independent from a specific server setup.

I can solve that by bootstrapping a p4d server for the tests that need
to exercise p4 directly.  At higher levels of abstraction, if they
evolve, I could replace p4 with a test double that doesn't need a
Perforce server.

Matt
