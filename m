From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 16:13:55 -0500
Message-ID: <AANLkTik2+e+9M73RdPT5xha0=QGxD1cVfmLih=bDtCTU@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 22:14:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL0Bx-0001hW-HL
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 22:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861Ab0KWVOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 16:14:16 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45566 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab0KWVOQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 16:14:16 -0500
Received: by pva4 with SMTP id 4so643974pva.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 13:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=W1IopyZfBQUbaDgjXWIm6OSaXPz+lGiWnFZxdOQ2DUo=;
        b=jiKmnsEMyx4sokV9ZcPqnuGKG9cDkwJ3t4DswLT6V/n7OIscoDOE0reBHv7ROgCLQD
         XH0xQ/P0DUWbcoumPnaB8eu/isGwYhvAAMZcR/77V5AHVEnn9KjxSUfWtROYWKcMvTqj
         5SREdnUAUDW/H89cwZqy9BOY3jjyhZNW2QCqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=I4ih6Fdbm212MtB4lZgdLVZ6IDDo8Zhbf66prZl1dvsywfEBSjLt7Z8ZwaY9O7f2ck
         KPAFwaSfrVao7y7nN4nqitbIPComyOCn8HGHXqObdu5u9YIYGWcFVjytDpTbTIZ7JbBN
         5WDM9I7UbEwDZiZBl4a3uckEYlzdKlWa8BkkY=
Received: by 10.231.39.205 with SMTP id h13mr8722836ibe.148.1290546855284;
 Tue, 23 Nov 2010 13:14:15 -0800 (PST)
Received: by 10.231.35.203 with HTTP; Tue, 23 Nov 2010 13:13:55 -0800 (PST)
In-Reply-To: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162028>

On Tue, Nov 23, 2010 at 2:08 PM, Dun Peal <dunpealer@gmail.com> wrote:
> However, after a reboot (of all things), `git status` latency
> skyrockets to 14-15s, making the repo unusable.

A reboot clears your cache. Reboot and time the first and second run
of git status.

The first one should be slow (due to cold cache), the second one
should be roughly as fast as right after a clone.

If it's not, more debugging may be neeed. But always take your timings
on a well seeded ('hot') cache.

cheers,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
