From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 16/20] revision: trivial style fixes
Date: Sat, 12 Oct 2013 06:18:42 -0500
Message-ID: <52593012d7d28_5f30b31e74588ea@nysa.mail>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
 <1381561636-20717-10-git-send-email-felipe.contreras@gmail.com>
 <52591180.3010103@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Stefan Beller <stefanbeller@googlemail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 13:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUxMO-0008JA-12
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 13:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3JLL1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 07:27:40 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:57193 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab3JLL1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 07:27:39 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so3478835obc.8
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 04:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=sgAKze76rW0De0/LJ2tyXNl2Dm6/fgNO+xa/cSz3IuE=;
        b=yKp2EIJHsfJmBeLfgaLuUGWMAMUEr+QoPBlqZ18UCUGfagtlb9eWZRX9vsKM3zf4qg
         dnsovUhDVJIUC09PtiDcqDq1s7+/CgxVBPuLDHf8L5TgwLVt6zOx5XCMStSHTb3TW/IZ
         A0q7yIQDOUJEqH39nzH5Q3vD7zCytX9gOWrzk8qMGVp02sVKTxXkx3v1zCuDB8XbrUyM
         Mi/ZHcurckCxUiRG4iUq6IOBkFRnsn9o3RaLwvPdBOx43w6sqp6Z8ltc/nSyWmdE7Jmo
         sW0KO3e3A9gZ1tMRH8LO0Tlo2vJroje1ZQpGUsXkN2HJ+UJDwECs6mrjYkZ2RBVLj/VF
         ja+g==
X-Received: by 10.60.58.71 with SMTP id o7mr79371oeq.51.1381577259374;
        Sat, 12 Oct 2013 04:27:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm29586153obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 04:27:38 -0700 (PDT)
In-Reply-To: <52591180.3010103@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236047>

Stefan Beller wrote:
> While talking about trivia, what is the projects stance on
> such constructs here?
> 	while (foo)
> 		bar();
> 	foobar();
> 
> I've seen an empty line between the bar(); and the foobar(); often, which suits readability.
> What's the stance on such an empty line here?

I don't think there's any guideline on that. Personally I choose depending on
the context.

----
void test(void)
{
 	while (foo)
 		bar();
 	foobar();
}
----

----
	while (meh) {
		/*
		 * bunch of stuff
		 */
	}
	
 	while (foo)
 		bar();

 	foobar();
----

Cheers.

-- 
Felipe Contreras
