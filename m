From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Manually decoding a git object
Date: Mon, 20 Feb 2012 08:19:44 -0000
Organization: OPDS
Message-ID: <B268B28A80B446BBADED9B3B6BA4B205@PhilipOakley>
References: <1329312140-24089-1-git-send-email-pclouds@gmail.com><1329624946-32173-1-git-send-email-pclouds@gmail.com><A716A27D407F401DAAC373027D5CFF2A@PhilipOakley> <CAMocUqRNNXpGOJ2ZG8bWpkieKkVfoo0=Lkevjw+E3Tssw68Hwg@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "??" <xudifsd@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 09:19:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzOTW-0003bb-Gr
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 09:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab2BTITo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 03:19:44 -0500
Received: from smtp2go.com ([207.58.142.213]:40800 "EHLO smtp2go.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab2BTITn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 03:19:43 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191050>

From: "??" <xudifsd@gmail.com> Sent: Monday, February 20, 2012 4:45 AM
> 2012/2/20 Philip Oakley <philipoakley@iee.org>:
>> If I have a renamed file which is a git object, such a "Git_Object", was
>> 8c-something-or-other, what is the easiest way of examining / decoding /
>> recreating the original file (either as its sha1, or a cat-file).
>>
> I don't think I fully understood what you mean, I assume you just move
> an object file from $GIT_DIR/objects/ to somewhere and rename it,
> let's call it "obj", so if you want to exam its content you can just
> simply call "git cat-file -p obj". And you can also use "git cat-file
> -t obj" to exam its object type. If it's a blob you can use "git
> cat-file -p obj > original" to recreate it, else it's meaningless to
> recreate it.

When I tried it from my home directory (not in a git directory):
$ git cat-file -p Git-Object
fatal: Not a git repository (or any of the parent directories): .git

Because its sha1 isn't yet known I can't put it into the correct 
.git/objects/xx/ subdirectory of an fresh 'git init', and I have located an 
unzip programme that will take the plain git object and decode it - they all 
expect archives.

I've described the background use-case at 
http://stackoverflow.com/questions/9341278/how-to-track-the-git-directory-in-git-in-its-own-store - 
the edit links to a typical corporate scenario.

Even just locating a zlib implementation that simply confirms the file 
stream is compressesd and deflates it would be a start.
Philip
