From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Thu, 18 Aug 2011 15:43:12 +0200
Message-ID: <CALeToSUUJ4egjU_Pduub4VC+CJ3b2YSvPFEfJikRMsm9w4Ad5w@mail.gmail.com>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty9ijs1i.fsf@alter.siamese.dyndns.org> <20110817003023.GA30153@dcvr.yhbt.net>
 <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com>
 <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com> <20110817203701.GB24581@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 15:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu2t3-0004dC-Mw
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 15:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab1HRNnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 09:43:53 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52493 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1HRNnw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 09:43:52 -0400
Received: by vxi9 with SMTP id 9so1722844vxi.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nYadHUhINTESTopVGesgnJgwT7rnoQklcsvRTXTS2Tg=;
        b=OmFTJXhG38XzriiJb77t0ABLKyblIsYUtqDeTg3aM5MEGEQYHm3DAwq6FUqmTY4NYY
         ZnIZYKR/upFCRF9PB19NmFosCDIZkuzRU052kDZ/6q/pIF4qh88lJDH4O2TJ1p9oW++/
         M1SgV7PqE7Y0YhBMGDUg+lbes3AHgnF14yFLg=
Received: by 10.52.21.201 with SMTP id x9mr728128vde.363.1313675032247; Thu,
 18 Aug 2011 06:43:52 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Thu, 18 Aug 2011 06:43:12 -0700 (PDT)
In-Reply-To: <20110817203701.GB24581@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179598>

2011/8/17 Eric Wong <normalperson@yhbt.net>:
>> 2011/8/17 Eric Wong <normalperson@yhbt.net> wrote:
>> > Perhaps an interactive option for dcommit would be just as useful?
>
> 1 and 3 can both implemented, but I think 3 would be easier to
> use/setup/standardize. =A0I suspect it's also easier to train oneself=
 to
> always use "dcommit -i". =A0Perhaps even default to interactive mode
> like git-send-email does nowadays.
>
> Unfortunately interactive dcommit requires more effort to implement.
>
> --
> Eric Wong

It seems that proposal 3 is somehow equivalent to
$ git rebase -i --onto remotes/trunk remotes/trunk
=2E.. check commits, maybe remove some of them, ...
$ git svn dcommit

note : is the SVN remote branch always named "remote/trunk" ? If not,
is there a way to guess its name ?

--
=46red
