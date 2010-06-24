From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebasing a merge
Date: Thu, 24 Jun 2010 10:22:38 -0400
Message-ID: <AANLkTik5PteeUzGvElMTiTiFf64s4KFEyoTAq_f8wLAf@mail.gmail.com>
References: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
	<alpine.DEB.2.00.1006181010220.12445@ds9.cixit.se>
	<AANLkTikH9S1GCOwJfmKvO4fTvG46libJtrdMNQeiBm1_@mail.gmail.com>
	<alpine.DEB.2.00.1006241012400.28950@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jun 24 16:22:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORnKH-00033H-IX
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 16:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab0FXOWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 10:22:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58197 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab0FXOWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 10:22:39 -0400
Received: by iwn41 with SMTP id 41so902581iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=d9D/mrQL9CU22dXteScyyk3cIyDWpPo9GV6BVGsIUfY=;
        b=p0uB9neVOrkz1wMYlQP4YJHIyXusvdNyXF40EObWzWuLT0iaUh9oeGCghOllClWbj1
         u3JzZs2lta3xWW/wdpC8Ntdwty6MK+ahkGj0OBrRVSDrwKih/BDgB4GtHYmq6+JiY9jM
         KPTMZ0yib54e2vv+Z6n4mfxHgiS7w0DSIUonM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lA17jXL4ylhoLzkxdNdUzhbLB5ErI3a7YdX6QJGTbERPoHy+53uSdNZnkqu0z8n9P0
         r1OsobkuF89t2Muy1nTZLCw+GFxll9fR4eh01JLLGvULYsTXw0qcz+LqrAjPrK2JakP4
         QO6H8XB2aAJDxtmgpnbd2qGtgj/Llwo6jZgZw=
Received: by 10.231.187.6 with SMTP id cu6mr9838126ibb.76.1277389358745; Thu, 
	24 Jun 2010 07:22:38 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Thu, 24 Jun 2010 07:22:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006241012400.28950@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149596>

On Thu, Jun 24, 2010 at 5:16 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> You could probably get off by "git cat-file" the commit object, changing the
> parent reference to point to the newly introduced commit while leaving the
> rest intact, and then "git hash-object" the new commit object, and then
> forward the branch head to that one.

Did you miss my followup message?

http://article.gmane.org/gmane.comp.version-control.git/149335

j.
