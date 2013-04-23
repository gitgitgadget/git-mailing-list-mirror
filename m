From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/7] am: suppress error output from a conditional
Date: Tue, 23 Apr 2013 23:01:51 +0530
Message-ID: <CALkWK0kzVPyOyz8PFPyYnCFS+pBQD_ninuFKUiJ4fhkeiUdeNA@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
 <1366725724-1016-2-git-send-email-artagnon@gmail.com> <CANiSa6i+jsZUBgeQcQq2C=d009dU=i6+g35-HoofedaEJRmzTg@mail.gmail.com>
 <CALkWK0mTGFiuYhsJMf0x9YrO2ke21YmhzhiQQmqLqG61=pVFdw@mail.gmail.com> <7vmwspi2ag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 19:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUh56-0002X6-MF
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 19:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab3DWRcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 13:32:33 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:61171 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756893Ab3DWRcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 13:32:32 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so974528ieb.41
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2RC5+tXkI0nIXMObiVWfuYhju0ZIDwmhIF+fFmPdKlg=;
        b=qddSZCEn/Ld3n/KKp4b4ZAhAsk69Gqlo9AK/ROzNHE+nLuwvITvZ1cD22XDL35BMbd
         RP9N0IOBAa9ToFRQ7JARV9fdi9RE6+v6xGAjPbNuYUE2SZudGGsYoCaCypx4ZM+fF69a
         dAxkY1WOOn+GVmmCSlC4GaBbDlcDMSFVzcJgumKPjoC9zdgO+5osMzHJ3QdXpXemi2qk
         x+opc2b66WlaV2EdrZv3oThRUp2cj6LASC/RxXEID0x5Pkh0NYYNdP+EW+nDB8r/e2GA
         4G9Vk+ITFA4kkfebNFoQQ86K2ZCNSn27iKSQmzwjkUPuuRMZR49ski3OzipdOHUvBce7
         dAcA==
X-Received: by 10.42.50.202 with SMTP id b10mr16399042icg.7.1366738351618;
 Tue, 23 Apr 2013 10:32:31 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Tue, 23 Apr 2013 10:31:51 -0700 (PDT)
In-Reply-To: <7vmwspi2ag.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222198>

Junio C Hamano wrote:
> Perhaps all of these "oops, 7/7 breaks this and that so let's work
> them around" can be avoided if the series did not store the object
> name of the stash that records the local changes as a plain text
> file inside a $dotest/ directory, and instead used a dedicated ref
> somewhere under refs/ hierarchy, no?

Exactly.  Which is why I was asking for named stashes on the other
thread.  Much cleaner than keeping track of it yourself.
