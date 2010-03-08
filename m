From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Regression in `git add' in 1.7's 48ffef966c with a wildcard in 
	.gitignore
Date: Mon, 8 Mar 2010 20:21:19 +0000
Message-ID: <51dd1af81003081221xfd1a383tb411eeb1146bc67@mail.gmail.com>
References: <51dd1af81003080908i3bc94f27lc99e146bb57993ba@mail.gmail.com>
	 <4B9558AA.90907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 08 21:21:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NojSH-0006GJ-MT
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 21:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761Ab0CHUV0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 15:21:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:60519 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755743Ab0CHUVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 15:21:22 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2539892fgg.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L66j2AGm18Q5xxGfmN7sFoFlxZy8IDOn5SMmSTUvOiM=;
        b=Sc1KvDYYXqioSi1xV9kJnkDJnXcALKdzTfXzXisBp5QDp76DmKf2lHRHMdn2w+7eLi
         rGAAevRr4Q3J6ZKk9K+mQ+l+gCjkFN8DUR0LqPtHGpGS5a9zVY+oF0lhvMybQsacBD3H
         7LL7NeeAE6G3y7NdvHxRDi58RBKqhTkVaAd8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UNf3vvPiXssGpvYwAx9LYJ6Hif67cMgnCaU49uZiU8MnxyLTs7/I1sBs78fwmOMeyN
         vC9GwTjfj9WBpXBLKaEF9m6qSBuaZes/QjY9Mj/PeRQqz2pwyviBhDSRKv7EhN1gHB3Z
         0JIjq/cwsBYvH3hU3WAi1zTuA4rX8OmX2FRg8=
Received: by 10.103.64.21 with SMTP id r21mr3936381muk.30.1268079679121; Mon, 
	08 Mar 2010 12:21:19 -0800 (PST)
In-Reply-To: <4B9558AA.90907@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141784>

On Mon, Mar 8, 2010 at 20:06, Michael J Gruber <git@drmicha.warpmail.ne=
t> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 08.03.2010=
 18:08:
> Could this possibly be fixed by 13bb0ce (builtin-add: fix exclude
> handling, 2010-02-28) which is on pu?

Yes. I just compiled pu and the issue with git-add is indeed fixed in
13bb0ce, thanks.
