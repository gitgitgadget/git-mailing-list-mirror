From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git branch documentation improvements
Date: Fri, 7 May 2010 18:40:06 +1000
Message-ID: <m2t2cfc40321005070140m85d51db7id75b5b897f2acc00@mail.gmail.com>
References: <201005070024.41172.ahartmetz@gmail.com>
	 <4BE3BF2F.8050903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Hartmetz <ahartmetz@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 07 10:40:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAJ6W-0002LW-Uu
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 10:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab0EGIkJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 04:40:09 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:34451 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab0EGIkH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 04:40:07 -0400
Received: by qyk13 with SMTP id 13so1227458qyk.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hopEMeANdsZZlpL1hTGryJ9H0goP8ZsL2vkdNY8xBQ0=;
        b=CyuYKFoKSYPw7RiSgK0vjbINMDq6295XMwMajvUYe/lim7ybDp6y3oGG4U+Y5GRnUK
         xDd1G4260DvkSbDP5aL9e/fjFo/f1czGbhxAOVl/9qSPDEdzj89mwAKtnkP4JV7UbaLr
         P7InbCAO4H3In5xSZDIehRAtSYdHuyYvUXGz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cJXqE07skKNHrzwC5OnZLUj4sZSgEs3mIuorg7vzdWXD/M9Ld7sanRCOX6mL4OfrlG
         KyhmNap2+x2yY8lX0Lsbb0RQeswvggmsDNAUxyQ9rcaimj03xJvJMpIaIPbFklDM8wqZ
         5dUrE4a1MfbyywdkfS7DK79aFgB1ygKmrlHfc=
Received: by 10.229.218.211 with SMTP id hr19mr1774619qcb.92.1273221606520; 
	Fri, 07 May 2010 01:40:06 -0700 (PDT)
Received: by 10.229.214.80 with HTTP; Fri, 7 May 2010 01:40:06 -0700 (PDT)
In-Reply-To: <4BE3BF2F.8050903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146529>

My minor quibble with start-point is that the naive user may assume
that, like CVS or SVN, git has some persistent notion of a "start
point".

In reality, git only tracks heads. A term like "head-commit" is, IMO,
more precise than "start-point" and does not potentially convey the
false notion that git knows or cares about the point at which a branch
was "started".

jon.

On Fri, May 7, 2010 at 5:20 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Am 5/7/2010 0:24, schrieb Andreas Hartmetz:
>> The most significant change is renaming <start-point> (or is it
>> <startpoint>...) to <branch-head> because even I as a relative begin=
ner know
>> that a branch is defined by its (movable) head, and <start-point> *d=
oes*
>> actually specify the new branch head if I'm not mistaken.
>
> But what is wrong with "start-point"? It precisely conveys the meanin=
g of
> the parameter.
>
> -- Hannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
