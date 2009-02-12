From: Jon Nelson <jnelson@jamponi.net>
Subject: Re: git gc --prune consumes *lots* of memory with repos cloned with 
	--reference
Date: Thu, 12 Feb 2009 14:37:24 -0600
Message-ID: <cccedfc60902121237h6bb9b9dn98c485e85c53440d@mail.gmail.com>
References: <cccedfc60902121032y17180739r2a049197323d3588@mail.gmail.com>
	 <20090212185925.GC20552@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Feb 12 21:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiKk-0007C2-HG
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 21:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759270AbZBLUh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759113AbZBLUh1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 15:37:27 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:54706 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642AbZBLUh0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 15:37:26 -0500
Received: by yx-out-2324.google.com with SMTP id 8so475252yxm.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 12:37:25 -0800 (PST)
Received: by 10.100.96.10 with SMTP id t10mr1705721anb.32.1234471044819; Thu, 
	12 Feb 2009 12:37:24 -0800 (PST)
In-Reply-To: <20090212185925.GC20552@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109644>

Indeed - I was running 1.6.0.2.

I tried 1.6.1.3 and it certainly helped the memory consumption
problem, although for some reason it went very slowly the first time.

Thanks!

On Thu, Feb 12, 2009 at 12:59 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
>
> Probably an older git version? There was a bug that caused a memory l=
eak
> with unreachable objects being forced to be loose objects. That was
> fixed in 1.6.0.3


--
Jon
