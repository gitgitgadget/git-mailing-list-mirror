From: Kasra Khosoussi <kasra.mail@gmail.com>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 19:29:18 +0430
Message-ID: <BANLkTinaMfD4YG_Rx1OhixoX7XuPmaiaMQ@mail.gmail.com>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
	<4E005404.5010901@drmicha.warpmail.net>
	<BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
	<4E006682.80101@drmicha.warpmail.net>
	<BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
	<4E00A0E1.8000006@viscovery.net>
	<BANLkTi=6jt7Z3fvK++ontW=F9AJbmEr9Qg@mail.gmail.com>
	<20110621143211.GA4910@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ2QG-0001mp-KH
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1FUO7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jun 2011 10:59:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42768 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1FUO7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2011 10:59:19 -0400
Received: by pvg12 with SMTP id 12so1503968pvg.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b8elXCwYTyobjPotwmSZ+fH3ymcUh7rAvgW4MLL9VMc=;
        b=oCWPMlVhg12FPAgm6M+BU8dk45kNYaRE9+m4esKKB8OgVvC7f/Ft9BMfIwQ5FWqQvC
         Q9zO4brFC9l4J+PiU9hlwWjDJx/bs5ZpMSUsTuzIozlaXnm6XLv5mbXBMGLBKFkTp27/
         xPFej8g0qrkfCCUsQS+58zZgw88aPhA73kjEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sHtNYXFVBf+XkKyQJDVbPK/LVa9xeR7exRZsxWxHUOY4NQrriuLa+uJRe0HlEbn9qq
         wtgB74oOvdrziSqDRqASUcFyPFAPZUV5DKa/wo2x6GE8EX1dYe62mf4NE3jExeKJpx6m
         RvfqgqMRXeirf8QriQTZkNCrJnLt9Gaj5ZiKQ=
Received: by 10.68.31.234 with SMTP id d10mr2814739pbi.490.1308668358420; Tue,
 21 Jun 2011 07:59:18 -0700 (PDT)
Received: by 10.68.55.132 with HTTP; Tue, 21 Jun 2011 07:59:18 -0700 (PDT)
In-Reply-To: <20110621143211.GA4910@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176160>

The battery was not empty when I issued the shutdown command, so there
should have been plenty of time before it ran out.

-Kasra

On Tue, Jun 21, 2011 at 7:02 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> On Tue, Jun 21, 2011 at 06:56:55PM +0430, Kasra Khosoussi wrote:
>> Good question! Actually I have no idea!
>>
>> It was fine yesterday. I had to leave home so I just shutdown my
>> netbook (I just issued the command and closed the lid). Files were
>> open in my editor but I'm sure that there were no Git processes
>> running at the time. The battery was empty this morning, so my best
>> guess is that the halt operation was somehow failed, but I think it
>> can not explain the corruption.
>>
>> Any idea?
>
> Does your computer actually shutdown or suspend? It could be that the
> files still hadn't been flushed to disc when the battery ran out, but
> that is unlikely if it did keep running.
>
> Cheers,
> =C2=A0 cmn
>
