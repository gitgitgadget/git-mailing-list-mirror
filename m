From: Max Kirillov <max@max630.net>
Subject: Re: [ANNOUNCE] Git v2.2.1 (and updates to older maintenance tracks)
Date: Fri, 19 Dec 2014 08:40:54 +0200
Message-ID: <CAF7_NFTwn5DcxJeRYHEUv5ae6-rh-8r7PXT81uOdPxvT2jtvug@mail.gmail.com>
References: <xmqq61d87jew.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: johannes.schindelin@gmx.de, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 07:41:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1rFH-0004DH-Jv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 07:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbaLSGk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 01:40:57 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:53779 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbaLSGk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 01:40:56 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so469342wgg.28
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 22:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xTHgUE82VVAmQmI+rpDL/dpnmembPGRla5B6JKBTiKQ=;
        b=h3RwKnqCtgzVvuVoKbqtUE11Bold028kJU2R4/fU+Ui6wozlz9jG8ikvgqJrAgoPOm
         pp1+abFU1vSXJuT792i9Bcn7grsUsrnpP2UbEvZ53CtB97qNsMr6X4Kr8I2b3h2iQQIS
         lRqroRfhDHkV6HFp5uanc5s9MKW/sdmRaEExEXn5YTef+tT2uLT6hia0Xs2O81belwsM
         N0PFg2FhP5ZvWQGEXXNVmCLSRkmoU7ZmPBOgLx7Jj7HZCPHewSlurFWpxdb/QT2vhz3w
         ATG83LOfJG+5gzysv+XmxkZD4jC/F7F+x6X3jbJJV/TLMOvQe8qEk2wuBkPR3gdEwhKR
         tXNg==
X-Received: by 10.180.95.97 with SMTP id dj1mr2610754wib.43.1418971254808;
 Thu, 18 Dec 2014 22:40:54 -0800 (PST)
Received: by 10.180.218.197 with HTTP; Thu, 18 Dec 2014 22:40:54 -0800 (PST)
In-Reply-To: <xmqq61d87jew.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: -qa3aFGjcUA6YaZoKLft_kvUPs4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261548>

Hello. Thank you for the fix.

Would it be more reliable to compare inode of directory in question
and ".git"? (there is [*] for windows). So that any unspotted name
equivalence is prevented to cause any harm.

*) http://stackoverflow.com/questions/7162164/does-windows-have-inode-numbers-like-linux
