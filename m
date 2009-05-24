From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] t5500-fetch-pack: ignore output from git init
Date: Sun, 24 May 2009 10:43:58 -0700
Message-ID: <4A19875E.9090109@gmail.com>
References: <1243107282-9259-1-git-send-email-bebarino@gmail.com> <20090524164329.GC22792@coredump.intra.peff.net> <20090524164826.GD22792@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 24 19:44:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Hk1-0004SP-Dr
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 19:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbZEXRoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 13:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbZEXRoA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 13:44:00 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:46330 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbZEXRn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 13:43:59 -0400
Received: by pzk7 with SMTP id 7so2160882pzk.33
        for <git@vger.kernel.org>; Sun, 24 May 2009 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hdXWY6j8aDhEs2pirvqA4FQslA4pa2nVB3E+hVfrOEk=;
        b=u0YQOtzYF3PkqwAvonpq2xQlEMiKHKeV3OSsATN5in9sfiSCKf4Dr0g3WXv9P92m5o
         BXp7mWnchOtz4K7g78JyBT3nVbZruSWvOIYSFXm40TGTlrGdCP1B0UiEm78XEusU5RCF
         870BdkRSFAlQyhQdDHzyYEuKeCFfXm1YwiiEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=YgRU3f72x9TQw0cmJZW68xCPGffsF+txVTJ+JJ76u29WPzdiA92q2Ga/UxSWlxYGZh
         OEzc9ZAMIxJpBGfolvEv1tmvTyCtH09jO1LP1Es2gkToOWgdQsv7+rPCmQSy4XFs0IZB
         4A4jCJkpuRXBCC6NEsvXTf/1jjmIPe2IxUzLM=
Received: by 10.115.91.11 with SMTP id t11mr12729725wal.112.1243187041202;
        Sun, 24 May 2009 10:44:01 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id n33sm7043827wag.34.2009.05.24.10.43.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 May 2009 10:44:00 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <20090524164826.GD22792@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119846>

Jeff King wrote:
> Actually, taking a closer look at the script, I think you could probably
> ditch the '2>>log2.txt' bit entirely. The log file is never read and
> appears to be completely for debugging. Putting the code into the test
> harness means that output will respect --verbose properly, which means a
> separate log is unnecessary.
>
> -Peff

Yeah I sent this off real quick because of the reason you state
(terminal crap). In the end, the test really needs to be modernized. If
someone else doesn't get around to it, I'll start seeing what I can do
to make it better.
