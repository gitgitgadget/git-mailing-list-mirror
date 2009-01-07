From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] tutorial.txt renamed
Date: Wed, 7 Jan 2009 00:36:26 -0500
Message-ID: <DA6E1A83-FFBA-46BC-9BCF-ED8A2D8F12E7@silverinsanity.com>
References: <20090107042337.GA24735@gnu.kitenet.net> <200901070628.38019.chriscool@tuxfamily.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 06:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKR76-0000RE-4W
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 06:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbZAGFgd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 00:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZAGFgc
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 00:36:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:42564 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZAGFgc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 00:36:32 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 650FC1FFC046; Wed,  7 Jan 2009 05:36:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=4.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb3
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 7F6B51FFC044;
	Wed,  7 Jan 2009 05:36:17 +0000 (UTC)
In-Reply-To: <200901070628.38019.chriscool@tuxfamily.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Jan 7, 2009, at 12:28 AM, Christian Couder wrote:

> Le mercredi 7 janvier 2009, Joey Hess a =E9crit :
>> diff --git a/README b/README
>> index 548142c..5fa41b7 100644
>> --- a/README
>> +++ b/README
>> @@ -24,7 +24,7 @@ It was originally written by Linus Torvalds with =20
>> help
>> of a group of hackers around the net. It is currently maintained by =
=20
>> Junio
>> C Hamano.
>>
>> Please read the file INSTALL for installation instructions.
>> -See Documentation/tutorial.txt to get started, then see
>> +See Documentation/gittutorial.txt to get started,
>
> "man gittutorial" and "git help tutorial" should work to display the
> tutorial, so perhaps we should advise to use them instead of the =20
> source,
> since we are advising to use "man git-commandname" below to get help =
=20
> on
> each command.

This is the README file for the project, so it should advise looking =20
at the Documentation directory as neither the man pages or git command =
=20
are likely installed at this point.

>> CVS users may also want to read Documentation/cvs-migration.txt.
>
> The "cvs-migration.txt" was also renamed "gitcvs-migration.txt". It =20
> should
> be available with "man gitcvs-migration" and "git help cvs-migration"=
=2E

This however is a valid point.

I would also suggest that the patch have a different name, as I =20
expected it to be renaming tutorial.txt and I was going to ask why.  =20
Perhaps "README: correct for renamed files"?

~~ Brian G.