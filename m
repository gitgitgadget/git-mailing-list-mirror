From: Thomas Jarosch <thomas.jarosch@intra2net.com>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 11:03:59 +0100
Organization: Intra2net AG
Message-ID: <200903201103.59907.thomas.jarosch@intra2net.com>
References: <loom.20090320T094550-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steve <shrotty@gmx.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 20 11:15:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkbkk-0003Nb-3P
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761013AbZCTKKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759643AbZCTKKk
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:10:40 -0400
Received: from rs02.intra2net.com ([81.169.173.116]:45759 "EHLO
	rs02.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761361AbZCTKKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:10:39 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2009 06:10:39 EDT
Received: from intranator.m.i2n (unknown [172.16.1.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rs02.intra2net.com (Postfix) with ESMTP id 4B7B364E4;
	Fri, 20 Mar 2009 11:04:01 +0100 (CET)
Received: from localhost (intranator.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id E787E2AC4B;
	Fri, 20 Mar 2009 11:04:00 +0100 (CET)
Received: from storm.localnet (storm.m.i2n [172.16.1.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by intranator.m.i2n (Postfix) with ESMTP id 3D9C02AC4A;
	Fri, 20 Mar 2009 11:04:00 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-78.2.30.fc9.i686; KDE/4.2.1; i686; ; )
In-Reply-To: <loom.20090320T094550-421@post.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by Intranator (www.intra2net.com) with AMaViS and F-Secure AntiVirus (fsavdb 2009-03-20_01)
X-Spam-Status: hits=-1.8 tests=[ALL_TRUSTED=-1.8,BAYES_50=0.001]
X-Spam-Level: 982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113932>

Hi Steve,

On Friday, 20. March 2009 10:50:57 you wrote:
> Using HTTP as transport, I've noticed that after using git-gc on a git
> server, I can't push to that repo anymore: "No refs in common and none
> specified." Client and server are both 1.6.2. Is ths a bug or do I have to
> do something after executing git-gc on the server?

Check the permissions of the files on the server, I once accidentally executed
git commands as root user and the HTTP server was later
unable to read/write the repository properly.

Thomas
