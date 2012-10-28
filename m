From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: git push tags
Date: Sun, 28 Oct 2012 21:49:37 -0000
Organization: OPDS
Message-ID: <4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com><508D7628.10509@kdbg.org> <CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"git" <git@vger.kernel.org>
To: "Chris Rorvick" <chris@rorvick.com>, "Johannes Sixt" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:49:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSajq-0007Ip-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab2J1Vtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:49:32 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:29678 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756135Ab2J1Vtb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 17:49:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsMACqojVBcHl58/2dsb2JhbABEi1e2AAECgQaBCYIZBQEBBQgBAS4eAQEhCwIDBQIBAxUBAgklFAEEGgYHFwYBEggCAQIDAYd5uneLdYELCQsPLoQgYQOIJIVKmEiCbw
X-IronPort-AV: E=Sophos;i="4.80,667,1344207600"; 
   d="scan'208";a="403062381"
Received: from host-92-30-94-124.as13285.net (HELO PhilipOakley) ([92.30.94.124])
  by out1.ip03ir2.opaltelecom.net with SMTP; 28 Oct 2012 21:49:29 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208572>

From: "Chris Rorvick" <chris@rorvick.com> Sent: Sunday, October 28, 2012 
7:59 PM
> On Sun, Oct 28, 2012 at 1:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Tags are refs, just like branches. "Tags don't move" is just a
>> convention, and git doesn't even respect it (except possibly in one
>> place[1]). You can't reseat tags unless you use -f, which is exactly 
>> the
>> same with branches, which you can't reseat unless you use -f.
>>
>> [1] By default, git fetch does not fetch tags that it already has.
>
> Also, git checkout <tag> puts you on a detached HEAD.  This seems
> pretty significant with regard to Git respecting a "tags don't move"
> convention.

Surely the convention is the other way around. That is, it is branches 
that are _expected_ to move, hence unless you are checkout a branch 
(movable) you will be on a detached head at a fixed place/sha1 [aka not 
on a branch].

The checking out of a tag action doesn't make it more or less 
significant.

I think Angelo's original post should be reviewed to see if the issue 
can now be restated in a manner that shows up the implied conflict.

If I read it right it was where two users can tag two different commits 
with the same tag name [e.g. 'Release_V3.3'] and the last person to push 
wins, so anyone in the team can change what is to be the released 
version!

Philip

>
