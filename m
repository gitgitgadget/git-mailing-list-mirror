From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Sat, 24 Jan 2009 12:54:28 -0800
Message-ID: <18811.32772.728276.923430@hungover.brentg.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	<alpine.LNX.1.00.0901212319310.19665@iabervon.org>
	<e38bce640901212334v1e672d48t81d5c81fecd929eb@mail.gmail.com>
	<alpine.LNX.1.00.0901220238380.19665@iabervon.org>
	<7vbptzahra.fsf@gitster.siamese.dyndns.org>
	<e2b179460901220204x7b6a43b5hddfee623d2425429@mail.gmail.com>
	<18808.39712.351656.138702@hungover.brentg.com>
	<alpine.LNX.1.00.0901221117110.19665@iabervon.org>
	<alpine.DEB.1.00.0901221751320.3586@pacific.mpi-cbg.de>
	<18809.60512.654436.59819@hungover.brentg.com>
	<alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Brent Goodrick <bgoodr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:56:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQpXr-0001FI-M3
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbZAXUyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbZAXUye
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:54:34 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:38656 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbZAXUyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:54:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5267395rvb.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:message-id:date
         :mime-version:content-type:content-transfer-encoding:to:cc:subject
         :in-reply-to:references:x-mailer;
        bh=VV7EKU7UUS4BnO3dcytvADGd3sRUUZWTgORNvqK0rZM=;
        b=eWqjsJyfGqdFlycykvf2LGPabjBWFjH/dxR1JuCL/uLqVg0iGYJjG3XMhFMS556iSP
         3Y3hMN0DB+DysFUi2MeYxucL4Gy47M020nh3LMgZXGQCXRwpb34UxTPOTp4ur8W0NWl6
         twVBZ043EA2yaYtvAuksmcJUpzxBxU3j0W+uM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:message-id:date:mime-version:content-type
         :content-transfer-encoding:to:cc:subject:in-reply-to:references
         :x-mailer;
        b=DhukS2yOO8dFyJgIbUP74PjURRiKAYuWcw5oTF2XQFJeGwrxrwvTue3Pnm+qAVcF3p
         sJE9SihVROvac1kqHz8iRrTm6qRDoht9yDNGHa1k/cQQiTWLS9D3kb+VD93+I0c/cSQC
         6VOY8HEsBTvj2N4VXCdrBPzfisNAAjJ4ZzaUU=
Received: by 10.141.122.1 with SMTP id z1mr473629rvm.210.1232830472106;
        Sat, 24 Jan 2009 12:54:32 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id f21sm25971831rvb.7.2009.01.24.12.54.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jan 2009 12:54:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302>
X-Mailer: VM viewmail-606 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107007>


Junio C Hamano writes:
 > I do not think so.  --no-progress should imply --no-cr ;-)
 > 
 > I do not think it makes much sense to pollute your non-terminal with 100
 > lines of 1%,2%,3%,...100% if it cannot sensibly do carriage-returns.  It
 > may be another knob to tweak, but it's a kind of thing you implement
 > because you could, not because it makes sense.  I would be mildly against
 > no-cr.

Good point. I'll drop the --no-cr as redundant.

Johannes Schindelin writes:
 > Hi,
 > 
 > On Fri, 23 Jan 2009, Brent Goodrick wrote:
 > 
 > >  - Bare minimum: Add a new --no-cr option
 > 
 > I do not see any value of this over "--progress | tr '\r' '\n'".  (The 
 > --progress option being the natural counterpart to --no-progress, 
 > _forcing_ the display of the progress.)

Agreed. Both --progress and --no-progress are the only options to be
implemented for this.  

 > Just have a 
 > look at 7d1864c(Introduce is_bare_repository() and core.bare configuration 
 > variable).

Note that I'm coming from a CVS and Perforce user background but am
still new to git usage. How do I "take a look" at "7d1864c"?

I will take a closer look at the list of things you explained in your
"Basically, you'll have to" list.

While I'm at it, what is the standard procedure for submitting git
patches for review once I've cooked up and validated it on my end? I'm
guessing posting the patch into this mailing list is part of the
answer to that question.

Thanks,
Brent
