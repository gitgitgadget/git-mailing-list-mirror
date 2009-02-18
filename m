From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Best CI Server for Git?
Date: Wed, 18 Feb 2009 11:47:11 -0500
Message-ID: <c115fd3c0902180847p8addb28p485618322d0e5806@mail.gmail.com>
References: <c115fd3c0902021258i61a04f74u481ba66c645fe8f5@mail.gmail.com>
	 <1c5969370902021642v4e8d93djd22d5caa4aa9d1a9@mail.gmail.com>
	 <c115fd3c0902041123j4a16d666r6d1fbb9917184b2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 17:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZpbF-0005Qu-Va
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 17:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbZBRQrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 11:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbZBRQrN
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 11:47:13 -0500
Received: from mail-gx0-f163.google.com ([209.85.217.163]:33045 "EHLO
	mail-gx0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbZBRQrN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 11:47:13 -0500
Received: by gxk7 with SMTP id 7so2820036gxk.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 08:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DzI2Eeg1OPNDt1lI4QgKkSIQPAE6THqqplaCp3NnHRI=;
        b=k4bkPYO9qy9gUtrOyqGYiTFRiGCZpRv4YB7/2VwXvP+bRvQ97ZZwkQ3pOb/w+aSDts
         Xh2Zx3oOkEZSkOt203fVAlX9wyLDs9qIFfkQwHQ2wC3VxWSQKQzZQfTkddJ9Abc10jiO
         0N5qcmbOgXnQ6kJ77Qkotzc6X9UWw2cz+qEe4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xmUHs6ZevPhPICsIifgyVEws30/rw5YC9ejHKuhwBHS2nTBhBqz7lrNpBi2r+jMDhs
         cnZMJNTU0C2DyvgPM7MvLviEYUpmK6c1N1lGXImRH/EOiqR5vM0PQFbYIqJxwlJYrJGE
         dkLA28gPVMGcN6Dkx0vhrIjBCmKoJWS0TRrAg=
Received: by 10.100.254.15 with SMTP id b15mr10016563ani.35.1234975631231; 
	Wed, 18 Feb 2009 08:47:11 -0800 (PST)
In-Reply-To: <c115fd3c0902041123j4a16d666r6d1fbb9917184b2a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110556>

Trying to revive this topic a bit.  I'm sure some people are using
Hudson w/ Git.  Could anyone give me specific tips RE specific
versions of Hudson, Git, Plugins, platform, etc.?

Any help would be greatly appreciated.  Unfortunately, Hudson working
w/ Git has become quite a sticking point so if I can't get this
working we'll be stuck going back to Subversion, which I'm loathe to
do.

Thanks in advance!

On Wed, Feb 4, 2009 at 2:23 PM, Tim Visher <tim.visher@gmail.com> wrote:
> On Mon, Feb 2, 2009 at 7:42 PM, Matt Graham <mdg149@gmail.com> wrote:
>
>> Hudson leaves a fair amount to be implemented by plug-ins, so not
>> being installed out of the box doesn't really imply bad.  I would say
>> that there are more significant differences between Hudson and Cruise
>> Control than how they integrate with Git.
>
> Makes sense.
>
>> We are currently switching from Cruise Control to Hudson for reasons
>> related to ease of use.
>
> Would you mind being a little more specific?  The basics of what I've
> heard is that Cruise Control is ultimately much more flexible and
> capable, but that Hudson beats it hands down regarding usability and
> UI.  What specific issues had your team come up against?
>
>> Here is another hudson/git plugin.  It may not be quite as official
>> but addresses issues people have had with the more official one:
>> http://github.com/stephenh/hudson-git2
>
> I remember when this was announced.  Unfortunately, I can't find a
> clear comparison of the two.  I heard in a recent thread on here that
> at least some of the problems being answered by hudson-git2 have been
> cleaned up in the latest version of the official plug-in.  Is it still
> the case that there are problems in the official one that are fixed in
> Stephen's?
>
> Thanks so much for your help! :)
>
> --
>
> In Christ,
>
> Timmy V.
>
> http://burningones.com/
> http://five.sentenc.es/ - Spend less time on e-mail
>



-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
