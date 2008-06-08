From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 02:56:09 +0200
Message-ID: <bd6139dc0806071756k331c9b29obc5f1cb525ef47d8@mail.gmail.com>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
	 <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
	 <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
	 <20080608004928.GG29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 02:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K59DU-0002Uu-6N
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbYFHA4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbYFHA4L
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:56:11 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:24091 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbYFHA4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:56:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1542288wfd.4
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=XEuy57YZQEGFoSWqaiPgXD+xBHbNy7zQ35neXLvLgso=;
        b=aQVmkvkFdd+Hlt+7m1HypKGNd5OGzMaQ9sJnMBjOutIbr4cMZoal3NibsfszmhyMSk
         RxzHOwA4es5l58A74cljE/kBcZT4zXu6kn5g86sNXa3VD0zcdopX9ccM8h/iAlAQ13oj
         4bQ0rbSd92vP3gyLGXhZpr6+O2J0uPANliPdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=jkYywKlwKlrh1xWalfb+L2CnhgFAZ3BC7tuekRrDmfP4XPSpG0JaTn/nS2/CRJnFV+
         505x9GjSoNGswq1vq3H3ZFEdMwt0/UIWeSmZAj3IMyuHCPcZ2KXx+Iz4VECOaqyrqreG
         8SZqGFlynmQkMTumZtMV+DMXcQOyaEnfj6idY=
Received: by 10.142.164.10 with SMTP id m10mr740602wfe.60.1212886569089;
        Sat, 07 Jun 2008 17:56:09 -0700 (PDT)
Received: by 10.143.41.7 with HTTP; Sat, 7 Jun 2008 17:56:09 -0700 (PDT)
In-Reply-To: <20080608004928.GG29404@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: 6a44ad6be03add11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84239>

On Sun, Jun 8, 2008 at 2:49 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sun, Jun 08, 2008 at 02:34:25AM +0200, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Awesome, what do you want to do with the other patches?
>
> Nothing? It's your series. :-)

Heh, I'm not sure what the protocol is here :P. I could send in the
series with your patch as second... that is, if I can figure out how
to apply it from gmail (maybe you can send me the patch as attachment?
:D).

>> I mean, this patch on it's own doesn't make a lot of sense, but with
>> [1/3] and [3/3] I think it deserves some proper reviewing by the list.
>
> Sure. I would suggest:
>
> 1) Remove that ugly /tmp/git-test-results, place it under t/.

I remember trying that but it not working, which was why I put it
there in the first place. I'll give it a shot again tomorrow though.

> 2) Resend a series indicating this is no longer a demonstration but a
> real series which you want to be included. ;-)

ACK on that one ;).

> Ah and it's bikesheding, but probably key_value_parser.sh is not the
> best name for such a script. Maybe aggregate-results.sh or something
> like that.

Sure, but that's what it was though, a simple key_value_parser, your
version is actually a result aggregator.

-- 
Cheers,

Sverre Rabbelier
