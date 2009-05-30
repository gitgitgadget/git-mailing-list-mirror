From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] http-push: send out fetch requests on queue
Date: Sat, 30 May 2009 17:31:36 +0800
Message-ID: <be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat May 30 11:31:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAKum-0006EH-MU
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 11:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbZE3Jbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 05:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZE3Jbf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 05:31:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:5963 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbZE3Jbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 05:31:34 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2009512rvb.1
        for <git@vger.kernel.org>; Sat, 30 May 2009 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=65jbNIEy2SzwKyD8sDAs64Z4bi7nI85T30+rerdv0Vw=;
        b=cSr1bzD+VlGT6LHT13ixiLqMJA3NoEPJ14T4ItERb22hwCPqzblf7RoV5bSuynL4ee
         RWxDpzFXEz6GMnQkMVA3OyGhC+VZWRdGI6LBdTHO/ZLqcmuLXRbjkGYGf7gFSAhQUPDN
         fE236gDS6OXKDNtAQZpIow46cDoAR3Ys8Sxw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t3M2cuNqFlq4q9gwWJ+0TLC59FZ1VL45tJF2FDdNxzBdoDJH/a1Te1L7kvx1P4zChB
         TBS/bjGtnF1QvXXjWWZwB30t7fjpzWEUT9wE93s6tKtLNMBA4mR9GRz07hwd8Fl15jiL
         u1eeqqXrAlvR2R63O+2vSoWGxtbPXpVAtg6qg=
Received: by 10.141.152.9 with SMTP id e9mr2733666rvo.189.1243675896664; Sat, 
	30 May 2009 02:31:36 -0700 (PDT)
In-Reply-To: <20090530091755.GA13578@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120341>

Hi,

On Sat, May 30, 2009 at 5:17 PM, Clemens Buchacher <drizzd@aon.at> wrote:
> The "http-push fetches packed objects" test of t5540 on pu either segfaults
> or hangs indefinitely on my machine [1]. The bug is revealed by the added
> line above in commit 0d71b15 (http-push: send out fetch requests on queue).

if you don't mind, could you try running this test on the
http-fix-push-fetching branch in git://github.com/rctay/git.git and
see if this still happens? It contains these patches only, applied on
master.

-- 
Cheers,
Ray Chuan
