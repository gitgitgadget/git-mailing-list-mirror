From: Michael Migdol <michael-spam@migdol.net>
Subject: stash-p broken?
Date: Mon, 28 Jul 2014 17:38:10 -0700
Message-ID: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 02:38:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBvQl-0000XV-Fe
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 02:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbaG2AiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 20:38:11 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33048 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbaG2AiL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 20:38:11 -0400
Received: by mail-qg0-f52.google.com with SMTP id f51so9327095qge.25
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 17:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=XcKTTLqqpudDQXHKoCqyOmjKawKYA22R61Wx5s3W3w4=;
        b=OrXZQbka1aB3bxE9NkpRm8q7WZRW0KNRgQADVoBotpTBa168fdt4DMVsmft7wcq9S/
         ZHRDo8vE3eHIFfe1TieFdXRYT2EtQ2oaozn/QFu2diPl6hsV1RAQE4Q53FZDcrHAaqzm
         jI1eUqw+mFg8q+OafftGrIRrGXUt2SPtRyQiIuiHpfQLFDcLZjtGyh1LaM9EUJtiXLrj
         QLpQ7K9gV8ClpmvgtFEN4MSVqK4AmuEHkN5zrc3KzoCX4aCHk95PGvBUzyJ4KHhValKt
         XAacQCbHxXqqsdHG16ptJw9oXWwQ1G6fJFxsHYKf7GNp6wWaPSI9RtJu8M5xHWS+fWbZ
         f1Sg==
X-Received: by 10.224.95.6 with SMTP id b6mr24828423qan.17.1406594290168; Mon,
 28 Jul 2014 17:38:10 -0700 (PDT)
Received: by 10.96.103.70 with HTTP; Mon, 28 Jul 2014 17:38:10 -0700 (PDT)
X-Google-Sender-Auth: aAE7kH5vgW6rs69gXxjXxDmbY88
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254387>

I recently upgraded from Ubuntu 13.10 to Ubuntu 14.04.  After doing so,
"git stash -p" stopped working.  (It apparently is ignoring the -p
parameter).  I'm not sure what version I was using previously, but after
some experimentation, I see that:

version 1.7.12.2 : stash -p DOES work
version 1.9.3 : doesn't work
version 2.0.3 : doesn't work

Osse on the IRC channel was helping out with this and saw some very odd
behavior while trying to bisect where the regression occurred;  he said
he'd comment further tomorrow.  But I thought I would send a note to the
list for archival...

Cheers,
Michael
