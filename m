From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: Can git pull from a mercurial repository?
Date: Tue, 25 Sep 2012 14:56:09 +0200
Message-ID: <k3sepn$f1e$1@ger.gmane.org>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se> <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <k3rnak$qp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 16:24:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGW3c-0001EC-6v
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 16:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab2IYOYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 10:24:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:40194 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754429Ab2IYOYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 10:24:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TGW3S-0001A5-Iz
	for git@vger.kernel.org; Tue, 25 Sep 2012 16:24:06 +0200
Received: from dsdf-4db53c2e.pool.mediaways.net ([77.181.60.46])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 16:24:06 +0200
Received: from jojo by dsdf-4db53c2e.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 16:24:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4db53c2e.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206358>

Gelonida N wrote:
> On 09/18/2012 02:40 PM, Joachim Schmitz wrote:
>>> From: Andreas Ericsson [mailto:ae@op5.se]
>>> Sent: Tuesday, September 18, 2012 1:46 PM
>>> To: Joachim Schmitz
>>> Cc: git@vger.kernel.org
>>> Subject: Re: Can git pull from a mercurial repository?
>>>
>>> On 09/18/2012 01:22 PM, Joachim Schmitz wrote:
>>>> Is there an easy way to get git to clone/pull from a Mercurial
>>>> repository?
>>>
>>> Yes. Google "git remote helpers" and you'll most likely find it.
>>
>> Well, I found a few. No idea how to get them to work though (so far
>> for the 'easy' part of my question) It seems
>> https://github.com/rfk/git-remote-hg requires Python 2.5
>> (and I only have 2.4), also I have no idea how to get it installed
>> https://github.com/SRabbelier/git is 3 years old, apparently never
>> made it into git, guess for a reason?  Then I found
>> https://github.com/fingolfin/git/commits/remote-hg,
>> looks very confusing to me...
>
> Install a newer python and hg
> Are you really sure, that python 2.5 doesn't exist for your machine?

Yes, I am sure. Python 2.4 had been ported more than 5 years ago by a former
workmate, otherwise we wouldn't even have that.

> Most non embedded devices should  offer python 2.5 or newer
> (for some distros you just have to add 'alternative' repositories)

For this platform (HP NonStop) basically nothing is available from any
repository on the web but ITUGLIB (http://ituglib.connect-community.org) and
that's the machine I'm working on/for ;-)

We're currently trying to port Python-2.7, but it ain't easy...

Bye, Jojo
