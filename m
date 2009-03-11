From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: setting up tracking on push
Date: Tue, 10 Mar 2009 23:40:29 -0400
Message-ID: <76718490903102040m6bfb45f1xfd7ff3d53a79ef5b@mail.gmail.com>
References: <alpine.DEB.1.00.0903061144480.10279@pacific.mpi-cbg.de>
	 <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	 <76718490903060743m425c2d55n6e8737c893c936e8@mail.gmail.com>
	 <87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	 <20090310230939.GB14083@sigio.peff.net>
	 <76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	 <20090311020409.GA31365@coredump.intra.peff.net>
	 <76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
	 <20090311030604.GA3044@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Branchaud <marcnarc@xiplink.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhFM9-000684-EJ
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 04:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbZCKDkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2009 23:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbZCKDkd
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 23:40:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:3477 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbZCKDkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 23:40:31 -0400
Received: by rv-out-0506.google.com with SMTP id g9so2772121rvb.5
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 20:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Z59+zTGx0Uapv2a8XTMthJ8BhZYCNVxRSsFySL9KWzQ=;
        b=gLqzWGDNMeOUJ4NyY+pfBoVWRKy6z/FZ6TXhLyRO/Qu7XeKAoXhTZQTMfD59BjWYyw
         7jmu8DyWPOx0flawwBLoGaQeU+npXbbnUfHS/lKeg5h/2MBvhvA1k67qWE/DjRpbQvYu
         kp9fD+xV1Vz9PagbXzd6vI/o0Tikr5zNX24wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VSzaSfp7EC3WyMyc85zcf57/g1ssXgZh26oFAXGpZ9vxjkA0HTdF4tV19yax+oc241
         ZmvIXbaKY7oylOexbFFoL3URlhgqddjTGJJy5cwWjrnc89uR9JwAKI3p3gbz5xK12RAV
         fto76vlYhNh0Q3f9Oqq26hEHo0oKZgZsN/qqM=
Received: by 10.141.71.14 with SMTP id y14mr4125025rvk.131.1236742829966; Tue, 
	10 Mar 2009 20:40:29 -0700 (PDT)
In-Reply-To: <20090311030604.GA3044@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112874>

On Tue, Mar 10, 2009 at 11:06 PM, Jeff King <peff@peff.net> wrote:
> If "-u" is supposed to be a general mode, then what does it mean to s=
ay:
>
> =C2=A0git branch -u foo

Nothing, that would emit the usage message since it's not valid.

> ? I would expect that to "update" foo. But if --track is given, then =
it
> means "update HEAD to track foo".

Maybe branch isn't the best place to put this feature, but it's where
I'd look. I'm not married to -u, it was just the first thing that came
to mind. But I still can't think of anything better.

j.
