From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: add a From: line to the email header
Date: Tue, 22 Jan 2008 15:12:04 +0100
Message-ID: <CA518F22-C0E4-4C2E-A86C-6E8CB1776FAE@lrde.epita.fr>
References: <20071108094809.22151.qmail@97f06c2e73713e.315fe32.mid.smarden.org> <7vode52hag.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>,
	Git Mailing List <git@vger.kernel.org>, tv@eagain.net
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 15:13:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHJrv-0001gn-4h
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 15:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277AbYAVOMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 09:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYAVOMU
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 09:12:20 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:58178 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbYAVOMT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 09:12:19 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1JHJrL-0003uf-QB; Tue, 22 Jan 2008 15:12:15 +0100
In-Reply-To: <7vode52hag.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71451>

On Nov 8, 2007, at 10:55 AM, Junio C Hamano wrote:

> Gerrit Pape <pape@smarden.org> writes:
>
>> $committer is already extracted from the latest existing rev, so  
>> add the
>> corresponding From: line to the email header.
>
> You may fight this out with Andy if you want to, but I think I'd
> side with the existing behaviour.
>
> commit e6dc8d60fbd2c84900a26545c5d360b0e202d95b
> Author: Andy Parkins <andyparkins@gmail.com>
> Date:   Fri Sep 28 15:24:26 2007 +0100
>
>     post-receive-hook: Remove the From field from the generated  
> email header so that the pusher's name is used
>
>     Using the name of the committer of the revision at the tip of the
>     updated ref is not sensible.  That information is available in  
> the email
>     itself should it be wanted, and by supplying a "From", we were
>     effectively hiding the person who performed the push - which is  
> useful
>     information in itself.
>
>     Signed-off-by: Andy Parkins <andyparkins@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>


Hi guys,
the problem with this change is that when one uses Gitosis all the  
commits are pushed with the `git' user so emails always appear to  
come from git@fqdn.  I guess it would be worth to add an option to  
retain the old behavior (where $committer was extracted from the last  
commit pushed and used in the `From' field), don't you think?

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
