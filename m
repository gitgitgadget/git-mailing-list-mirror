From: Michael Witten <mfwitten@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 09:12:31 -0600
Message-ID: <b4087cc51003190812v73c23cb1jdb37341183831421@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <m3tyscjt7h.fsf@localhost.localdomain> 
	<b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com> 
	<40aa078e1003190756h190af29ao472508aaf624efe3@mail.gmail.com> 
	<b4087cc51003190805h1eb91af9wf0c8e987f9a75026@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 19 16:17:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsdx0-0001x9-UJ
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab0CSPMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 11:12:53 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48390 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0CSPMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 11:12:52 -0400
Received: by fxm19 with SMTP id 19so693113fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=ukpMI8B61SzPgi0kFHDr8Vy9U1U75M5gJta8WGEkorQ=;
        b=jv+oaED12qZ2iLAuInBbJp2aK5DMzZV3Aka50EhOdgQFn3glFJcYfmAcj/yV97lZfU
         oarlhOc7bhkQVafEoVk/kJBTFjuOlIs+ymeeKRt12nx7Rmga5BkTdeYj20rfSZ4BI8Ld
         Vb9H2oI+1wlVX2kbg2LMQc3aXUCdiGW+oWIz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rtuhj53vNz2xvLeoo6iQkIkfWYjvKFtJ/YVobfD4CtUr0kdeBC/ql0DuvH8xNuM1QK
         VgBlWOVyT8zKWCavGnKTXn1l18CT/XIQeXnUgs9czyUV82N7DmC1/QqUY7N95CSMuvwj
         SuRTH5kOewudPmasEfS1q2EqP3NpS+K0QNsAo=
Received: by 10.239.190.65 with SMTP id w1mr1670122hbh.126.1269011571160; Fri, 
	19 Mar 2010 08:12:51 -0700 (PDT)
In-Reply-To: <b4087cc51003190805h1eb91af9wf0c8e987f9a75026@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142612>

On Fri, Mar 19, 2010 at 09:05, Michael Witten <mfwitten@gmail.com> wrote:
>
> It's useless to spoof the From field because many email services won't
> send it, a point I already covered in the email you quoted.
>
> When a patch is finally emailed, it's the From field that is used for
> Author attribution.
>
> You see? Your identity has been tied to whatever email service you
> happen to use at any given time rather than to something with more
> long term stability.

A lot of trouble could probably be avoided if the Authorship
information could be sent as something separate from the From field. I
don't think it would be quite as powerful as having a uuid, but it
would be less invasive and probably practically as effective.
