From: "Jeremy Ramer" <jdramer@gmail.com>
Subject: Re: ls-files [Was: Re: Fwd: git status options feature suggestion]
Date: Thu, 9 Oct 2008 16:13:07 -0600
Message-ID: <b9fd99020810091513j21d37e0y94a387cd6d72bd2@mail.gmail.com>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com>
	 <20081009061136.GA24288@coredump.intra.peff.net>
	 <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com>
	 <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com>
	 <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de>
	 <m3ej2p4g3r.fsf_-_@lugabout.jhcloos.org>
	 <20081009214118.GZ8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "James Cloos" <cloos@jhcloos.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Caleb Cushing" <xenoterracide@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 00:14:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko3m2-0006UW-RB
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 00:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYJIWNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 18:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbYJIWNK
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 18:13:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:48503 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbYJIWNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 18:13:09 -0400
Received: by qw-out-2122.google.com with SMTP id 3so80748qwe.37
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XgA7+mQPG5Vk/5t0jFFSCQy7DoIPbYHD1P+pFlhyuJg=;
        b=OXeG2FmTll8Cv9tyC1tzkstLxfjYrYI8R9tO1TEVW5FxyHvk7BWnRyI0fnSzXIU0lV
         vaUOqtMfVT29490Pb0Tt9Ortg85bFpfYw0C5GjK9KkiA29bO87ujgotsQ5nGGnLurE5w
         QEBPB//cQV+1p14vsaev6W8p1EL6vGSKhyeLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EC/z/ESl6L4kDwDzGo6n/414v76sWbe0M3heyx0o2akfx9/lIcY66FPrR6kZATnxqP
         MomOKgkRy9wRsNIzHdb5kCmaRGe8PzJynjLlW3Wn4++5ZTkYemIt+mPEe5IQ3w4CQ7rK
         z7yskIswa/QQduIpFiG1btZ0kbvY6zgG8Yne0=
Received: by 10.214.10.4 with SMTP id 4mr1131872qaj.14.1223590387263;
        Thu, 09 Oct 2008 15:13:07 -0700 (PDT)
Received: by 10.214.181.15 with HTTP; Thu, 9 Oct 2008 15:13:07 -0700 (PDT)
In-Reply-To: <20081009214118.GZ8203@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97898>

On Thu, Oct 9, 2008 at 3:41 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> James Cloos <cloos@jhcloos.com> wrote:
>> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >> > How about "git ls-files -o"?
>> >>
>> >> doh... hadn't even heard of that command.
>>
>> Johannes> Which is good!  As ls-files is listed as plumbing.
>> Johannes> Users should not need to call ls-files,
>>
>> That is a bug, then.  ls-files is one of the more important user-level
>> commands in git.
>>
>> It is vastly more efficient than find(1) or a --recursive call to
>> grep(1).
>
> How about using "git grep" then?  No need for ls-files...

I use git-grep for searching the contents of files in the repo, but it
seems to me that git ls-files is necessary for quickly parsing the
file names themselves.

>
> --
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
