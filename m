From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: measuring the % change between two commits
Date: Fri, 24 Feb 2012 22:35:07 +0530
Message-ID: <CAMK1S_hHCQ2SxhD=GiyHTzd=rgZF5aT7XdWn5-HEv1Xsr_+KvQ@mail.gmail.com>
References: <CAMK1S_gXQaE+RZxe4S7vqAyPka9N9PAoe+557FaLO+JJoJFshA@mail.gmail.com>
	<7vpqd52tqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 18:05:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ya4-0001yH-5r
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 18:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809Ab2BXRFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 12:05:09 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:64540 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753624Ab2BXRFI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 12:05:08 -0500
Received: by obcva7 with SMTP id va7so3052190obc.19
        for <git@vger.kernel.org>; Fri, 24 Feb 2012 09:05:07 -0800 (PST)
Received-SPF: pass (google.com: domain of sitaramc@gmail.com designates 10.182.15.5 as permitted sender) client-ip=10.182.15.5;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sitaramc@gmail.com designates 10.182.15.5 as permitted sender) smtp.mail=sitaramc@gmail.com; dkim=pass header.i=sitaramc@gmail.com
Received: from mr.google.com ([10.182.15.5])
        by 10.182.15.5 with SMTP id t5mr1221956obc.2.1330103107804 (num_hops = 1);
        Fri, 24 Feb 2012 09:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bt7YvclhM++u81fpeQIBP52BKD8z3OZAOpjJ0KzOigk=;
        b=v5SXg2tu4CDaypn3xmSybe1ZtZsipTJntgo6a9Yvf54oqPqDwL6+rM2leWXDYi+axc
         yx/DW5K6cKdRB6d5SWIfW09SLwLoLQ5XQEMaKQ+YlD1aRm7xeXImK4tlZ9OlRvNnZu5W
         BbaW1G2ifrF13h7iQB9cH9wxYKDns+y+tDoQk=
Received: by 10.182.15.5 with SMTP id t5mr1060294obc.2.1330103107739; Fri, 24
 Feb 2012 09:05:07 -0800 (PST)
Received: by 10.182.175.106 with HTTP; Fri, 24 Feb 2012 09:05:07 -0800 (PST)
In-Reply-To: <7vpqd52tqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191443>

On Fri, Feb 24, 2012 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> I could do a --numstat and then do a 'wc -l' on each file I guess, b=
ut
>> I was hoping to avoid that.
>>
>> --dirstat gives you a percentage but does not count the top level di=
rectory.
>
> Note that dirstat is not about "how much damage was caused to the ent=
ire
> codebase". =C2=A0It only measures "How is the damage this patch cause=
s
> distributed across directories it touches". =C2=A0It was unclear from=
 your "a %
> measure for the changes between two commits" which one you meant, but=
 I am
> guessing from your "--numstat and wc -l" reference that you are askin=
g for
> the former, e.g. we have 300,000 lines of code and between these two
> commits 10,000 lines changed, hence we updated 3% of the codebase dur=
ing
> that period".

yes; I wanted an overall figure.  Clearly I misunderstood dirstat
then.  (Should have guessed from the "...may not total to 100%..."
comment somewhere.

Thanks

--=20
Sitaram
