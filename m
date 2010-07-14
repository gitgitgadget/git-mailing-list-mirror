From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: help with distributed workflow/signoff
Date: Wed, 14 Jul 2010 21:03:25 +0000
Message-ID: <AANLkTilo4TnMQcr7p1dfAeQ4tESHjO4Nbr8274hqxOnD@mail.gmail.com>
References: <loom.20100714T180615-173@post.gmane.org>
	<AANLkTimdVvKYPQn84IQvk7yxMo-gtrjWWqzN-ypXV78X@mail.gmail.com>
	<loom.20100714T195109-665@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brock Peabody <brock.peabody@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 23:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ977-0000VJ-6d
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 23:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab0GNVD1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jul 2010 17:03:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48821 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab0GNVD0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jul 2010 17:03:26 -0400
Received: by iwn7 with SMTP id 7so181845iwn.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 14:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QvAWmH9tGMWBXEgovnB6D4IkAthCjIziE8k0MztY/sM=;
        b=fiUcoljEuCa7EIT6TBkDfvamv8cHpZv3QPITSDWYD/IK9A5IreSW80Glej5NWNzfrX
         fvnl0/UztkKuCgo+fR4l6dr5jGtq59TS3O37PLnnDdwo/01sleGZbHwHTUrISENqr2BH
         gQl2s0ddookR5IehM5/qN/sMnVvJ7rqBLzeho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UICVXwUh4yr0UA1fmMc3KVK2CFqtRD6oF1oNgojuRGUmhVw5PuB4LCIwX1fdhvhaJW
         z3EsjXpIYFGgnDVD0FNLFjPHEom709tQf6QOa02mZ3tPJgzcNW5du3IMfmpcM32ETxnR
         EUH/vl3jlDyXKcO6KWU+wsd7Ja7dG6jYagbsE=
Received: by 10.231.31.7 with SMTP id w7mr17948505ibc.83.1279141405703; Wed, 
	14 Jul 2010 14:03:25 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 14 Jul 2010 14:03:25 -0700 (PDT)
In-Reply-To: <loom.20100714T195109-665@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151034>

On Wed, Jul 14, 2010 at 18:06, Brock Peabody <brock.peabody@gmail.com> =
wrote:
> Hi Avery,
>
> Avery Pennarun <apenwarr <at> gmail.com> writes:
>
>> For an open source project, where most contributions are by voluntee=
rs
>> and need to have their patches reviewed multiple times before
>> submission - and frequently, more patchsets are rejected than applie=
d
>> - this works reasonably well. =C2=A0For a company where (in my exper=
ience
>> at least) most people's patches *are* applied, and the ratio of
>> reviewers to coders is much lower, that's much less workable. =C2=A0=
And
>> unfortunately the elegant looking multiple-signed-off-by or acked-by
>> lines don't work so well for that.
>
> I think you've hit the nail on the head here. =C2=A0In our environmen=
t, commits are
> frequent and signoffs prompt. =C2=A0Revisions are very rarely rejecte=
d, and will
> never pass through more than one reviewer except in extreme cases. =C2=
=A0Contributors
> will have little tolerance for per-commit time or complexity overhead=
 incurred
> from the process.

Well, consider that even if you push most patches through, the peer
review you get from having a setup similar to Git's own might very
well be worth it. Everyone makes mistakes, having a second set of
eyeballs to look at your code eliminates a lot of that.

That may not be acceptable to your corporate culture, but consider
that most big corporations (e.g. Google) do detailed code review
before anything gets commited to the master repository.
