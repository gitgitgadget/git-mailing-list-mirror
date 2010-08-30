From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv4 1/2] daemon: add helper function named_sock_setup
Date: Mon, 30 Aug 2010 14:58:02 +0200
Message-ID: <AANLkTinE2aqRqTLvmxFEuDLd1WBCOzr0GfP64DjPsdPL@mail.gmail.com>
References: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org> <1283167851-18331-2-git-send-email-alexander@sulfrian.net>
 <AANLkTindaa-wDkOMW=BgtNJ+Wmi3xaBo1o_CF7NFH=Qm@mail.gmail.com> <20100830144631.23d1a164@laptop.localhost>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: AlexanderS <alexander@sulfrian.net>
X-From: git-owner@vger.kernel.org Mon Aug 30 15:00:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq3yI-00005c-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab0H3NAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:00:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44282 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892Ab0H3NAE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 09:00:04 -0400
Received: by ywh1 with SMTP id 1so1621628ywh.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=4UDouNfdZVQVpWrdqOIZTPiccJP+aPDnK6lutG1pMwA=;
        b=iEQHXhWpLGp+PvOlkMdQ9HQr5VBf8BBqP/My9A5E4dIX8cPeoQFKmJbgHKWFtz6Vbh
         Q8G8etCxYqGb7emoOh5kVXyxj8lmGCPRj3+IlbQ+4E+D75OMUo7xC9N6ChDK9dmvixiy
         NPrnE9/U7X9bpWDb1CWrnEmhchzw8k/aXsyd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=Is/SYV1YuCF5GK5WsNmqLAP46suOWCi4T8TuQ37cYZ3a30dmITK5KTqRylAWi5sF2t
         CxiHqvt7YUi3WdgPY4rQ/+sXG7CXqH2H9+jN65Vx8N3exP4xILR4kydrHpWO7EwceU1U
         lhH3nLmmR6875M+jgKZorya5eutP4Nmh8uc1c=
Received: by 10.151.82.15 with SMTP id j15mr207046ybl.408.1283173195182; Mon,
 30 Aug 2010 05:59:55 -0700 (PDT)
Received: by 10.150.211.14 with HTTP; Mon, 30 Aug 2010 05:58:02 -0700 (PDT)
In-Reply-To: <20100830144631.23d1a164@laptop.localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154795>

On Mon, Aug 30, 2010 at 2:46 PM, AlexanderS <alexander@sulfrian.net> wrote:
> On Mon, 30 Aug 2010 14:12:52 +0200
> Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
>> Since serve() isn't a library function, wouldn't it reduce needless
>> code churn to just make socklist a set of global variables (or just a
>> global struct)? That way you don't have to pass it around, changing
>> all those function prototypes.
>
> I don't understand: Even if I make socklist a global structure or
> something like that, I also have to change all this function prototypes
> to remove at least the old unused parameters.
>

You are of course right, strike my comment :)
