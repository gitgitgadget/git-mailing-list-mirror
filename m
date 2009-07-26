From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: db/transport-shim, was Re: What's cooking in git.git (Jul 2009, #02;
 Sun, 26)
Date: Sun, 26 Jul 2009 12:35:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907261232280.8306@pacific.mpi-cbg.de>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:35:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV154-0002i7-Ct
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZGZKfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 06:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbZGZKfI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:35:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:37462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753401AbZGZKfG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 06:35:06 -0400
Received: (qmail invoked by alias); 26 Jul 2009 10:35:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 26 Jul 2009 12:35:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1819gAvzGc1UpV4EbKVoAn/3+wQfUd8MQLWwnp0f7
	bBYZ4GfLSAG17v
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124121>

Hi,

On Sun, 26 Jul 2009, Junio C Hamano wrote:

> * db/transport-shim (Sat Jul 25 13:51:40 2009 -0400) 3 commits
>  - git-http-fetch: not a builtin
>  - Use an external program to implement fetching with curl
>  - Add support for external programs for handling native fetches
> 
> Interesting as a concept.  I saw its ls-remote segfault on me, though.
> Hopefully will mature by 1.6.5 final.
> 
> [...]
>
> * db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
>  - Add option for using a foreign VCS
>  - Document details of transport function APIs
>  - Allow late reporting of fetched hashes
> 
> I have a feeling that the recent transport-shim series from the same
> author could supersede this one.

Oh, you mean that the foreign scm helpers would turn into shim helpers, 
which could then either call fast-import directly or use another helper?

Interesting,
Dscho
