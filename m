From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] log: prettier decorations
Date: Thu, 14 May 2009 00:34:41 +0300
Message-ID: <94a0d4530905131434q17743408p5bc4b1c2fc332ea@mail.gmail.com>
References: <1242249726-8514-1-git-send-email-felipe.contreras@gmail.com>
	 <20090513212812.GA21268@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 23:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4M6E-0003PB-N2
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 23:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194AbZEMVen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 17:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbZEMVem
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 17:34:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:52974 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZEMVel convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 17:34:41 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1104810fga.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NFRK2q9gsL9pxMzl8OzBUs+fEC+S6NE8yXVmHZigNvs=;
        b=qpzYY+96uNd4Unmirnx+32kIhyAG1T2Kvtsrze7Jd+fITI3wu8y8oR7t0k/C0GMnc/
         lEPRzOszUQuJQn64dReq6qTrKEhb0CpJLvhuYjkmQu8H9R+GutW9LDCT0zuew6u/DIMD
         CnlYGaRDe634KuJcTBAbgDDKQywJ9w1ig2Zxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=P3jpMtiiTvyMK7311oGw9RSYYQlH53bq47KUdTQZB9jXqhS8OqdIgXxlzuuvWPlHhK
         1/2xHomSn7DxnhpYSyKMyOxNXBeoVRq87wV8ygeeTtC1CCS8AHFbTUkYM77JC21H9x1n
         TFWwAzK4cB6+teX6q0Mx7UoLIgcJyJuNzMIGQ=
Received: by 10.86.80.5 with SMTP id d5mr1745006fgb.59.1242250481445; Wed, 13 
	May 2009 14:34:41 -0700 (PDT)
In-Reply-To: <20090513212812.GA21268@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119116>

On Thu, May 14, 2009 at 12:28 AM, Jeff King <peff@peff.net> wrote:
> On Thu, May 14, 2009 at 12:22:03AM +0300, Felipe Contreras wrote:
>
>> In order to do that I had to change prettify_ref to prettify_refname=
 because
>> add_ref_decoration doesn't have the ref object.
>
> Thanks, this 1/3 looks fine to me.
>
> But:
>
>> Felipe Contreras (3):
>> =C2=A0 Change prettify_ref to prettify_refname
>> =C2=A0 Prettify log decorations even more
>> =C2=A0 Fix test for new log decorate
>
> Shouldn't 2/3 and 3/3 just be squashed together? It looks like 3/3 fi=
xes
> tests broken in 2/3, so you are hurting bisectability if they don't
> happen together.

Yeah, I thought so too. Maybe I should trust my instinct a bit more =3D=
P

> Other than that, I think the intent of the change and the implementat=
ion
> look fine.

Cool. I squashed them and re-sent.

--=20
=46elipe Contreras
