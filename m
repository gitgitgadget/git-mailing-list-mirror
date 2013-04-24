From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 12:14:53 -0700
Message-ID: <20130424191453.GG29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com>
 <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com>
 <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:15:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV59k-0002fb-4S
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188Ab3DXTO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:14:59 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37847 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab3DXTO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:14:58 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so795776pde.23
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=f/zfeEfDKIScw2+B0XtUa5kF952Y6EyfnDnyRe1kjfU=;
        b=uk3ptn0UIYPYgQhFIkeAuIB66CIAdU3rfAPJhnTO7Ro1OxvAdEzSjI6dZWLdjdtnFy
         MhZhUn9QITN7eHcaE8o3B8ktLy4syOZj4aceL/abxrMpZDcoHkdL2jbjsJYcNUQ1BLQO
         HLnTijl33GhOqMzogSueChllWwbQD5T/1mtw/z7Y1ZXtrdg+gAt/J8j5CQlwoYteC7Uq
         REW3SAW/sbVg690sk79koAyByFvdVe/CRl9JoQlpEuDvC5+mxAtb4kW8SN1+Yv1RPQtq
         08yCygYv9Yw+9kR86FmitldPENvGq9NWf++njKuMJHXlaM9KGnFFN8fTYhU7wq4KFmcp
         139g==
X-Received: by 10.68.129.162 with SMTP id nx2mr48759675pbb.178.1366830897748;
        Wed, 24 Apr 2013 12:14:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id p5sm4091724pbl.17.2013.04.24.12.14.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 12:14:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222301>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Maybe it would make sense to move towards eliminating the "implicit
>> --no-index for paths outside the repository" trick.  I use "git diff
>> --no-index" all the time, but I always spell it out to be careful.
>
> Huh?  Why do you want to endure the pain of spelling it out, when your
> intent is perfectly clear?

Because typing paths does not make my intent perfectly clear.

> What would make sense is a tristate diff.no-index:

Oh please no.

Hope that helps,
Jonathan
