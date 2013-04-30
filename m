From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 23:54:03 +0530
Message-ID: <CALkWK0ndb-8dtVbUxTbwKTiC02_ut=0qX3p=KbvcpEqBi5jqcQ@mail.gmail.com>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
 <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
 <7vehdsf19m.fsf@alter.siamese.dyndns.org> <CALkWK0kzjg+CPw8hq6ZAZxqVGdp7cf6HN-XHFCjbkNk9O=M5CA@mail.gmail.com>
 <CAMP44s0=5KniGDnVtKPg5sp=G8M-mPcq+Mu1nXqODfhT-MaNyg@mail.gmail.com>
 <CALkWK0kLZ9WLVcPBWuQZCjOku4A+WQ7=YeooPmKGpk9HuGYQnw@mail.gmail.com>
 <7vwqrjdh6v.fsf@alter.siamese.dyndns.org> <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFEP-0004e2-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252Ab3D3SYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:24:46 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:43163 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760824Ab3D3SYo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:24:44 -0400
Received: by mail-ia0-f172.google.com with SMTP id i20so708026ian.17
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uaAGHzbyYUE2hmUXvukKshr3KcS+EC7y9ora1hDY2V8=;
        b=mlPJQNFvhaJCR427E6DJReYGNhg0RPvuFDoQ1/wZ3rpE592LZ3UG2yw1CzOYBNVDPC
         VGTezJvaeDogUID89xeojduwmUlbucp0V3EpdZaRAmeVA7RTfRPziqZAS7c6QOVR+srY
         lrWHU8dBs4PeaAIzOey+QvTPinBrby1eQkGYe74Bx9YzbGC1V2E0t9Uk8yAN2WZOZXT0
         Hqn9GH1CNAbu6UGcTId4cASk1ehEh36oUFBqoM5vBnF6BL8uAhMLumLkucgM9kNdcuoU
         zntAfundIr3/n9/kCyyl2ufT1eHY4eeXWTpu9pSDDvEVhdu5j8PXJGhEaX+m9yDdwEwk
         H39A==
X-Received: by 10.50.3.38 with SMTP id 6mr4590398igz.44.1367346284160; Tue, 30
 Apr 2013 11:24:44 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:24:03 -0700 (PDT)
In-Reply-To: <CALkWK0kcuaXTKbafmC72C3H+UZN6oeEY140T21LJUHveO=UBvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222982>

Ramkumar Ramachandra wrote:
> @@{5.minutes.ago} and @@{1} work perfectly fine on git.git master.

(with the .git/@ symref obviously)
