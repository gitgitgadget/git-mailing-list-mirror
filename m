From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Thu, 08 May 2014 14:56:27 -0500
Message-ID: <536be16ba5ef1_3ce710a12ecdb@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <xmqqha515ebt.fsf@gitster.dls.corp.google.com>
 <536adf96f37ec_3caaa612ec69@nysa.notmuch>
 <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 08 22:07:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiUbF-00020S-AK
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 22:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbaEHUHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 16:07:19 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:65450 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604AbaEHUHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 16:07:18 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so3705819obc.1
        for <git@vger.kernel.org>; Thu, 08 May 2014 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Sh/mpUx8KxJR0tJYpxVdu4UKDz1oqGuiGp5EvsZ+f5Y=;
        b=ja89WXHdecfPPygWQQSr5zwEuwj4oMsnwBAvfjsx56bB66k5qgA9JCYFbk+LMpIHI8
         PR89nwSngRCahs9M245pQc3jyMig73GRFCdmMYHCJxfxPZ2JgYkpujN12sBGdjTFt/2X
         Q9QGBXtYrMdWTkQxog3UZa/S93MhkQilzyLxhjJ5q0cdc3EErpKmyT1C1zK/zivcP4fQ
         V+ATvJcrLmpNuqIRbV2zR7ZoZPV3CflzlOnl+Vo4tT8+KbDKkvQr0+XK+tA+OepiKTKz
         Jl3uM5LCvqRV88AQWBHftApqZfckbAeUqfssCSPvaFzqTlXhYT4wmB3NTzsp+va0++El
         BswQ==
X-Received: by 10.60.131.40 with SMTP id oj8mr8075650oeb.14.1399579637861;
        Thu, 08 May 2014 13:07:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id jr2sm4133013obb.8.2014.05.08.13.07.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 13:07:14 -0700 (PDT)
In-Reply-To: <xmqqtx902k45.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248438>

Junio C Hamano wrote:
> In other words, I knew that you are capable enough to track down a
> bug in the code you wrote recently that made it violate the
> expectation you defined in your own tests.

Wrong. The code in question was not recent, it was introdued in 1.8.3,
more than one year ago.

And wrong, it didn't violate the expectation of my own tests.

The code was simply not exercised in the tests.

> There was no room for differences of opinions to come into play, as it
> was just between you and your own code.
> 
> Why would I expect otherwise?

Because most people take attacks on their code as personal attacks, and
they don't fix bugs in their code if they don't like the person
reporting it.

But you know I don't take attacks on my code and ideas personally, which
is more that can be said of most people on the list.

> Do you want to make it a separate follow-up patch with a log message
> that explains why it now uses LookupError (not ManifestLookupError),
> or do you want to reroll the original by squashing it?

I don't want to do anything for a "contrib" tool.

It's already broken in v2.0 anyway.

-- 
Felipe Contreras
