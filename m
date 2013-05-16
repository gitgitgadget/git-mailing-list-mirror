From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Thu, 16 May 2013 18:51:44 +0530
Message-ID: <CALkWK0nQt2X4+iMTtMYT4XJ7xQt00-Q2sPmsrQiZX+buSkzvTw@mail.gmail.com>
References: <28799936.346521359596121253.JavaMail.weblogic@epmltmp3>
 <12070540.431901359961105650.JavaMail.weblogic@epml10> <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net> <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
 <20130204093821.GA32095@sigill.intra.peff.net> <7vboc03u3e.fsf@alter.siamese.dyndns.org>
 <20130204183437.GA15552@google.com> <1368587682499-7585906.post@n2.nabble.com>
 <CALkWK0mrofeL7u4GCd_2k3+X-hQ6FeZ0kLhYShbCjgnomD3+sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: sam <sdoyle_2@yahoo.com>
X-From: git-owner@vger.kernel.org Thu May 16 15:22:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucy8i-0007NM-Sd
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 15:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab3EPNW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 09:22:26 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:51233 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507Ab3EPNWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 09:22:25 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so6505190iec.1
        for <git@vger.kernel.org>; Thu, 16 May 2013 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DVGl0eao7CT6q3U3xxa8BWqvbjsOdG5+/9//Vy0tLUA=;
        b=zZdXOavIaYARiCML0bvL7Hu+kKk/FY7UdLptRya84e7g69q2Z3X+EZoLCVZR8IJ7M9
         ScLjARZYsKKnSW5zUE+8FZ5ScXhQaBo5Rv4jQAHEzOIWz+BdcBMiQiTDOZFYXHMsli4f
         SCKRu1fir2airtJ2ZwBes85sk/ZWsiQ7t0obPRpJrNcS4SyXF53MSokMBCAodmSsTXH/
         1eon3i8NS0pJVzBvQF9gy0sphWb10ZlIiJ7pmU6wPNohewfkKXZOIjrEhojrMDnv2ygZ
         bG+w5Q4hnla8NPxSSv3+A6iVEYoapJIX5fQoDNfYxt/yi6+kQZAZcz63WQkr9DzF++H4
         vnLw==
X-Received: by 10.50.147.71 with SMTP id ti7mr9375258igb.49.1368710544826;
 Thu, 16 May 2013 06:22:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 06:21:44 -0700 (PDT)
In-Reply-To: <CALkWK0mrofeL7u4GCd_2k3+X-hQ6FeZ0kLhYShbCjgnomD3+sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224563>

Ramkumar Ramachandra wrote:
> sam wrote:
>> gdb /usr/bin/git core
>
> What exactly are you doing?  Is core aliased to something?

Sorry about that.  I just realized you're loading a core dump.

Please tell us how to reproduce this, or give us the backtrace with
debugging symbols.
