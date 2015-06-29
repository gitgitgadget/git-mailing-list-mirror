From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH] --count feature for git shortlog
Date: Mon, 29 Jun 2015 09:46:01 -0700
Message-ID: <CAKDoJU4MHGa-c=F0m17rgWUCS2xFwiSb1pmDnYztoDnzRaRKCw@mail.gmail.com>
References: <1435540922-12208-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqq1tgvdt9u.fsf@gitster.dls.corp.google.com>
	<CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 18:46:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9cC8-0002G7-Hb
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 18:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbbF2QqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 12:46:04 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:35082 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658AbbF2QqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 12:46:02 -0400
Received: by obbop1 with SMTP id op1so108648196obb.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=MYe35iHHbuMhSjTDA91BN7VNsWRJypttf7c04cEKpsk=;
        b=IfTUymrqpPt06+0GYsMAcM18XRpMCmr6CI9xEgCoRV/EvrQfPg/TMBNdQHpVTGjQYX
         JJcJ3tEu5Kkn71ysiKvqXfXbTcUnatZB7RYEO4DJ5jxC9/OT8YLFlowZbDr2G4BGKSdH
         77IX52/ldb2HkaFYiN8AvAvr1snHXSQtPqg4IanO57iEFZi6IXhVoE4LP17ZXHu30sku
         fUZtto4UGFdTlhoRAUKg/1ztwXuk3xV0exkzTk2UuQTu4OYwz2DRZ5dh9ikSp0+9gOy+
         8yxPKeotawB1Nk7yL6kIMQdIqLEwetVFBOc7Zzl1QqcB0r6DYKhVN5LLZM/UPVmyqJsH
         VJeQ==
X-Received: by 10.60.62.180 with SMTP id z20mr15667556oer.56.1435596362035;
 Mon, 29 Jun 2015 09:46:02 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Mon, 29 Jun 2015 09:46:01 -0700 (PDT)
In-Reply-To: <CAKDoJU4HcGoOS83MKwsQBXztYrDomMd9N-2SKc6iRyNhQQM5Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272973>

Junio,

I appreciate your help. Okay, That all makes sense.

I would note that something like:
 git shortlog -s "$FILENAME:  | cut -f 1 | paste -sd+ - | bc

seems like it run much faster then:

 git log --oneline "$FILENAME" | wc -l

Which was why I was looking at shortlog.  I was using it to sort files
by commit count when provided a list of files, which git rev-list
doesn't really work for.

Anyway I can try and put it in log proper, if you think that's the best place.

Thank you,
Lawrence Siebert
