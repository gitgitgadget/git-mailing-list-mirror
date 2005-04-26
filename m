From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: (SOLVED) Re: cg-add and update-cache add fails
Date: Tue, 26 Apr 2005 17:44:44 +0100
Message-ID: <200504261744.44394.rhys@rhyshardwick.co.uk>
References: <200504261735.47008.rhys@rhyshardwick.co.uk>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 18:46:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQTBT-0006Z1-WD
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 18:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVDZQtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 12:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDZQtV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 12:49:21 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:64440 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261677AbVDZQov (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 12:44:51 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp003.mail.ukl.yahoo.com with SMTP; 26 Apr 2005 16:44:45 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DQTAy-0005jg-SM
	for git@vger.kernel.org; Tue, 26 Apr 2005 17:44:44 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <200504261735.47008.rhys@rhyshardwick.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ok, I have been known to be silly.  But this silly? :)

Create the file, then add it to the repository.  Makes sense really.

Rhys

On Tuesday 26 Apr 2005 17:35, Rhys Hardwick wrote:
> Hey there,
>
> I posted a little while ago about this, but thought I would collate all my
> findings.  I am very lost.  Trying to add files to the repository does not
> seem to work, no matter which git repository I try.  Creating new trees and
> updating current trees, as well as removing files is not a problem.  All
> other areas of git seem to work perfectly.  I am currently using
> cogito-0.8. This error started to occur in pasky-0.63.
>
> Here is the error I get:
>
> rhys@metatron:~/repo/learning.repo$ cg-add w1p4d1.c
> fatal: Unable to add w1p4d1.c to database
> rhys@metatron:~/repo/learning.repo$ update-cache --add w1p4d1.c
> fatal: Unable to add w1p4d1.c to database
>
> All the files under the .git folder appear to be owned by me, and are
> read-writable.  The disk is not full.
>
> I have attached the output from strace and ltrace.
>
> If anyone could shed any light on why this might be happening, I would be
> very grateful.
>
> Rhys


