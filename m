From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 21:17:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112112540.3586@pacific.mpi-cbg.de>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no> <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de> <86iqol8wql.fsf@broadpark.no> <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de> <86eiz98v0s.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6lr-0001NU-Le
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbZAKUQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZAKUQ6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:16:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:58330 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754650AbZAKUQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:16:57 -0500
Received: (qmail invoked by alias); 11 Jan 2009 20:16:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 11 Jan 2009 21:16:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+I/L9Ijf+IhMNr+EhxZQyNNppGSFf7Qm3latjD6P
	AWgbM9pNLLVI3a
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <86eiz98v0s.fsf@broadpark.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105217>

Hi,

On Sun, 11 Jan 2009, Kjetil Barvik wrote:

>     git format-patch

Necessary.

>  --stat

Not necessary.

>  --patch-with-raw

As I showed you, also not necessary.

> -1

Necessary.

> --signoff

If you had signed off on your commits already, not necessary.  (FWIW I 
keep a sign off as a marker that I actually think this is good to be 
submitted, or at least close.)

> -M -C

Usualy not necessary, unless you rename some file, or introduce a huge 
code 
duplication.

>        --summary

Dunno.  I think it's not really necessary, you see that from the diff.

> --full-index

I find it makes the patch hard to read, as the index line will always 
wrap.  And it's not necessary, as it is so highly unlikely that the hash 
is unique in your repository, but not mine.

> --subject-prefix="PATCH"

Not necessary.

>        --output-directory ../diff_lib_c_symcache_cleanup_v1/

If you insist...

Sure, you can make it complicated, but I usually prefer something like

	$ git format-patch -3 --cover-letter

Nice 'n easy.

Ciao,
Dscho
