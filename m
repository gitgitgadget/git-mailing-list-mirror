From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: [PATCH FYI] t9700/test.pl: backwards compatibility improvements
Date: Mon, 15 Sep 2008 13:54:38 +0200
Message-ID: <48CE4CFE.1010106@statsbiblioteket.dk>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <iZMIxnwnUBIGAGz2GMS0uwCvMMo9aaYd2Arx4fbxk9NusvUC5LUNVg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Sep 15 13:55:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfCgH-0002ec-9O
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 13:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYIOLym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 07:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbYIOLym
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 07:54:42 -0400
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:52906 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752955AbYIOLyl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 07:54:41 -0400
Received: from [130.225.25.181] (130.225.25.181) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.291.1; Mon, 15 Sep 2008 13:54:39 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080820)
In-Reply-To: <iZMIxnwnUBIGAGz2GMS0uwCvMMo9aaYd2Arx4fbxk9NusvUC5LUNVg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95900>

Brandon Casey wrote:
> Some versions of perl complain when 'STDERR' is used as the third argument
> in the 3-argument form of open(). Convert to the 2-argument form which is
> described for duping STDERR in my second edition camel book.
> 
> The object oriented version of File::Temp is a rather new incarnation it
> seems. The File::Temp man page for v5.8.0 says "(NOT YET IMPLEMENTED)" in
> the 'Objects' section. These can be converted to use File::Temp::tempfile().
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
 >
Tested-by: Tom G. Christensen <tgc@statsbiblioteket.dk>

Without this patch the testsuite will fail with perl 5.8.0:
t9700$ ./test.pl
ok 1 - use Git;
Bareword "STDERR" not allowed while "strict subs" in use at ./test.pl 
line 41.
Execution of ./test.pl aborted due to compilation errors.
1..1
# Looks like your test died just after 1.


Could we please get this patch in?

-tgc
