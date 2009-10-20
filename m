From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 22:22:36 +0200
Message-ID: <200910202222.37563.j6t@kdbg.org>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com> <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com> <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LE5-0002VI-QD
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZJTUW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZJTUW1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:22:27 -0400
Received: from [93.83.142.38] ([93.83.142.38]:65285 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751137AbZJTUW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:22:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C0F2E19F65C;
	Tue, 20 Oct 2009 22:22:37 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130835>

On Dienstag, 20. Oktober 2009, Alex Riesen wrote:
> What's so hard with storing the SHA-1 of the *commit*, anyway?

The hard part is that you get a cycle: commit SHA1 depends on contents depends 
on commit SHA1.

-- Hannes
