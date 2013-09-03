From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] rev-parse test: use test_must_fail, not "if
 <command>; then false; fi"
Date: Tue, 3 Sep 2013 16:56:25 -0500
Message-ID: <CAMP44s2nssnYROFEPaGKLy0f4cSqg63ejpcwKdSxEL6nvv8y0w@mail.gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<20130903170617.GC29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:56:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGyaX-0001V9-SQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760946Ab3ICV4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 17:56:31 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:47116 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760919Ab3ICV42 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 17:56:28 -0400
Received: by mail-lb0-f176.google.com with SMTP id y6so5407769lbh.7
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QyA3DWazaYv8CZd2w6fNdYlB4taVwpzgtQxnmO+sCw8=;
        b=AefieDzMUXLsujAKtuLM9ddwLI1k4F1eT+c1hpmHrWT+qauyTEv5u6X+tNdsx4wk5x
         z2KjD4hATZ6kU9STxBvpUUHvxErQpzPOBecaSo6KlczLOaiib0wbUN0N8SR4sJb/kpRu
         L1ji5crIIe3u6AdsyOVfkoxAmcaalGUTKw6ob3QaoBokv0AS6dcWuwHm0odZI62Ka2n4
         T3KnwuyqsEYfv/bBriYgg6LxBAe2T4AVPZkuyEt7vQ0S64qXZ7qUv+kvW7bArC1edkSU
         BeYf0w49xqBmwK2Z+A0oWSaUwhRxF1vmAHnO0iWFHu+HjkN6B5x29QmPtzInyVdTRmfZ
         ax4Q==
X-Received: by 10.112.29.147 with SMTP id k19mr27386332lbh.9.1378245385668;
 Tue, 03 Sep 2013 14:56:25 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 14:56:25 -0700 (PDT)
In-Reply-To: <20130903170617.GC29921@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233787>

> rev-parse test: use test_must_fail, not "if <command>; then false; fi"

That is way more than 50 characters, and doesn't tell me why you want
to do that.

-- 
Felipe Contreras
