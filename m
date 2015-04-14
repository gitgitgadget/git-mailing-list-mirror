From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCH] git-p4: Use -m when running p4 changes
Date: Tue, 14 Apr 2015 15:48:29 -0400
Message-ID: <CALM2SnY1a3FO34gTu3W98N5UaC3oGhZM-AP9aHzRpFGATi31MQ@mail.gmail.com>
References: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>
	<CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com>
	<CALM2SnY=ZcSMSXk6Ks0uU65gPX5vC8QKG+iSrQxd3X7N=sw+Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 21:48:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi6p1-0000I7-Cv
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 21:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbbDNTsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 15:48:31 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36591 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbDNTsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 15:48:30 -0400
Received: by pdea3 with SMTP id a3so23472619pde.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+3UdHrfvK8sX+hUdRMalYxXdk7VIJmycWr1J3hGTtF8=;
        b=gchLVrOwkKOrhQ7sOxoB5Z/r0SAleEIIwKfYESPRD4M5RH8ucIy2tJ1/kEiYS87ybm
         KdiO4GdIc9PpOWx3rr1l/uzZpxOQDv8v8IfSYC+NQRqGWS8SfuzoE2IdrkfcQrh+/KQr
         jV4FZK9fyXqIbBPuHZ1kY9EO3QKX1njSWvv24/KkbjpICA9jYrnQZApA3B45eYRU3+qe
         ciMMx1UMPdMAz9/KQl0ZJuxb4lybilVlgRTjsDrp0q9Gj6hPzGC3gYnqalGcq6hF/SEy
         CRuF4s41IRlQgoo8CWeSfuZr3UifZ0W+A0UCRuQ2kfrAlotXCqL9AHO5t8baL6pC3fac
         msgA==
X-Received: by 10.68.94.129 with SMTP id dc1mr39324665pbb.8.1429040909757;
 Tue, 14 Apr 2015 12:48:29 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Tue, 14 Apr 2015 12:48:29 -0700 (PDT)
In-Reply-To: <CALM2SnY=ZcSMSXk6Ks0uU65gPX5vC8QKG+iSrQxd3X7N=sw+Ww@mail.gmail.com>
X-Google-Sender-Auth: YOmx1mtWe0l2SuWlqhu3zJ8xG9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267159>

(resending with accidental HTML removed)


Great, I'm glad it looks like a good approach!

I'll add a test case for it.... and to support the test case, an
option for the block size. I guess the block-size option will go on
"sync", "clone", and "fetch". Alternatively, maybe someone has a
better suggestion of how to configure the block size.

Lex Spoon
