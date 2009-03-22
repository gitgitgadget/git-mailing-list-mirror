From: James Pickens <jepicken@gmail.com>
Subject: Re: Disallow amending published commits?
Date: Sat, 21 Mar 2009 21:09:43 -0700
Message-ID: <885649360903212109v316f441fvea3f498e91c0059e@mail.gmail.com>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
	 <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
	 <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com>
	 <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 05:11:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlF1n-0000fE-DX
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 05:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbZCVEJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 00:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbZCVEJq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 00:09:46 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:17175 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZCVEJp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 00:09:45 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2232739wff.4
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HgiRt7Zx4daPiAZ972Oc/PrToEqXSWt9YjH5k1VVEz4=;
        b=GMInPBKvY5iggk7zcrYbhDORJi437Qpv/tZiHoRAoxE0bp3nZFWZGkImdKcs75tKfc
         gRo/aHgGw6acVWjmUrid6KeqAXVZCao1GaKKXTH+RtPu+YSyvYGzKrjdNulELMR0B/BO
         VBLTW4qqN2NzzzvANcA8GrhNOqfn6n+fZOAVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mhG5T47wu8wTPr5Rh+ilTriUEzEHq9NBKDZdQ/hrBTAdTsQHZtZ7X6AXSdFLXi5JDE
         kS8URFAaGwVvOqFOkNY/N6JLLwzae7ieOrT8Fz6nh5zZgqZHF/wXIv3yvzhRwOVE9vFV
         mJ6TA/0pwWyI0T1r07GPV3X0a2SrAR/JhhH6Y=
Received: by 10.115.18.3 with SMTP id v3mr3751477wai.141.1237694983194; Sat, 
	21 Mar 2009 21:09:43 -0700 (PDT)
In-Reply-To: <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114112>

On Sat, Mar 21, 2009, Peter Harris <git@peter.is-a-geek.org> wrote:
> Okay. So in that workflow, you won't ever lose the original history.
>
> If someone creates an alternate history that differs only slightly,
> odds are your continuous integration server will get a merge conflict.
> Presumably it will reject the pull request at that point.
>
> If it doesn't conflict, you'll have both alternate histories. So
> nothing is lost.
>
> Maybe I'm misunderstanding the question? (That is definitely possible.
> The idea that a person would go to the effort of rewriting history -
> especially when that person knows the original history would stay put
> - often enough to cause problems is like suggesting that a person
> might write log messages in latin. I'm having a hard time envisioning
> the need to write down a social rule about it, much less the need to
> write an AI to try to detect it.)

I think you understood the question perfectly, and your comments all make
sense.  Perhaps I'm just being paranoid and this won't be a problem at all.

A bit of background might help explain my paranoia: I'm about to pilot Git
on a fairly large project, where none of the users have Git experience, and
many of them don't have much experience with any other version control
system either.  I had to fight hard to get this pilot approved, and a lot
of people will be watching to see how it goes, so I'm trying to do anything
I can to make sure it will be successful.

James
