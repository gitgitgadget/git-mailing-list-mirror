From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Development strategy
Date: Tue, 3 Jun 2008 01:04:01 +0200
Message-ID: <bd6139dc0806021604w1a066229idb788a9b918ee24b@mail.gmail.com>
References: <48441715.4010507@gmail.com>
	 <bd6139dc0806021130p2cc442a3qfe9c00681fdb05e3@mail.gmail.com>
	 <484475FC.8020804@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"John Hawley" <warthog19@eaglescrag.net>
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 01:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3J67-0003DM-G7
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 01:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbYFBXEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 19:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbYFBXEF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 19:04:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:31809 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbYFBXEC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 19:04:02 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1017937wfd.4
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jcFqrQOT/65hMGIdp7Sg0p9Zlpwr4mb9d1bZD+n8ql8=;
        b=T41FKg/voQpIj12UgThARxkkfF5ue6/XSpkhd11OdrTcntZ92Kr7y/FTkJwmoVTZIp9IlYSLQ9DA9YM8geT0K3G9hRmPtvTZwGWDXWBM5jeYACEhZJ5DFHEHbCcjALW7rUwc9HMROJxfJCOcl/EeGnWTOHwyRHND5JAVvI1sT1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJZSNtwk+NbBKuvV2IilyepM+RP+3tRzRDMgIr9sVJE1UkCa2XcZTGn6z6X5pgmIDJlM5+xdSt+N+eAfO05rOjIsCUQPnQS9V9aHKUQnznu5EHz1i4vOjyMcWAJBaFgtZnTvi5pU21dNQP7w6fsLuYwUsALF37lxcRncgk+b24Y=
Received: by 10.142.48.14 with SMTP id v14mr243410wfv.14.1212447841602;
        Mon, 02 Jun 2008 16:04:01 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Mon, 2 Jun 2008 16:04:01 -0700 (PDT)
In-Reply-To: <484475FC.8020804@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83591>

On Tue, Jun 3, 2008 at 12:36 AM, Lea Wiemann <lewiemann@gmail.com> wrote:
> Are you suggesting that the squashed patches get merged, or that the
> squashed patches get reviewed but the finer-granulated patches get merged?

The latter is what I suggested :). I reckon you'll want ot keep the
finger-granulated history for future reference / bisecting, but when
reviewing that seems overkill.

>  In the former case, I'd probably prefer to work with larger patches in the
> first place (and not just squash them on the review branch), since they are
> easier to handle -- e.g. I sometimes need to go back and change things in
> earlier commits, and in those cases larger commits are easier.

If you don't think you're omitting information you will want later on
(meaning the more specific commit history), by all means, go with the
bigger patches. I find it nicer to create small commits, with the plus
that it cuts down the size of the commit msg too ;).

-- 
Cheers,

Sverre Rabbelier
