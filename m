From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 18:45:26 -0400
Message-ID: <CAJ80sau3EzaDgvTkM1mNDWSd_+xHC66YkRUS0c618yAm444Czg@mail.gmail.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	<xmqqioblisyk.fsf@gitster.dls.corp.google.com>
	<CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
	<CAPig+cQFana40n=SCBOC0P2v4Ss7Via3eS6Ms2rU=M9_V_3Osg@mail.gmail.com>
	<CAJ80savEBYGKLJx8pN+4xsDodi0PJcV2YHJLukDKztg3YV__FQ@mail.gmail.com>
	<xmqqwq01haqq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 00:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvZDY-0006qP-L9
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 00:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbbEUWp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 18:45:28 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34291 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397AbbEUWp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 18:45:27 -0400
Received: by wicmc15 with SMTP id mc15so25998664wic.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 15:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=moV7y6G7cAIyYg7OXb3nwP28hbMjVhqgp7d6YQtTWdY=;
        b=O6DqmHW4a9umL53ePaD2dGvmMzW9bJzQ0noBI9t70C1HbjxK5K+uUK55NLJVvbXVmx
         KED/ex57Z7nvsRCM7KW9M7gTlBlEjABz2WQb/tt0aGaH1vZeeA73bBPGIJpw25fInJCJ
         gDI+W/U/S+jYK1XucSgDrCkM7nHrFKAvZNL3wPtJkFKoJKivMNgGwBY54TV14nk9ZqMl
         7NRzz/83sT1873pvnQgUn8WRDj0kQ8+ChGrGSACW+gz81NHk3WFzTbYpl0fw2H/Bjj44
         1Pa/d7Dht3ifHEUyVuiNzuEB/eNygkq2VkinIIhVcEQd+TnXDhTwR6UXWVKnDD+WrPST
         kwmQ==
X-Received: by 10.180.91.137 with SMTP id ce9mr1695760wib.76.1432248326827;
 Thu, 21 May 2015 15:45:26 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Thu, 21 May 2015 15:45:26 -0700 (PDT)
In-Reply-To: <xmqqwq01haqq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269671>

On Thu, May 21, 2015 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Allen Hubbe <allenbh@gmail.com> writes:
>
>> Those are good points.  Maybe I shouldn't even mention sendmail at
>> all, not in the name of the format, and not in the commit message.
>> What name would be a good name for this format?
>
> "simple"?

Alright, as long as people agree that _this_ is the simple format, and
not something else.  I'll call it simple in v2, and see if anyone
complains.

>
> And if you are going to define such a format, then I do not think
> you would even need to pretend that someday you might support
> line folding (hence there is no need for "eh, excuse me, you seem to
> have wanted to express a long folded line here, but I do not support
> it (yet)" warning messages).
>
