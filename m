From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in git-status
Date: Sat, 30 Oct 2010 06:00:56 +0200
Message-ID: <vpqlj5gxrbb.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
	<20101028183513.GC14212@burratino>
	<7vaaly9eji.fsf@alter.siamese.dyndns.org>
	<20101028220956.GC16125@burratino>
	<1288386368.7988.22.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sat Oct 30 06:01:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC2dB-00083a-O6
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 06:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740Ab0J3EBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 00:01:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39987 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab0J3EBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 00:01:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9U3k8ul010155
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 30 Oct 2010 05:46:08 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PC2cj-0007kg-FY; Sat, 30 Oct 2010 06:00:57 +0200
In-Reply-To: <1288386368.7988.22.camel@drew-northup.unet.maine.edu> (Drew Northup's message of "Fri\, 29 Oct 2010 17\:06\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 30 Oct 2010 05:46:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9U3k8ul010155
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1289015169.94999@sxOsFZLfN7XpvTClvn8FcQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160372>

Drew Northup <drew.northup@maine.edu> writes:

> On Thu, 2010-10-28 at 17:09 -0500, Jonathan Nieder wrote:
>> 
>> # Changes to be committed:
>> #   (use "git reset -- <path>..." to unstage)
>> #
>> #	new file:    foo.c
>> #
>> # Changes not to be committed:
>> #   (use "git add <path>..." to update what will be committed)
>> #   (use "git checkout -- <path>..." to discard changes in working
>> #   directory)
>> #
>> #	typechange:  bar.c
>
> This one gets my vote out of the replacements I've seen. I appreciate
> leaving the "git add" idiom untouched.

I still prefer my version. "Not staged for commit" makes it clearer
that the files appear in this section because the user did not do some
action (stage), while "not to be commited" remains a bit more
misterious about the reason why the changes will not be commited, and
mentionning the word "stage" here somehow teaches the user what
staging means in the Git world.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
