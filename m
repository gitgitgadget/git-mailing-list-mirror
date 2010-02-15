From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Walking commits from the first
Date: Tue, 16 Feb 2010 01:20:12 +1100
Message-ID: <2cfc40321002150620i7e290c10pfc978ec9754a914a@mail.gmail.com>
References: <e72faaa81002142037g7f5f518erb9fefbb239124bc5@mail.gmail.com>
	 <e72faaa81002142039h5531a19y354d24e595295bb1@mail.gmail.com>
	 <20100215080646.GD5347@coredump.intra.peff.net>
	 <e72faaa81002150333r4eb27a15t7de6b3c820eb4bc2@mail.gmail.com>
	 <2cfc40321002150605l4de9d970t919ee56d7a3d697e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 15:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh1oD-0003ot-Se
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 15:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab0BOOUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 09:20:14 -0500
Received: from mail-pz0-f197.google.com ([209.85.222.197]:33387 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244Ab0BOOUN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 09:20:13 -0500
Received: by pzk35 with SMTP id 35so252537pzk.33
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 06:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yWRWK8EiQdHgLsnnYpYH8dHMk6WnTqRHLTQ6U/4ahV4=;
        b=P9530q5JIIAo12AR3nw3mtJzYW7R1i9yroGS2DwCOl3oIE/dpugFTkodyiZxZBTsEe
         ShPOJrYYVhwOmngwN6UMODbwXpq/WOPTSW1X6JjZv+ysl+ziTTsg2fZLR35kCZ7HPuVl
         FjKqDdYjzWxD9CjlZPfXtzcS+FRNl/KkA1WrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ac2Tk+jebPGlXipqCdrTbSqsaXccfkWn7ZW1qaJCQIe5KEpyQRskszELIlRP6zEhZV
         K9aLfZE/OSrJu+D7XVsK67vEuY5Zc88qGB0E6qkhpeUMVbBjg/RqMNlMngIyAGSg/eYi
         33LykcIZ82Nuvcz1Kw94tlmnxPGJdZpAasyIQ=
Received: by 10.115.101.40 with SMTP id d40mr3506696wam.95.1266243612549; Mon, 
	15 Feb 2010 06:20:12 -0800 (PST)
In-Reply-To: <2cfc40321002150605l4de9d970t919ee56d7a3d697e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140011>

On Tue, Feb 16, 2010 at 1:05 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Mon, Feb 15, 2010 at 10:33 PM, Pavan Kumar Sunkara
>
> The history is useful for understanding how something came to be -
> commits followed backwards down one merge branch will tend to have
> some semantic relationship to each other unless your committers are o=
n
> acid. Trying to comprehend the evolution of history by replaying it
> forwards and keeping track of n parallel threads of development as
> they diverge seems like an unnecessarily complicated way of trying to
> comprehend the world.
>

That said, of course, git once had an option to rev-list that I
contributed (--merge-order) that attempted to create the best possible
linear history by performing a topological sort that minimised the
number of "jumps" between semantically unrelated commits in the linear
order. The algorithm was kind of cool (based as it was on a
conservation of mass analogy), but it eventually got stripped out for
various eminently understandable reasons (like no-one was using it, I
wasn't maintaining it and it was the only remaining use of a
dependency on the open-ssl infinite precision integer arithmetic
libraries that complicated the build).

git rev-list --topo-order will do a topological sort that guarantees
that you never visit a commit before visiting all its ancestors.


> jon.
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
