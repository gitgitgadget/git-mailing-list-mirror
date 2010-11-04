From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 04 Nov 2010 11:25:30 +0100
Organization: Bertin Technologies
Message-ID: <20101104112530.5c0e444a@chalon.bertin.fr>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: kevin@sb.org
X-From: git-owner@vger.kernel.org Thu Nov 04 11:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDxB3-000712-5s
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab0KDKgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 06:36:05 -0400
Received: from blois.bertin.fr ([195.68.26.9]:54848 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755728Ab0KDKgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 06:36:01 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 2D50C54476
	for <git@vger.kernel.org>; Thu,  4 Nov 2010 11:35:52 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 3FCCE54470
	for <git@vger.kernel.org>; Thu,  4 Nov 2010 11:35:47 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LBC006FSW3N6P50@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 04 Nov 2010 11:35:47 +0100 (CET)
In-reply-to: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17744.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160713>

>> I'm sorry if I'm missing something, but how is this different from
>> "edit"?
>
>Edit cherry-picks a commit, then exits to the shell. I needed to exit
>to the shell without cherry-picking a commit.

Indeed, before "x false" was available, I had found out that "edit"
without an argument fails with a harmless error and indeed achieves that
"pause" mechanism which was really missing.

What about just fixing this so we can use "edit" ?  Do we really need
another command here ?

-- 
Yann Dirson - Bertin Technologies
