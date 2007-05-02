From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: problem using git on cygwin
Date: Wed, 02 May 2007 14:55:28 +0300
Organization: Private
Message-ID: <abwne8y7.fsf@cante.net>
References: <ace3f33d0704292325t6ab16075rbdeac40a437920e8@mail.gmail.com>
	<Pine.LNX.4.64.0704301343020.29859@racer.site>
	<ace3f33d0705012104r3cf0b99ayb2ec2a69833e6ea1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 14:45:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjECx-0007XU-83
	for gcvg-git@gmane.org; Wed, 02 May 2007 14:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993095AbXEBMpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 08:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993096AbXEBMpU
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 08:45:20 -0400
Received: from main.gmane.org ([80.91.229.2]:40260 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993095AbXEBMpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 08:45:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HjDux-0003el-KU
	for git@vger.kernel.org; Wed, 02 May 2007 14:26:48 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 14:26:47 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 May 2007 14:26:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.3 (windows-nt)
Cancel-Lock: sha1:aKuMxmD2T682sVREc4SlqRiEezg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46017>

"srinivas naga vutukuri" <srinivas.vutukuri@gmail.com> writes:

> Hi,
>
> On 4/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Mon, 30 Apr 2007, srinivas naga vutukuri wrote:
>>
>> > $ git add project/test.c
>> > error: bad index file sha1 signature
>> > fatal: index file corrupt
>>
>> I could imagine that you do not have "binary mode" default for opening
>> files.
>
>       i do't think it is in binary mode when opening the files. I am
> used vim to create a new file and editing through that. And also am
> used file format (set ff=unix).

I think Johannes meant Cygwn filesystem mount attributes. Please run

    $ mount

And you should see "binmode". Here are examples:

    D:\cygwin on / type system (binmode)
    D:\cygwin\bin on /usr/bin type system (binmode)
    D:\cygwin\lib on /usr/lib type system (binmode)
    E:\data\src on /usr/src type system (binmode)

If not, you need to remount directories with "-b" option. See man
mount(1)

Jari
