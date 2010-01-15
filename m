From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/2] Fix variable initialization in insert_packed_refs().
Date: Fri, 15 Jan 2010 12:02:38 +0100
Message-ID: <201001151202.38762.richard@nod.at>
References: <201001150029.01486.richard@nod.at> <4B501A9D.6060703@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 12:02:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVjxB-000418-8l
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 12:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036Ab0AOLCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 06:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756932Ab0AOLCv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 06:02:51 -0500
Received: from a.ns.miles-group.at ([217.188.240.210]:47664 "EHLO
	radon.swed.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756881Ab0AOLCo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 06:02:44 -0500
Received: (qmail 11525 invoked by uid 89); 15 Jan 2010 11:02:42 -0000
Received: by simscan 1.3.1 ppid: 11517, pid: 11521, t: 0.0839s
         scanners: attach: 1.3.1 clamav: 0.92.1
/m: 
Received: from unknown (HELO raccoon.localnet) (richard@nod.at@91.114.243.75)
  by radon.swed.at with ESMTPA; 15 Jan 2010 11:02:42 -0000
User-Agent: KMail/1.12.4 (Linux/2.6.25.20-0.5-pae; KDE/4.3.4; i686; ; )
In-Reply-To: <4B501A9D.6060703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137063>

Am Freitag 15 Januar 2010 08:34:53 schrieb Johannes Sixt:
> If you look around in the code, you'll find more *cough* initializations
> *cough* like this. They are written this way for a reason: they avoid
> unwarranted compiler warnings "'foo' may be used uninitialized". Are you
> saying that this warning is not triggered anymore after your change?
> 

I don't get a warning after my change. 
But I'm using on this system a quite old gcc (4.3.1).
I'll recompile git with a more recent gcc and see what happens.

Just for clarification:
"int cmp = cmp;"
*suppresses* only the warning but "cmp" is still uninitialized?
(I did'nt know this trick before.)

//richard
