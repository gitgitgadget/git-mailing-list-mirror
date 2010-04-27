From: Chris Packham <judge.packham@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Tue, 27 Apr 2010 10:13:51 -0700
Message-ID: <g2ia038bef51004271013i4e085b31u7ee075bf57bc86a1@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com>
	 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	 <4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
	 <4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
	 <4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>
	 <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
	 <4BD651C6.5050501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 19:14:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6oMN-0001BH-0B
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 19:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab0D0RNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 13:13:54 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:60240 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0D0RNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 13:13:53 -0400
Received: by qyk9 with SMTP id 9so19656687qyk.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=BmIpdGsC8RyJWl3XTwN401j4oWhCrMOEDQazWx0lP7M=;
        b=SMQg4ajGLgVhDnhMw4mxrHbaOuZJyNUym6ELRUrPPW5mlIn1FuDoMx+PDnJRkr3LGG
         ajukGKi2OmWGISuqVnuychbWH1trYPCKdl7OURm4AbbHauWkvwX7YSmv5TOrqEofCHQ2
         zmMZp6XHBUlLutkY9WmJxbdUUdpm5ZCsPginQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=H5YC2KWRPo50PVqYG9j3lrWJKoXYPVE3+5W7z4d0AYCgEVWTC1U4Fqh/sBiZFAPaA3
         6n2GNo4evyOcC/TUNuS7vXhvk+gH+Y3CIehmPfwDuG0+Po3qjFfwTaxFfrWbNbdXffFN
         gfHBHPkYIU0w+1BFlP4zm5gDD5hIw1Gwda+n4=
Received: by 10.229.91.16 with SMTP id k16mr7699706qcm.40.1272388431803; Tue, 
	27 Apr 2010 10:13:51 -0700 (PDT)
Received: by 10.229.11.77 with HTTP; Tue, 27 Apr 2010 10:13:51 -0700 (PDT)
In-Reply-To: <4BD651C6.5050501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145931>

On Mon, Apr 26, 2010 at 7:53 PM, Gabriel Filion <lelutin@gmail.com> wrote:
> Hello,
>
> On 2010-04-26 17:41, Chris Packham wrote:
>> How far did git-bzr or git-remote-bzr get?
>>
>
> I unfortunately haven't had much time to fiddle with this. Having a full
> time job doesn't give me much space for experiences :( And on my free
> time, I've been a bit busy with one of my projects..

Fair enough. My day job tends to suck up most of the time I want to
spend in front of a computer too.

> I've tried simply "plugging in" the bzr-fastimport plugin to do the
> communication part. They already implement output similar to what
> git-fastimport expects. I was stuck on the part where you have to
> specify "marks" files, and about where to place them, so I left it there
> for now.
>
> I'll try and work on this pretty soon, but since I'm doing this on spare
> time, any help would be welcome. Maybe the good thing to do would be to
> put up a page somewhere with a mini-roadmap and the info needed/the info
> that was found out?
> By using bzr fast-import, the whole thing shouldn't take too long.

I'm probably unqualified to help, not being familiar with bzr at all,
but if you want a monkey to write test cases I can probably do that.

>> [1] http://github.com/kfish/git-bzr/blob/master/README
>
> This script needs you to install bazaar and the bzr "fast-import"
> plugin. Normally the fast-export command is implemented by it. You need
> a rather up-to-date version, though.
> I've found this script to work mostly for pulling in changes from bzr
> into git. Pushing has proven to be from slow to non-functional.

Actually I can probably contribute a snippet for your README file on
how to install the required plugin if that would be helpful. It took
me some fiddling an experimentation to work it out even after reading
the bazzar documentation.

> As for the interest in this: mine is in using only one tool to do the
> work right and not having to switch from using 3 vcs tools (the current
> situation at work is 2 -- git and svn -- but soon bzr will come in). And
> for the one tool, I'd like to choose git.
> stupid reason? probably. but I've tried bzr and I don't like it.

My interest was purely around updating patches one project that we use
that happens to use bazaar. Normally most things we do are either in
git or built from tarballs + patches.
