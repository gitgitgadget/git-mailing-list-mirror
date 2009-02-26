From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Fri, 27 Feb 2009 00:58:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902270056270.10279@pacific.mpi-cbg.de>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com> <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org> <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com> <7vmyc8rhry.fsf@gitster.siamese.dyndns.org> <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com>
 <7veixkrfif.fsf@gitster.siamese.dyndns.org> <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com> <7v4oygrd3w.fsf@gitster.siamese.dyndns.org> <wRrDhWKagbvPUgIXKKh8JIhASl974j2rrgyuh-WEzRJFcXywywNupg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:59:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcq8D-0002DL-RG
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZBZX5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbZBZX5j
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:57:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:55644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753091AbZBZX5j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:57:39 -0500
Received: (qmail invoked by alias); 26 Feb 2009 23:57:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 27 Feb 2009 00:57:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18LmRkJWhYLsYuENRoOEeastCzkBqVNtq/k8PcPr1
	3s+j4NZWGvJo6j
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <wRrDhWKagbvPUgIXKKh8JIhASl974j2rrgyuh-WEzRJFcXywywNupg@cipher.nrlssc.navy.mil>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111617>

Hi,

On Thu, 26 Feb 2009, Brandon Casey wrote:

>    sed -e 'script' input-file
> 
> rather than
> 
>    sed -e 'script' < input-file

What should make the former more preferable to the latter?

Especially given that the latter way is preferable with other commands (at 
least as far as our test suite is concerned), such as grep, because you do 
not get the file name as part of the result?

And especially given that sed means _stream_ editor, not file editor?

Ciao,
Dscho
