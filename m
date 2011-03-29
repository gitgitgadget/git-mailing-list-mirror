From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: Re: how to squash two commits into only one
Date: Tue, 29 Mar 2011 16:24:55 +0800
Message-ID: <AANLkTin-0cBa293CQSf4kwMUG=w2j5zkSz1oBDhNqaNe@mail.gmail.com>
References: <AANLkTi=B37GABBc-YWfJN29Mh0kx4Tn8KenD5dJFo9j1@mail.gmail.com>
	<AANLkTi=5e4WUuZHcEJD50yJTw2eyYN_dN1S_7z62qy88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Tue Mar 29 10:25:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4UEu-0004US-Ps
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 10:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab1C2IY5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 04:24:57 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:56474 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1C2IY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 04:24:56 -0400
Received: by qyg14 with SMTP id 14so2811043qyg.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JvaTLSDaPlaPjahQNlvH8zYZeMq96DlWuv41FsUZKwY=;
        b=K20x7WuLLsEElbqlmgmRtdd6qzK4A+NRyyOqMflQtFeKW6ui6X1fojl+igwaquvVaN
         GahNIehl1t3/ECU5mOMrSkh+zn/WiLZyf0E9m7dwr+iXGg4dSlqSUq4EAy6gLZjGKjF6
         XYnQtkmTHDAiDv4vMi3OiHD+XdE/42FXpg0+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XfU4M+e2uhm9M7lQ+e0cMBkMTob4e3L+Bt6ZLovyuc3IXlUXpw3BGb4+Uw4bn0wURh
         5uJMQ15dK1cpJZdyt7oWq2pZgsU28zykSyFej6pPe5tqP6eOSlGW8+DFmg9A2LKNaSFb
         SOMRUAZzHrjKCNf7tgx/pwEks/S2r0V2ozmR8=
Received: by 10.229.40.213 with SMTP id l21mr4198679qce.143.1301387095369;
 Tue, 29 Mar 2011 01:24:55 -0700 (PDT)
Received: by 10.229.185.2 with HTTP; Tue, 29 Mar 2011 01:24:55 -0700 (PDT)
In-Reply-To: <AANLkTi=5e4WUuZHcEJD50yJTw2eyYN_dN1S_7z62qy88@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170245>

On Tue, Mar 29, 2011 at 2:15 PM, Tor Arntsen <tor@spacetec.no> wrote:
> On Tue, Mar 29, 2011 at 07:42, Lynn Lin <lynn.xin.lin@gmail.com> wrot=
e:
>> All,
>> =A0 I have only have two commits in repo,then I want to squash these
>> two commit into one through git rebase -i .However it fails
>>
>> $ git rebase -i HEAD^1
>> it only show up one commit so can't squash (can't squash without a
>> previous commit)
>
> To squash commits with rebase -i:
> git log
> (identify the commit you wish to squash to)
> git rebase -i <the commit _before_ the one you want to squash to)
>
> e.g.
> git log
> 1
> 2
> 3
> 4
> ..
> you want to squash 2 into 3: Use git rebase -i 4
> (4 is really a hash of course).
>
> HEAD^some-value is OK sometimes but when I want to fix stuff down in
> the commit chain somewhere I find it simpler to use the hashes - just
> mark and paste.
> Anyway the real point is that with rebase -i you must specify the las=
t
> commit _before_ the range you want to work with.

Thanks .However my case is like:
git log
1
2

I want to squash 1 to 2,what's the commit I should specify with rebase =
-i

> -Tor
>
