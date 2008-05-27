From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 15:37:49 +0200
Message-ID: <8aa486160805270637m3fc640bfr9fa51eb917460e5c@mail.gmail.com>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
	 <alpine.DEB.1.00.0805271151430.30431@racer>
	 <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
	 <alpine.DEB.1.00.0805271411520.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 27 15:38:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0zO4-0002Tg-JS
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757627AbYE0Nhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2008 09:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757622AbYE0Nhy
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:37:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:22984 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757627AbYE0Nhx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2008 09:37:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1526890fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 06:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nGlyWY39ZjuB1FIopcmTO8Rabg5B4IRaLCluuAzIcJU=;
        b=DxX1QfeokVd8L+PzsxcN/xanZqA4weQAJjZGV0uix+fkh3XFFobWWSpgb1ARUIm55egYRl3aM692jW0bflzgfWXIpK4rTreN7CfiKSKheHuhQhqlePA1CBuTe/wD/A2yTi2SfRG8eLD7uE8WoX4qopr4sD50fykCopqsMQgzmiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ow7jqdaH3HJqjAR7Hsls1P2QXJge4UPUejUsNdy+Eh6lkdOi6+Zh/lO+SPjvdMAA7+2gTUrt2lyOBwNWfNPVcIJH1lo6Xn0VkjB4wzuBEa3OU3eCEIS14BelTKgZ3CFG0JW6nLLKhfTglgPCzVR2vzMBmk3zg2D/1OIwRiTwgy8=
Received: by 10.86.89.1 with SMTP id m1mr3131958fgb.45.1211895469447;
        Tue, 27 May 2008 06:37:49 -0700 (PDT)
Received: by 10.86.27.11 with HTTP; Tue, 27 May 2008 06:37:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805271411520.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83014>

On Tue, May 27, 2008 at 3:12 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 27 May 2008, Santi B=E9jar wrote:
>
>> On Tue, May 27, 2008 at 12:53 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Tue, 27 May 2008, Santi B=E9jar wrote:
>> >
>> >> In case you don't know the next step, if it is "git commit", "git
>> >> commit --amend", "git rebase --continue" or something else.
>> >
>> > We had a patch similar to this already, but I think that the right
>> > approach is _not_ to teach the single commands to explain their st=
ate,
>> > but to make a new script guessing the current state.
>>
>> I think it belongs to each command to know the state, but I have no
>> problem with the single command approach.
>>
>> >  AFAIR we have something like that in the completions already, as =
an
>> > (optional) prompt.
>>
>> Thanks. And they do it a bit different, I'll use it if it is better =
than
>> mine.
>>
>> >
>> > However, I think it would make sense to push for that
>> > .dotest,.git/.dotest-merge -> .git/rebase change _before_ having
>> > anything like git-whazzup.sh.
>>
>> That's a problem of the single command approach.
>
> Sure it is.  But cluttering up the commands for something that is not
> really proven to be wanted by many is IMO inferior.

This is an argument against git-whatzzup.sh in general. Point taken.

Maybe you are right, but I remember that this is something some people
has asked in this list a number of times.

Moreover, this could be integrated in "git status".

Santi
