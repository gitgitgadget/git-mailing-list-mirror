From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 18:50:05 -0500
Message-ID: <CAMP44s0q23j-7amBSuT0SL2-SkTmpyonmJx0y5VuAbk38Jo9KQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<CAMP44s2_wiNr4RaBOEnKnZzT4CF0qKK+bp+Lyi=Nfx3Q9ggqOQ@mail.gmail.com>
	<7vip3npet0.fsf@alter.siamese.dyndns.org>
	<CAMP44s3NE3yrQoa1nZXAgy3KFXGF56Ki8icJ2z2TDigzax0nWg@mail.gmail.com>
	<8761zm4wzg.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s0a2VsPBMd9Vrrhwdw=SPp2HrvDdXZ9Dmzhr9A6T+Sz7w@mail.gmail.com>
	<7va9oyl1wb.fsf@alter.siamese.dyndns.org>
	<CAMP44s38M7P0T1Wjhfv=XryoUevuxGwrik4pXwfkUfdpPNrXTQ@mail.gmail.com>
	<CABURp0q29QkUadbXXa7pQLnTAArRbKh0Y5tdN8stQ7s2BjNAYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 01:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USFdu-0002J8-TZ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 01:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965619Ab3DPXuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 19:50:08 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:53808 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965576Ab3DPXuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 19:50:06 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so1084613lbd.38
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=1Nex7/UWxt3hSBn3xQr9XR/q7YALu8Oj3EE9JOsXzuQ=;
        b=HzKp1SkLdFXiqwmItF1Ql4NALa5L8jYtx1bCJ/zHAzsK9c8JyYe87ns4NVAPYx8LUm
         i16LEmnyKB9orfaB8+VimyrNP2UczpkPZtDqhPUvtBil9ZDuJgTKqTYL4iLxd9oAS17C
         Lnh74cIx8eKBP8QUSopgSk5cAUXHh52abP6wm99zTab0UOZnj+hdivtPQ4EB9rSMv9E/
         k+xcCiozrBPVD/T6iVV1DvsWNxOu11xe4C7pmLHsE2AZ/mjTtJcxC5qNZvn1/i36IvCw
         /HZJYK1ORp48ftif/9bv0uLZfMbdXfYvaAxseAyRzIekTJN6FvkzNUv7gwQT75EHaFOH
         Bieg==
X-Received: by 10.112.154.98 with SMTP id vn2mr1025281lbb.8.1366156205129;
 Tue, 16 Apr 2013 16:50:05 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Tue, 16 Apr 2013 16:50:05 -0700 (PDT)
In-Reply-To: <CABURp0q29QkUadbXXa7pQLnTAArRbKh0Y5tdN8stQ7s2BjNAYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221489>

On Tue, Apr 16, 2013 at 5:34 PM, Phil Hord <phil.hord@gmail.com> wrote:
> On Tue, Apr 16, 2013 at 3:48 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Here it goes. The remote helper ref is going to be used to tell
>> fast-export which refs to negate (e.g. ^refs/testgit/origin/master),
>> so that extra commits are not generated, which the remote helper
>> should ignore anyway, because it should already have marks for those.
>> So doing two consecutive pushes, would push the commits twice.
>>
>> It's worth noting this is the first time anybody asks what is the
>> negative effect of this not getting fixed.
>
> Yes, but what is noteworthy about it is that you did not include that
> in your commit message to begin with.  This is the commit message
> request from Documentation/SubmittingPatches:

And yet, nobody asked for that.

Anyway, drop the patch then.

-- 
Felipe Contreras
