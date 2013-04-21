From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 12:56:13 +0530
Message-ID: <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:27:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTofr-0004cu-Pl
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269Ab3DUH0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:26:55 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:53994 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab3DUH0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:26:54 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so2069836ieb.17
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YYGOadoU5YYIcfNASgDYd+SEWOEL40gi5bi14SD4ye0=;
        b=MPBIWiPs5m8cgXD/55hImdQ4SZbJJ5Acu4zanZlYxmmSRsi2TWP1oc4lI+G/aXJIO0
         anIGcViYzA5OYnCIjJg4JJEBU73ajR2ZYgP4v/oYcS8L2uL2q47KwNR9IyW5skBtnmLv
         wUO4BaPtK8vvtqNosgpRLt0hbxKVW+CUF8+qxWnLaalwiuMOlMPtUxESmWtelR0OXI3/
         LWLdsJrUoCsPQcDSnC4doD6DE8bd/MzkgcQsc+qjZZaNOH+kNTvdTMmhW5VVpNmIhZrk
         2goElXBPVhR5D2qObzzP/sffaOG2K+4ifcfKBFKPVcrqgyKJdiPwSFO1ARh3YfMKxEEx
         SfVQ==
X-Received: by 10.50.17.166 with SMTP id p6mr5574624igd.12.1366529213934; Sun,
 21 Apr 2013 00:26:53 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 00:26:13 -0700 (PDT)
In-Reply-To: <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221905>

Junio C Hamano wrote:
> I think "branch names" was an attempt to make it more newbie
> friendly by sacrificing technical accuracy.  With the suggested
> update (see the review for the previous one), it would be easier to
> read if this part said "options or the revision range".

Why does it have to be a range?  It might well be a list of revisions,
so I'm tempted to stick with the word "revisions".  As I wrote in the
previous email, I think "revision" can be referenced by any one of the
syntaxes specified in revisions.txt (this includes a "committish
range").
