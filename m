From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diffcore-pickaxe doc: document -S and -G properly
Date: Tue, 14 May 2013 12:29:09 -0700
Message-ID: <20130514192909.GQ3657@google.com>
References: <1368540759-25598-1-git-send-email-artagnon@gmail.com>
 <7vwqr1jw67.fsf@alter.siamese.dyndns.org>
 <CALkWK0kJ7aksRbtjOesEPvsdx6wZyxxdVHUm_F-jS+Nb3WLSxg@mail.gmail.com>
 <7v8v3hjt57.fsf@alter.siamese.dyndns.org>
 <CALkWK0na1pDi5DnKUcWRnt0v9iQmeaLdrs7uQMDZzCKAazaNFg@mail.gmail.com>
 <20130514191757.GP3657@google.com>
 <CALkWK0=fr6413jY0wEf061y6Q_1MOksuWWBFuKhgdhphPHY-Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 21:29:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcKuU-0004rj-LE
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab3ENT3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 15:29:14 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:63203 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab3ENT3O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 15:29:14 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so697844pde.4
        for <git@vger.kernel.org>; Tue, 14 May 2013 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vzkPOxPbPebo5wd62llopfLg6LNgo3sfImQ6zd+/2v4=;
        b=o8E+dCkUDbQ8o6JKrWkgwWAWMqaq5tmnW7K/Mb9oJdPN45ocojFktOqPylIKzxx54l
         cbi0L/MP8IR872GOOZDhENfbuUCJ47iIZcP2LwhZRhEjVKALFErVCQicImS+bEDPUh7/
         AQG3u5zY+7mb898Q7b1AWm1+KyBVdd5A3u77qiMKRyIE+KDD+LRFY19/c76cSF/blWmw
         sE46+V2WND/0FL/OSTFxhzQaOIPL94Q4A7Z8sqUWL4cYpfk16LDh4cPsHmTW027XvUQj
         jdd7VuqpbqlXWMWL8JqScFwjRfaSxG6bGqDYAkmIRVgVyfGebzvLAfwYNnu9xVkJT3Vt
         slkw==
X-Received: by 10.68.130.199 with SMTP id og7mr35887824pbb.132.1368559753677;
        Tue, 14 May 2013 12:29:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id cc15sm152277pac.1.2013.05.14.12.29.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 May 2013 12:29:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=fr6413jY0wEf061y6Q_1MOksuWWBFuKhgdhphPHY-Cw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224322>

Ramkumar Ramachandra wrote:

> Should we mention in the -S documentation that temporary shell script
> is the way to get multi-line input?

No, because for almost everyone it isn't.

An example in the EXAMPLES section including an aside that you might
have to hit ^V to enter a tab could be useful, though.
