From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] Change branch --set-uptream to take an argument
Date: Tue, 1 Feb 2011 23:18:31 -0500
Message-ID: <AANLkTi=qn-Jf32iOHsaFwwcwp4_UWxcwG+t1VepO0FrC@mail.gmail.com>
References: <AANLkTinUn2SMijphe3EmPMVOOwBjPB5ffFwwqZVxQmW0@mail.gmail.com>
 <7v7hdj1mo7.fsf@alter.siamese.dyndns.org> <AANLkTi=gvVwh-H9FiGz6SQeJYwxmnnViYsDQX=RYRjb6@mail.gmail.com>
 <buohbcn3wp5.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Feb 02 05:19:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkUBS-0001kZ-CM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 05:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691Ab1BBETE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 23:19:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57982 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482Ab1BBETC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 23:19:02 -0500
Received: by iyj18 with SMTP id 18so6670119iyj.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 20:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=B9oBp0nohcpDw3kyI1XvtgeOVwORcNy276xT99B8eI8=;
        b=AgzySAVt+dpX4rhDjW27MGvTUfZLL6SPkvP5nW+fqNcwJtQ7Z0bXim7sTOGDWhKSFz
         Byud8mP7+igJB/HRtNbcW59CPTgjUmHoNdkU4PG6cWTnmA8N1lKW2RhW8dVM+6ftF+2T
         5W3bgHFD4PWbgWWUKeSA3Xt31DLxcA807lnt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=sCF+gUzfgyPbA9QcTGgv1Cbuko3YXV/o8/URU1d58+BIhxuWGwnYIh+zCEo/U3vocF
         DewJfHqrg2p++W6Vi54rRwn2/cSXb4OHNVDDrSsUJFHav5lsXr7Hx0HbnhdCJcTE4Ne+
         QhdWaTkh1yGGCyOdmlIbf06iKGgLOpudoSL2w=
Received: by 10.231.12.132 with SMTP id x4mr9296790ibx.177.1296620342155; Tue,
 01 Feb 2011 20:19:02 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Tue, 1 Feb 2011 20:18:31 -0800 (PST)
In-Reply-To: <buohbcn3wp5.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165894>

On Tue, Feb 1, 2011 at 11:08 PM, Miles Bader <miles@gnu.org> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> Okay, our emails criss-crossed. I agree with that, but my other email
>> proposes adding -u <name> with correct behavior and just deprecating
>> --set-upstream. I suppose we could instead (or in addition) just fix
>> --set-upstream.
>
> BTW, you're just talking about "git branch", right?
>
> ['cause the way "--set-upstream" works with "git push" is perfect, and
> shouldn't be changed...]

I was talking about git-branch and git-checkout. I didn't realize
git-push even had --set-upstream. Interestingly, -u is an alias for
--set-upstream with git-push, but not with git-branch.

j.
