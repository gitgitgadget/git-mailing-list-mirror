From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using Format/export-subst Howto.
Date: Mon, 17 Sep 2012 16:21:02 +0200
Message-ID: <505731CE.1090500@drmicha.warpmail.net>
References: <84EA18831601B6429E578236AE239B01A54807F242@EAGNMNSXMB07.usa.dce.usps.gov> <50532B35.9050607@drmicha.warpmail.net> <5053480E.2010002@viscovery.net> <84EA18831601B6429E578236AE239B01A54807F376@EAGNMNSXMB07.usa.dce.usps.gov> <50534FC6.2040207@viscovery.net> <1347656962.3998.140661128069097.6D9BE3C4@webmail.messagingengine.com> <7vfw6k2t8w.fsf@alter.siamese.dyndns.org> <84EA18831601B6429E578236AE239B01A5498B52A3@EAGNMNSXMB07.usa.dce.usps.gov> <50572971.9020204@drmicha.warpmail.net> <84EA18831601B6429E578236AE239B01A5498B5390@EAGNMNSXMB07.usa.dce.usps.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Mestnik, Michael J - Eagan, MN - Contractor" 
	<Michael.J.Mestnik@usps.gov>
X-From: git-owner@vger.kernel.org Mon Sep 17 16:21:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDcCJ-0004mx-Lt
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 16:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756437Ab2IQOVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 10:21:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53477 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756335Ab2IQOVF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Sep 2012 10:21:05 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5976120913;
	Mon, 17 Sep 2012 10:21:04 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 17 Sep 2012 10:21:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=dDb11bPtaosHqex0krn0tF
	KEwno=; b=CwQJGL9Q4FJopXkQ7FNQxs1qBHYCtTmL51fSZw3LXbGm3o/dTfgjvV
	F+q+gjp4XF5A2oSjYRhBRuqMuFRT0c3Bd5IfBmT4prgLPPGdGfuVwd2RNIdOUyoT
	wHoyR3KOPQPQ8nB2+ySkx1HC1gYOY8ZxfKyvhrt367u8nIxRMCE9Q=
X-Sasl-enc: Pgrek0jDCxxj1lL0KFUTY48N7g241+9B4salxBtRnPmE 1347891664
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 72E444835FB;
	Mon, 17 Sep 2012 10:21:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <84EA18831601B6429E578236AE239B01A5498B5390@EAGNMNSXMB07.usa.dce.usps.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205692>

Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
17.09.2012 16:08:
> 
>> -----Original Message-----
>> From: Michael J Gruber [mailto:git@drmicha.warpmail.net] 
>> Sent: Monday, September 17, 2012 8:45 AM
>> To: Mestnik, Michael J - Eagan, MN - Contractor
>> Cc: Junio C Hamano; Johannes Sixt; git@vger.kernel.org
>> Subject: Re: Using Format/export-subst Howto.
>>
>> Mestnik, Michael J - Eagan, MN - Contractor venit, vidit, dixit
>> 17.09.2012 14:12:
>>>
>>>> -----Original Message-----
>>>> From: Junio C Hamano [mailto:gitster@pobox.com] 
>>>> Sent: Friday, September 14, 2012 4:24 PM
>>>> To: Michael J Gruber
>>>> Cc: Johannes Sixt; Mestnik, Michael J - Eagan, MN - 
>>>> Contractor; git@vger.kernel.org
>>>> Subject: Re: Using Format/export-subst Howto.
>>>>
>>>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>>
>>>>> you need to "rm file && git checkout file"). If the user 
>>>> has to update
>>>>> $Id$ to match the current sha1
>>>>> (by remembering to do a more forceful checkout than 
>>>> checkout -f) then
>>>>> one half of that feature is useless. 
>>>>
>>>> As if there is any value in "$Id$" _feature_.  It's a 
>> checkbox item,
>>>> nothing more ;-).
>>>>
>>>
>>> I agree here, $Id$ is much more useful in rcs/cvs.  That's 
>> why I chose to dive into export-subst, because I wanted my 
>> output to not only contain the uniq Id of the script but also 
>> the time and user of the last edit.
>>>
>>> I'm going to read up on export today.  Just for context I'm 
>> using git to manage daily cron scripts, run on about 1,000 
>> hosts, located on NFS.  I've moved the editing of the scripts 
>> into user's home directories as I'm a fan of not using 
>> editors on live data.  The key point is that when sudoing to 
>> the shared user who manages the files the commands run should 
>> be minimal and "pushd; ln -s ... .git; git pull; rm .git; 
>> popd;" works well.  If I can replace this with something that 
>> would populate these fields that would be awesome.
>>
>> I'm not completely sure about the setup, but something like
>>
>> GIT_DIR=fromthisrepo git archive usethisbranchortag |
>> git tar -xf- -C thereyougo
>>
> Yes, that's about what the man page says.  I though I could pass --keep-newer-files to tar and that would prevent files from being re-created, but a "git archive --format=tar HEAD | tar -tvv" indicates that every file has the current date/time and not, for example, the time of the last commit that modified that file.  Not only would pushing every file be undesirable it would also cause every server to pull every file and that's unacceptable.  Another down side, or perhaps this is the downside, to this method is that it lacks any form of merge capability and will destroy local changes.

I thought it's only a few files and you don't care about merging (in
sudo), only about deploying a checkout, since you're removing the git dir.

> It looks like I'll be doing this in a hook.
> 
> BTW: I couldn't find "git tar", if it exists that might be the way for me...  Depending on what it would do.

Oh yeah. Done too much git work lately. I know I keep using "git help
foo" rather than "man foo", but this one is new :)

I just meant tar.

Michael
