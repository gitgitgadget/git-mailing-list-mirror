From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Tue, 1 Feb 2011 16:27:13 -0500
Message-ID: <AANLkTi=gvVwh-H9FiGz6SQeJYwxmnnViYsDQX=RYRjb6@mail.gmail.com>
References: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com> <7v7hdj1mo7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:27:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNlR-000526-Cw
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab1BAV1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 16:27:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35346 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab1BAV1o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 16:27:44 -0500
Received: by iyj18 with SMTP id 18so6386756iyj.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 13:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=PoLPLvM3keA0j/DXf27XEC2GAYO5bcGyb2ZE37T6ezA=;
        b=Yh+J6Z9QMQepJZcRs190kwhHBPkA1doq6YbB6sJ7sQEOaPXQBW3tTYd5FahXb+UGCk
         0noG+aQK2fxAcRvGDApnq9UeiFobXlXkcWhmYexUrVCpteWUOdC99ADQ42GaZQiWMpwP
         GCsQTvwTn4TugsK6l+rvMZaZfYAuJlQWhsyNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F9Kbdu4UB97S87DrcpOvfrl8mRD7KGKuBaYtqq82woobh+X9vLRQhnLHUsqfFWD5PS
         zoCDp9ZUqtj/Lm2LY3UgOk5DYHLg0DciroR+h8TRCeUS05imSL9VHe+vCSEX2M7jzGFz
         2BwqKFvLkxgEJY74QEXvXOC+XqrUzhbutC29o=
Received: by 10.231.12.132 with SMTP id x4mr8880598ibx.177.1296595663490; Tue,
 01 Feb 2011 13:27:43 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Tue, 1 Feb 2011 13:27:13 -0800 (PST)
In-Reply-To: <7v7hdj1mo7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165857>

On Tue, Feb 1, 2011 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> IOW, I don't think
>
>> =C2=A0 (master)$ git branch --set-upstream origin/master
>> =C2=A0 Branch origin/master set up to track local branch master.
>
> is a sane behaviour from day one, and is simply a bug. =C2=A0Changing=
 this
> behaviour would merely be a bugfix, not a flag-day event that changes=
 an
> established behaviour.

Okay, our emails criss-crossed. I agree with that, but my other email
proposes adding -u <name> with correct behavior and just deprecating
--set-upstream. I suppose we could instead (or in addition) just fix
--set-upstream.

I guess please reply to the other email so we don't keep criss-crossing=
=2E :-)

j.
