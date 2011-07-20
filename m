From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Wed, 20 Jul 2011 11:02:30 +0530
Message-ID: <CALkWK0=shto-FaRvtc0EXuD8kM6z=TzU=VEztznSNwJ6n2RhXA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com> <20110712165302.GA13578@elie>
 <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
 <20110713064240.GC31003@elie> <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
 <20110719193608.GA26557@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 07:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjPOy-0001Dq-Dz
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 07:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538Ab1GTFcw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jul 2011 01:32:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59964 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1GTFcv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 01:32:51 -0400
Received: by wwe5 with SMTP id 5so4845198wwe.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=F2zwW7bCL+VSWTsMbD4SWSCrNjYWEcnw50a59K3xNow=;
        b=t2089/OWyA4KECqmzlYfTv1NO1aum6VA/PiqnTtU4C2/zsd3PUfcE4fwHIOuR3ZD88
         INi0lj9fCw09PBvrlAlLaGi/YdDYxobL7COrhdG+Vx43Ge3K1y6lhoilxyB1GhNeJ+69
         iLQWlJmg4ey6YchpqCr1ArVIYwgolVnxUefYY=
Received: by 10.216.234.143 with SMTP id s15mr208276weq.66.1311139970075; Tue,
 19 Jul 2011 22:32:50 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Tue, 19 Jul 2011 22:32:30 -0700 (PDT)
In-Reply-To: <20110719193608.GA26557@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177518>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Since it's
>> totally impossible to reproduce this bug, it's not really a bug --
>
> Huh?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cat-file commit HEAD | sed -e '/^$/ q'=
 >newcommit &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cmit=3D$(git hash-object -t commit -w newc=
ommit) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick $cmit

Oh.  I should've been clearer -- it's totally impossible to reproduce
this bug, except by hand-crafting a commit object.
Thanks for the interesting exercise.

-- Ram
