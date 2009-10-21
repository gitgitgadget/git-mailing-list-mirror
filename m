From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Finding a commit
Date: Wed, 21 Oct 2009 15:55:22 +0200
Message-ID: <9accb4400910210655i115686c5h2d38a885c1d56d2e@mail.gmail.com>
References: <4ADEF095.3020406@box.net>
	 <9accb4400910210530k75a763cbtbc9294d937de9242@mail.gmail.com>
	 <200910211437.39166.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Soham Mehta <soham@box.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Oct 21 15:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0bf0-0001mC-2C
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 15:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbZJUNzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 09:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbZJUNzT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 09:55:19 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37760 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZJUNzS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 09:55:18 -0400
Received: by fxm18 with SMTP id 18so7779819fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8if+lJu6YwRBWyA15GQdOX8dpYkaDa9RLK3PN2s/fH8=;
        b=AMI4wT9BCeoNOpNH84lGaROd/H8bmeG/MY5hlMxb+/iUcer4YEMdrPN1M3E+uTyc97
         43JUW4qXnalEppqqMo+K+/svYqjvniv4ECKO20xwJSu8L+9DCCR4Cc40QzW8Dr8wgTJa
         9QIl5BhyqTZiNnpm4qMnM7e8HGbFgDgpDdA20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oGwCK7+mfiugy5EgOTJMPh8algQkL8xlkWjnOEgSvouxKO5H6g3h8biw36dWHrgXbf
         VzCLDs31nJxVwkyFPQ0rZ7dW87d72Xf3mZ6fzI2IQpc7BN/0Y2BVElVIm+SVDhFYNdLK
         VDvzw+ZkcPumq3TyWa34Zh6C9H/zxbPGJBmI0=
Received: by 10.204.13.210 with SMTP id d18mr8056949bka.211.1256133322441; 
	Wed, 21 Oct 2009 06:55:22 -0700 (PDT)
In-Reply-To: <200910211437.39166.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130919>

On Wed, Oct 21, 2009 at 2:37 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> Commit -> Tree ---> Blob1, Blob2, Blob3
>>
>> Commit, Trees and Blobs are all identified by sha1
>> the commit should keep information on the author, the "parent"
>> commit(s) and so on..
>> the tree should just keep the "snapshot" of the data..
>>
>> so I think that if you search for the SHA-1 of the tree you should b=
e fine..
>
> Not if you really want to find out if X was cherry-picked into this
> repository, because the tree is the *final state* at that commit,
> which of course includes all preceding changes.
>
> So suppose you have two patches A.diff and B.diff introducing files o=
f
> the same name; then if you combine them into history as
>
> =C2=A0A -- B
>
> the tree state at B has both files, and hence is different from the
> tree state of B' in
>
> =C2=A0B' -- A'
>
> because there it only has the file B.

Yes... obviously...
the tree is the snapshot of a complete data set: so if you apply the
same patch to different data set you get different trees...
thanks for pointing it out.. :)

Regards,
Daniele
