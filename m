From: dhruva <dhruvakm@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 19:35:24 +0530
Message-ID: <e3f230850811100605u75eb811bidb8f36f62c3673ce@mail.gmail.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	 <bd6139dc0811091643m31ff6f49o55a4c581be7f38b2@mail.gmail.com>
	 <87hc6gjs7v.fsf@erwin.mina86.com>
	 <alpine.DEB.1.00.0811101319570.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Michal Nazarewicz" <mina86@tlen.pl>, sverre@rabbelier.nl,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 15:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzXPe-00049U-FS
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 15:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbYKJOF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 09:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbYKJOF1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 09:05:27 -0500
Received: from ti-out-0910.google.com ([209.85.142.184]:11793 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754316AbYKJOF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 09:05:26 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1547157tic.23
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=f6Km+d0zlZWZYDyoDAKWvlg3NM0R8DDbewoszjnz1rI=;
        b=xBDuSGLbEX9I2wpcVRRVGpKwiXb1f1BKCgs7NIqMprod6LAIVWpAuBmLvTA57C4EsH
         w4StEbJtG4Tmsr3a0njaoJWVqZ2/+xF7JnVILSZwRy1YtSJqn05RZid5qVULkgkN1AYX
         I4ziktGZQQ3kg50MzVxvHV04PC/UACS6UUCO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t1NbQ6fI+agrCHIJTtxo4iV8thpOs/l2cxbuMteJUjwNFw8u6YIHjbhyHhBa4lV+yQ
         i3oVelT0C8+ddCeahaykrCeUg2LbBhSnzJ9Nq45lS0xfu43OWWLm7WJ1hR9tbSakiuLc
         EgNmgZuaeLlnsqQgoD4KMxEDDGlx3uhv9nu4Q=
Received: by 10.110.41.20 with SMTP id o20mr8006530tio.20.1226325924108;
        Mon, 10 Nov 2008 06:05:24 -0800 (PST)
Received: by 10.110.93.2 with HTTP; Mon, 10 Nov 2008 06:05:24 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0811101319570.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100523>

Hi,

On Mon, Nov 10, 2008 at 5:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If that is not your use case, then it may be wise to let us Git people
> know what you _actually_ want (i.e. instead of asking for a specific
> solution, you could tell us what your problem is).

Since you have opened this topic to make a request with the problem, I
have a problem for which I need $Id$ expansion.

The git-p4 tool does not record contents in $Id$. When I try to submit
from git to p4 using git-p4, it does a 'p4 sync' which brings in
modified files with $Id$ changes. When git-p4 tries to apply patches,
it would not have recorded the change in $Id$. If there was a
mechanism to make $Id$ change and tracked in git, it would have
recorded a change as a hunk and the patch would have applied cleanly.
I have posted this problem earlier and also on the #git channel. Hope
to see some traction.

with best regards,
dhruva

-- 
Contents reflect my personal views only!
