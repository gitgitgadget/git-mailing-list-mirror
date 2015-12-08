From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 1/2] git-p4: support multiple depot paths in p4 submit
Date: Tue, 8 Dec 2015 10:48:21 +0100
Message-ID: <14B51656-26D1-4805-9F07-102CBD81B387@gmail.com>
References: <20151205112203.GA15745@hocevar.net> <F328D5D9-754A-41CC-A7B2-993B9315ED33@gmail.com> <20151207185129.GA48528@hocevar.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>
To: Sam Hocevar <sam@hocevar.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 10:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6Esu-0006XM-S6
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 10:48:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbbLHJs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 04:48:27 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37333 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbbLHJsZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2015 04:48:25 -0500
Received: by wmww144 with SMTP id w144so22357778wmw.0
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7c0u/dkEVVMcSp5UREmL3vpTWsHpWaRdiRCTf5iMCI0=;
        b=JYLPhchzu2zunJdOTwb9BMS0jOQ37Db/0U+TyCIHzX4lRsH4vVINlRac8vzTH6jA7t
         XT8TKNiA1mnuIC8isj/VuC+20yV4S0wZgNtWHGfntit4L2YKZQjt7oWtdAiJUKNC/frd
         pLXGrRFGUhQJj2Ikyn5Rgt2cuo+7PQfrf05H468cXU6ofzrxhO1bmhU3Kot2Ow3ttWH0
         on2Emq7VheLERwzCaKEllEBJSl1OsI67oA8NP0C6wxXfk/AESBFgSV9Bc6KdEtstQZvN
         5YC9EveFDQqTZDbofsgPAzN3MO/icxjiAqx/palo8DfaONagQPu3+cGxMF+F1pmUizys
         NUqg==
X-Received: by 10.194.237.35 with SMTP id uz3mr3152608wjc.55.1449568103891;
        Tue, 08 Dec 2015 01:48:23 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB6FA0.dip0.t-ipconnect.de. [93.219.111.160])
        by smtp.gmail.com with ESMTPSA id t5sm2645876wmt.1.2015.12.08.01.48.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 01:48:23 -0800 (PST)
In-Reply-To: <20151207185129.GA48528@hocevar.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282153>


On 07 Dec 2015, at 19:51, Sam Hocevar <sam@hocevar.net> wrote:

> On Sun, Dec 06, 2015, Lars Schneider wrote:
>> Thanks for the patch! Do you see a way to demonstrate the bug in a test case similar to t9821 [1]?
> 
>   Not yet, I'm afraid. It's proving trickier than expected because for
> now I can only reproduce the bug when the view uses multiples depots
> (solution #2 on http://answers.perforce.com/articles/KB/2437), and
> unfortunately the test case system in Git was designed for a single
> depot.
> 
>   Would a refactor of lib-git-p4.sh (and probably all git-p4 tests) to
> support multiple depots be acceptable and/or welcome? I prefer to ask
> before I dig into the task.

Can you outline your idea a bit? Are you aware of the following way to define client specs: [1] ? Would that help?
I haven't used multiple depots, yet. Therefore please bare with me :-)

Thanks,
Lars

[1] https://github.com/git/git/blob/362d2fc2f8ab9ee22072f76fb36ec16918511944/t/t9821-git-p4-path-variations.sh#L109-L111
