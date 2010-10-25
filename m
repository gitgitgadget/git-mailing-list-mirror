From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 00/11] More consistant terminology ("remote-tracking
	branch", "not updated")
Date: Mon, 25 Oct 2010 13:52:30 -0400
Message-ID: <1288029150.819.78.camel@drew-northup.unet.maine.edu>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Oct 25 19:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAREL-0003hg-MH
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 19:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759248Ab0JYRxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 13:53:02 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:46337 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759121Ab0JYRxA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 13:53:00 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9PHqZZX021788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 25 Oct 2010 13:52:35 -0400
In-Reply-To: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9PHqZZX021788
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288633955.98577@eIQGi0zypyXS6VXDUGT0Qw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159963>


On Sat, 2010-10-23 at 18:31 +0200, Matthieu Moy wrote:
> Following the discussion in
> 
> http://thread.gmane.org/gmane.comp.version-control.git/159287/
> http://thread.gmane.org/gmane.comp.version-control.git/159287/focus=159288
> 
> this is an attempt to be more consistant in the terminology used in Git.
> 
> The first patch fixes git status's "changed but not updated", and the
> rest tries to use "remote-tracking branch" consistantly. This
> essentially changes the doc, and also does slight modifications to the
> code. This changes error message, and maybe more controversially the
> generated merge messages (in a separate patch in case this is too
> controversial).
> 
> I've tried splitting this into systematic changes to ease review, but
> patches should be applicable in any order (i.e. Junio: if you find
> some of the patches good and uncontroversial, you can pick them
> right away).
> 
> Patch "user-manual.txt: explain better the remote(-tracking) branch
> terms" comes last, and adds a few sentences to make the distinction
> between remote, remote branch, remote-tracking branches explicit.
> Hopefully, this should avoid future users to have the same
> difficulties as Thore ;-).
> 
> The last 2 patches are minor things I noticed while going through the
> docs, but are essentially unrelated.
> 
> I'll be busy next week, so if anyone else wants to pick this patch
> serie and update it according to list review, he's welcome. Otherwise,
> it may have to wait.
> 
> Matthieu Moy (11):
>   Better "Changed but not updated" message in git-status
>   Remplace "remote tracking" with "remote-tracking"
>   Change remote tracking to remote-tracking in non-trivial places
>   Change "tracking branch" to "remote-tracking branch"
>   Change "tracking branch" to "remote-tracking branch" in C code
>   Change incorrect uses of "remote branch" meaning "remote-tracking"
>   Change incorrect "remote branch" to "remote tracking branch" in C
>     code
>   Use 'remote-tracking branch' in generated merge messages
>   user-manual.txt: explain better the remote(-tracking) branch terms
>   git-branch.txt: mention --set-upstream as a way to change upstream
>     configuration
>   git-http-push.txt: fix typo (branch -> branches)

I'm going to apply these to a branch of mine to see how they read in
context before I come to any definite conclusions. So far I like what I
see for the most part.

-- 
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
