From: John Tapsell <johnflux@gmail.com>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 12:37:42 +0000
Message-ID: <43d8ce650903130537r2459e1d2pef8fffc1c9b3fa5e@mail.gmail.com>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
	 <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
	 <alpine.DEB.1.00.0903131149200.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 13:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li6fW-0000VT-Tm
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 13:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZCMMhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 08:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZCMMhr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 08:37:47 -0400
Received: from mail-gx0-f167.google.com ([209.85.217.167]:35286 "EHLO
	mail-gx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZCMMhq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 08:37:46 -0400
Received: by gxk11 with SMTP id 11so2811107gxk.13
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 05:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BmfCiSFt6Eu73Y56sT1LWPEDbvN9JCeESRI/2DaX5aw=;
        b=hcVcgbT7MgvvjJ0npWkLM/ZlgWaB6BtF8ZPxAeT586c6Nxdo/miI1qdxmnR8IUJtZK
         1o0xDbQbSwt63F8GNOoCof3IE8VnD2iEXlf1tEphrPagFImGO8aOwwzC7kbTTIYot2w+
         XmwngFm8qLjcydrlEON/3zDVYsddUiq+vRv0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NFRZepTQS7GGRmyDyc4ebrKcfZOLjxlb+fBOrW+IRR1PVZhoWU2CNmcoNyi6wYdsFB
         9Bhnq6roJC6YcbpiupNgbQ88zcdkeqhM3GsGWYAYJmBrOLZzIESHAlh8CmK7IQiUWL17
         +8WxbovUeeRjb4WliLsxbpIRCxyDTSco/IVHQ=
Received: by 10.142.54.11 with SMTP id c11mr534438wfa.14.1236947862701; Fri, 
	13 Mar 2009 05:37:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903131149200.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113176>

2009/3/13 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Fri, 13 Mar 2009, John Tapsell wrote:
>
>> 2009/3/13 Peter Krefting <peter@softwolves.pp.se>:
>>
>> > Doing "git push remote" pushes all my local branches by default. I=
s
>> > there a way to set it to *not* do that, and (for this particular
>> > remote repository) just push the current branch?
>>
>> > Or failing that, not allow me to run "git push" without specifying=
 a
>> > branch?
>>
>> I've been pushing for this behaviour, and there was a patch a few da=
ys
>> ago to do this. =C2=A0I'm not sure if it is/will be committed.
>
> As Junio is a careful maintainer, he will not change anything radical
> which would piss of a lot of people _without_ a proper, long-term pla=
n
> that gives users a chance.
>
> I know, I once tried to push for something like that, and I am glad t=
hat
> Junio is too wise as to make Git unstable for existing users.

Understandable.  There were 6 patches, only the last one changes the
default.  Hopefully the first 5 will be applied and the 6 will
debated, then grudgingly applied :-)

John
