From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v8] Add Travis CI support
Date: Tue, 1 Dec 2015 09:43:45 +0100
Message-ID: <A529A168-CC08-4F8F-B46D-3DF5EAA8EBB9@gmail.com>
References: <1448616207-45035-1-git-send-email-larsxschneider@gmail.com> <20151128171223.GD27264@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, tboegi@web.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 09:44:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3gXS-0003br-B1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 09:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbbLAInu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 03:43:50 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33364 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339AbbLAInt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2015 03:43:49 -0500
Received: by wmec201 with SMTP id c201so193851602wme.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 00:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uz4NovRaAhpYl43ZJizTJzU3E5QW969p4qC2sFdcd9Y=;
        b=kcrGBykdOz/Rwic6NRiX1RORXVa3xkwuc1nlSNSbkibEt70sumvvgCYuiCYE3qP8C+
         uvuzdxqhrR1fAZNqouH7wNTeSQilSfQAg90tJZ7ziX/wSNXKanXw7/9vC3TA+qlTBvK+
         dOrRLREbjEqBPXRHueIsHXvnC40tCV8P9DZqNdyiJwWyGYChlg4vcNKbW4D+5Qcw076y
         9LpmJKZVImIaoxodY645p35cNpmyH85GQN7eqI9mjXkPIuD3jBiwr7g9zUsOQ5bhF9Vk
         hUZj+Pn4y+haJMrpurUbaIaW+qSdNxZMukpJSifLyI1ehx/afZ/wS/giMc28NiUD6DkE
         tc/Q==
X-Received: by 10.28.127.141 with SMTP id a135mr32618394wmd.69.1448959428404;
        Tue, 01 Dec 2015 00:43:48 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB7751.dip0.t-ipconnect.de. [93.219.119.81])
        by smtp.gmail.com with ESMTPSA id i84sm25199089wmc.20.2015.12.01.00.43.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 00:43:47 -0800 (PST)
In-Reply-To: <20151128171223.GD27264@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281833>


On 28 Nov 2015, at 18:12, Jeff King <peff@peff.net> wrote:

> On Fri, Nov 27, 2015 at 10:23:26AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> diff to v7:
>> * remove NO_GETTEXT patch and install gettext on OS X to compile with
>>  no additional flags (thanks Torsten)
>> * fix P4 version (15.2 is the latest one available)
> 
> Thanks. I don't have any other comments on this one. I guess the next
> step is for me to get git/git signed up for Travis, and then merging
> this to 'master' will have the desired effect.

Thanks! You're right, signing up git/git for Travis should do it. Right now it is configured to build all branches on git/git that contain a travis.yml. That means if you merge it to pu or next then we should see builds already.

Cheers,
Lars