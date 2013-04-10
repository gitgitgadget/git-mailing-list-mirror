From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 02:53:04 +0530
Message-ID: <CALkWK0nxpoLL4zoinE4j8y8NLHo0-b=PcimNLykCjMjOpWYEfQ@mail.gmail.com>
References: <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net> <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net> <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net> <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
 <20130410211824.GC27070@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:23:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2Uh-00076j-9R
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553Ab3DJVXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:23:46 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:37030 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934746Ab3DJVXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:23:45 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so847712iec.8
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=vCiSZsU2CzAE2/I8qZtcS1NxC2Jo2m4EkOxSioiPoss=;
        b=yFG2bKZt4zzN+g/TeKznAWM9308/DVjMKdVk5LlhXWhYTBuq6icwmBNz40MPUXB6tu
         pX83CLwQfHGsfUDsvGDQzTE+uf56AO2WjadX8EviPqpJO3PKuXtnnQPk2jjOalttMuio
         Lj4ennW7GByJ15I/7Rva97fNElCb8yioX0peMinpvaKEOcJFdkMmWpYAxsGQtmEfZp/s
         V9X3R9zk4VtKYzTNsxNI68BDcqkbUf0pQvNJt4u8TattP/d+YrS3Cpfv0mbjrQ5vWmKN
         +e0oEpkOLJnwG2hkX6BpEb1bKm3wvk+7lx4PeizXewBnAjsrn2PsEY3gzw94BY5c2gS1
         9adQ==
X-Received: by 10.50.50.71 with SMTP id a7mr14231574igo.14.1365629024662; Wed,
 10 Apr 2013 14:23:44 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 14:23:04 -0700 (PDT)
In-Reply-To: <20130410211824.GC27070@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220772>

Jonathan Nieder wrote:
> When people disagree about sane defaults, that's a sign that we didn't
> understand the problem well.  Often more thinking can lead to a
> simpler answer.

Okay, let's see if we can all agree.

In a different email, you wrote:
>        git push master
> ...
>  a) Error: you didn't tell me which remote to push to.
>  b) Just behave like "git push my-personal-remote master".
>  c) Behave like "git push origin master".

Here, I'd argue for (d): push to branch.master.pushremote/
branch.master.remote/ remote.pushdefault/ origin.  If others agree on
this, we can break "matching" appropriately, like I proposed earlier,
to make everything consistent once again.
