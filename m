From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Thu, 1 Apr 2010 18:39:24 +0530
Message-ID: <x2zf3271551004010609l9edc6bf3jc9e8b70daca63f37@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vaau6q18q.fsf@alter.siamese.dyndns.org> 
	<4BA1FC39.10300@web.de> <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> 
	<b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com> 
	<4BA3329E.6050304@web.de> <4BB21F6D.7070804@web.de> <7vd3ylv4oq.fsf@alter.siamese.dyndns.org> 
	<p2nf3271551003302058ve6b54731h1bea42b5c6605928@mail.gmail.com> 
	<7vd3yjsriz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Michael Witten <mfwitten@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 15:10:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxK9u-0002jO-2x
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 15:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab0DANJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 09:09:49 -0400
Received: from mail-gx0-f209.google.com ([209.85.217.209]:37590 "EHLO
	mail-gx0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815Ab0DANJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 09:09:45 -0400
X-Greylist: delayed 88252 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Apr 2010 09:09:45 EDT
Received: by gxk1 with SMTP id 1so1003934gxk.16
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/f/qsvJgCwi1uAipoQs/oTUS9MOXU/I6hXISIwhK7v8=;
        b=R6HFlf+4Yc2we5fp+VKP5NaCXuzyXa4+L7wH25brWJDuOlgIwRLD9GcxmtjHoPmzkL
         R7E5U85mw7tCiEc6vPQXmvoOSCCCtiUN2vmyL4QG7JTX3KIyXIs5cOP+sSbkjb3AGVuo
         dIr50fRpSUiw3mSbt76G9e6AcVd1tj2aYTMv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kBzt3eYFlusRFKlXvuc0aGucbnNL/DjkM1fpuWO/Xh3W+4BbgyxheXfEUvbxWWGSFb
         TEzOSZGJM/aegHqS6RrfpNzVqvtlaqKcFXl7BvNxv3qOAu5b/eBxr2+oaXm+4nayVDZX
         xi5gLFjInbmm2OZ8TH1kZoYXKkAzfJytcIma4=
Received: by 10.90.69.14 with HTTP; Thu, 1 Apr 2010 06:09:24 -0700 (PDT)
In-Reply-To: <7vd3yjsriz.fsf@alter.siamese.dyndns.org>
Received: by 10.91.136.20 with SMTP id o20mr1411612agn.12.1270127384336; Thu, 
	01 Apr 2010 06:09:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143728>

> I think you are thinking backwards. =A0If the user always does a perf=
ect job
> before making each and every commit, she doesn't ever need to learn
> "amend". =A0Otherwise, she will learn "amend" way before learning to =
switch
> between branches to work on different things at the same time.

Right. Got it. It's pretty difficult to think from a new user's
perspective actually :)

-- Ram
