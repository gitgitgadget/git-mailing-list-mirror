From: "norbert.nemec" <norbert.nemec@native-instruments.de>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 13:10:06 +0100
Message-ID: <jgduf8$mm3$1@dough.gmane.org>
References: <jgdgcv$h8n$1@dough.gmane.org> <jgdn5j$v4g$1@dough.gmane.org> <87haz97c2k.fsf@thomas.inf.ethz.ch> <4F2A70DA.6020107@native-instruments.de> <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 13:10:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsvV0-0002iT-PE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 13:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab2BBMKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 07:10:41 -0500
Received: from plane.gmane.org ([80.91.229.3]:42859 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904Ab2BBMKe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 07:10:34 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RsvUn-0002ck-CT
	for git@vger.kernel.org; Thu, 02 Feb 2012 13:10:33 +0100
Received: from 46.231.181.199 ([46.231.181.199])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 13:10:33 +0100
Received: from norbert.nemec by 46.231.181.199 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 13:10:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 46.231.181.199
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CAFfmPPMc1V97OPHyrZp+p4YUek1c6fCncyj0s1YU9xjxQBCsDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189634>

Am 02.02.12 12:41, schrieb David Barr:
> On Thu, Feb 2, 2012 at 10:17 PM, Norbert Nemec
> <norbert.nemec@native-instruments.de>  wrote:
>> To be yet more precise:
>>
>> My complaint is that you need this kind of sledge-hammer solutions to
>> analyze the situation. I, as an semi-expert with git did manage to find the
>> problem without even having to resort to bisect or manually redoing the
>> merge. My complaint is about the perspective of the medium-experienced user
>> who is completely puzzled by the fact that a
>> "git log<filename>" silently skips the critical merge commit.
>
> Do the -c --cc or -m flags for git log help in this case?
> They alter the way merge diffs are presented, as described under Diff Formatting
> in the git-log(1)  man page.

Indeed, these help somewhat. This way, the changes are not hidden, but 
instead lost in the multitude of trivially-resolved conflicts...
