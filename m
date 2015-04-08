From: Mamta Upadhyay <mamta.upadhyay@gmail.com>
Subject: (unknown)
Date: Wed, 8 Apr 2015 15:44:22 -0500
Message-ID: <CAM9_S8jip3q-vUWFHCWP6ia2wrKOxDpxz2zLSQZPQvAQ0xmKrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 22:44:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfwpt-0006TP-9x
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbbDHUoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 16:44:25 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36537 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbDHUoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 16:44:23 -0400
Received: by qku63 with SMTP id 63so96140311qku.3
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=b9/lPP+N4MeFdGo7yjCYa85wb1Y74CPbewgNN9dgQV8=;
        b=yc0/Ah54aUUStxQ0nER0A1Ftz3W7K/MyxNA+ub1u+zkiaY92vvgXOTggv0LKjbhxfE
         nOKCZ3MXRPugvj91NsyDgPjP7Idiyz22wDnUQUu2cx/Wit3OnqE9xTdTkYfSfy92+W/A
         oMEf62NZmGuGV1LapM97QPDAsHLUhc5xalwNp5ClG1R6kXtmbJrH1wD50jmlMdOXTReI
         6qHON4/sqthAk5MWFuXO4tKyN4m82isq8YNk2b5umnYf6tfuKEhkbcoS2V0MWye8P9V8
         L/xhXlNeaeGzOe+SGQxu7ectBwkiGYYNI0k1ghvSr4omKUwRHhrSM0SdZdzj+xEFcC74
         rgmQ==
X-Received: by 10.55.56.20 with SMTP id f20mr52753150qka.26.1428525862548;
 Wed, 08 Apr 2015 13:44:22 -0700 (PDT)
Received: by 10.96.49.102 with HTTP; Wed, 8 Apr 2015 13:44:22 -0700 (PDT)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266973>

Hi git team,

I tried to research everywhere on a issue I am facing and emailing you
as the last resource. This is critical for me and I needed your help.

I am trying to run the latest git 1.9.5 installer on windows. When I
run strings on libneon-25.dll it shows this:

./libneon-25.dll:            OpenSSL 1.0.1h 5 Jun 2014

But when I load this dll in dependency walker, it picks up
msys-openssl 1.0.1m and has no trace of openssl-1.0.1h. My questions
to you:

1. Is libneon-25.dll statically linked with openssl-1.0.1h?
2. If not, where is the reference to 1.0.1h coming from?

I am asked to rebuild git with libneon-25.dll linked against
openssl-1.0.1m. But I am having a feeling that this is not needed,
since libneon is already picking the latest openssl version. Can you
please confirm?

Thanks,
Mamta
