From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 03:41:33 +0530
Message-ID: <CALkWK0=Y-pO3+g21PLCWOxx+M-7fSmp2FedMBtZ68PWU_TOHDw@mail.gmail.com>
References: <20130410200548.GC24177@sigill.intra.peff.net> <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com> <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
 <20130410212911.GE27070@google.com> <CALkWK0m=iDw+N0zcfEEt1jzFD4wOOzLgyBWNyc=HZ+xLe5SBLw@mail.gmail.com>
 <20130410215658.GC6215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 00:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ3Fe-0000LZ-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 00:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758741Ab3DJWMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 18:12:15 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:49597 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3DJWMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 18:12:14 -0400
Received: by mail-ia0-f178.google.com with SMTP id f27so879190iae.9
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=24UhhDbGi/EQ9lg/gZsuDkdw6QRj/NnTmZeoTwwPcec=;
        b=0ItfMzamzJQKY7eDEyH1pxxXa/gVPmzWOi1YR3h/7YaLNbQX0KbMualoPYJbI3MYZb
         6k1NbAsWBeHuQg80UbiBor9sx8ax0BGdO1/5UJcQK9MGNKlUO1Vv0xoozfqZJ0XzwaI5
         aSOsvlI/mVLEH8B/lAYEyEVr2CDZU2A8NS7XW9aTGisAOfC6KmM5DXVrv/b7GBhJxdQ6
         vbTk1DSHlMzochhSmyscH/7+nbWT+6KOMvz3643KQIiTnOBn5mBExYwhTGpMADOS3UJi
         7owpN/o2YmuIFkxblEWJzyrbFPTJckUE9X90SrjVauxtRExDS86E1a1qRW8Rk8uvZwsN
         4Ftg==
X-Received: by 10.50.17.166 with SMTP id p6mr14501334igd.12.1365631934140;
 Wed, 10 Apr 2013 15:12:14 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 15:11:33 -0700 (PDT)
In-Reply-To: <20130410215658.GC6215@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220786>

Jeff King wrote:
> It's not that it's not potentially useful. It's that it may be
> surprising and annoying to users who did not want that.

Besides, I'm not able to imagine one scenario where this is the wrong
or annoying thing to do.  Can you provide an example?
