From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-am annoyance
Date: Tue, 27 Jan 2009 23:49:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272348380.3586@pacific.mpi-cbg.de>
References: <bd6139dc0901271407i4406d5e6u6db1df9e5a7bdc4f@mail.gmail.com>  <7vr62o1iww.fsf@gitster.siamese.dyndns.org> <bd6139dc0901271437l19f1201ch867f1a7c2045e54b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jan 27 23:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwlX-0007y8-L6
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbZA0WtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZA0WtR
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:49:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:36327 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751678AbZA0WtR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:49:17 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:49:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 27 Jan 2009 23:49:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/GqkQMhiLG0sYzbUYJXf8NBdWy69+igQCR+bfCWC
	izX7bddOzLbFtk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0901271437l19f1201ch867f1a7c2045e54b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107411>

Hi,

On Tue, 27 Jan 2009, Sverre Rabbelier wrote:

> What is '-t 0'? How would one detect this in bash?

It detects if file descriptor 0 (stdin) is a terminal.  "man test" to the 
rescue ;-)

Ciao,
Dscho

P.S.: if I hadn't tried exactly that in my valgrind patches recently, I 
would not have known either...
