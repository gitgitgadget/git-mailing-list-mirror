From: Tor Arntsen <tor@spacetec.no>
Subject: Re: git am mangles commit author name.
Date: Wed, 14 Jul 2010 16:16:40 +0200
Message-ID: <AANLkTim6Ax-4SVJU_LvR86SyD5q3VhCfGBlGOkSPTocL@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
	<AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
	<AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel F <nanotube@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 16:16:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ2lV-0003q2-8A
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 16:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab0GNOQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 10:16:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51871 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0GNOQm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 10:16:42 -0400
Received: by fxm14 with SMTP id 14so3039136fxm.19
        for <git@vger.kernel.org>; Wed, 14 Jul 2010 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=Fw0RaevJbiocOwHqrV21pYBgbH9Y4odzcGz+azvMtPc=;
        b=ZMSd5r4j3uxFjrumAt470+4rVfNQ/08HogjicoqMrjXvjDgXRJqloSCOkVjRPqp8hm
         jXG3XiXAbQc85N125n6o0A6jqO6yTxLXBPRriGN+VwCICdbGHleGHhniS4k2y+wvtTcR
         ULRkfkKvpP1x/xNFsLFesORM4lExSnKjK9+lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=WVwD4/F2IHCUCZaTJywBe1TQBpKOjrPcRSJ2fyzJMVRKl6Y4v6rhPys4/TsVB23wdA
         /gn3PycNhlQERdcVRJtiqguq1UkG/YOpTIZKtOMgg23ZaDqmniGSuWduLEnoo9/6pGRw
         dX7DQQ/976Pp9ySGXdLBUkr971p6P7riI9bmk=
Received: by 10.239.154.65 with SMTP id d1mr1414321hbc.86.1279117000553; Wed, 
	14 Jul 2010 07:16:40 -0700 (PDT)
Received: by 10.239.164.16 with HTTP; Wed, 14 Jul 2010 07:16:40 -0700 (PDT)
In-Reply-To: <AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
X-Google-Sender-Auth: y-BM8wIc0AFthMGc3s9fmoJ2_O0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150990>

On Tue, Jul 13, 2010 at 17:11, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Tue, Jul 13, 2010 at 10:54 AM, Daniel F <nanotube@gmail.com> wrote:
>> Apparently, git-am fails when the username is just one word.
>
> And is less than 3 characters.
[..]

When I was a student a long time ago there was another (European)
student there with a single-letter name.
His legal name was 'Z'. It was printed like that in all official
documents I ever saw, including bank accounts and loan papers, so it
wasn't just some nickname he was using.

-Tor
