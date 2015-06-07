From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCHv1 1/3] git-p4: additional testing of --changes-block-size
Date: Sun, 7 Jun 2015 12:06:05 -0400
Message-ID: <CALM2SnZ7o1P8+NadEKWVuXD+ajHDdiBeM8xrLfnnKuwHGGjJbA@mail.gmail.com>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>
	<1433672505-11940-2-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 18:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1d5t-0008AV-Dd
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 18:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbbFGQGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 12:06:07 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34210 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFGQGF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 12:06:05 -0400
Received: by payr10 with SMTP id r10so79497145pay.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 09:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gX5wOpCLMAxlGTlJ7+qDKkRj+Z8JraD/KwEivp0W2Kc=;
        b=eKBNNIrVOHddXLO8ijMXclag7CSAKB4W9AwG0zg9dCsllRgcfs8YomsFmEjzHY3QD3
         De5LFbiRRZTu4nZ9pjgeUkOrXcUE7lmn8YUBMevo/uwZhngncuYPpNS6TyXtNtpWRO7z
         qUfQn7lHeSLg9bhy9myuK+neeJxq7vP2ur4F0xEdvhef19rsWTZl3WAkebDG1B1MyOvC
         b0Z9vuc3SSo1n0ZePIFqGOHk0mElSNUdY6/sGfO64HBjjYmDIqMz1RxyL78R0gBkmYsZ
         S10UNlQZ1bsn8AHrQEXRgjxz77cxdMbfdgb3mZd5ByH/SXmzQLsiBiGt0mWhdQ+t4gyA
         CTRg==
X-Received: by 10.68.94.129 with SMTP id dc1mr22478166pbb.8.1433693165258;
 Sun, 07 Jun 2015 09:06:05 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Sun, 7 Jun 2015 09:06:05 -0700 (PDT)
In-Reply-To: <1433672505-11940-2-git-send-email-luke@diamand.org>
X-Google-Sender-Auth: NGEILtbmv1wJ3J1ArWlryEKfZGs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270971>

I'll add in reviews since I touched similar code, but I don't know
whether it's sufficient given I don't know the code very well.

Anyway, these tests LGTM. Having a smaller test repository is fine,
and the new tests for files outside the client spec are a great idea.
-Lex
