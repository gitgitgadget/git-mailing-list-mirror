From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: thoughts on a possible "pre-upload" hook
Date: Tue, 22 Sep 2009 15:50:09 +0530
Message-ID: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 12:20:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq2Tz-0001NI-PW
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 12:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbZIVKUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 06:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbZIVKUI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 06:20:08 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:36878 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755311AbZIVKUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 06:20:07 -0400
Received: by iwn8 with SMTP id 8so2075528iwn.4
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=/aD56D8ba5Pr9zKHw64cXjut/AtNrLknTmhHyqbI1v0=;
        b=c0w70tg4Zbsqt0Ua68wQD2tU9Lx/T5VB9lMsnsKlol7dMmKSP64qIjAhEB2cjNqilX
         3rEeuEiht/mNcMoaUEK4e6hCKU7cSj5+w4S7JtJ9QNarfDdyxziwBQF7pVO/l1iIowJ8
         CobzzFaeJCktC13lznpS8rZLR0iJnheuCi3X0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=E2M+O/M2cwixT4MGry1aIRLh75DJby8w6wIAsZdSNeq2Fiq4H9B6SXO8euU1UiJONc
         HCEehIAImgR7lLvanGPscyyAygfMd49WW3/sLNiPQtvZd7DcqI2LTfur6R+Gt0XFXjMC
         eht3HmzHWx2CCzKcmsusi1Hrn6QSIt+FVHl4k=
Received: by 10.231.40.227 with SMTP id l35mr1615688ibe.28.1253614809760; Tue, 
	22 Sep 2009 03:20:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128929>

Hello,

As git is used more and more in corporate-type environments, at some
point it becomes convenient to have *branches* (or more accurately,
refs) that are not readable.  The simplest way to do this (from git's
point of view) is to allow a "pre-upload" hook, rather like the
"pre-receive" hook or "update" hook.

I don't know the upload pack protocol enough to know whether this is a
stupid idea or not; please tell me if so :-)  But things that were
seemingly "impossible" in the early days are being talked about now
and even being implemented so I felt brave enough to ask.

I'm afraid my C programming days are long gone, but if anything can be
done in shell or perl, with a little git.guidance, I'll do whatever I
can.

-- 
Sitaram
