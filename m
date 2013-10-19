From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sat, 19 Oct 2013 07:00:44 -0500
Message-ID: <5262746ce10dc_4e9f1021e84b7@nysa.notmuch>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Ben Straub <bs@github.com>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Thomas
To: Thomas Rast <tr@thomasrast.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 14:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXVMl-0006BN-GH
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 14:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab3JSMK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 08:10:29 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:51826 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361Ab3JSMK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 08:10:28 -0400
Received: by mail-oa0-f52.google.com with SMTP id n10so1423815oag.39
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ow4A+kbxBkvxc7gkh8uj/MT2rVSiMUMqLWq02ifozmg=;
        b=HdQSJ15o98jbxHO7+4g3VR5oIgOZhz27TddH+iRgSe/Y04qQCFpEGNV5TbKiNbp0Ip
         POvOw36hYCqOMsMeHCm3pDAQTHcVRFHPi84frJe1f2Pjf3+lDgZqxUi5Z19vh+FzBfsg
         aoTqFdGlCq7zkOn0AP5HCKKxj8t1q+oizhC+vzInelbNda10TZ6c7v6qoDgUGgLIl7CY
         4rGqnBsvl1JjV6YjrHot9FK/a1d+0c7vfkAFe2ylOKxciueQJVCyGtKDcs4JqiondWC7
         D1UAta/BVZro/6WLIFxe0pjUZJcZIMi5lxKQOnCqPDjXVBlVg1P/k3orW1cppII1ZZr9
         mh/A==
X-Received: by 10.182.220.225 with SMTP id pz1mr9336072obc.51.1382184626282;
        Sat, 19 Oct 2013 05:10:26 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm15010604obc.10.2013.10.19.05.10.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2013 05:10:25 -0700 (PDT)
In-Reply-To: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236399>

Thomas Rast wrote:
> * Diminishing returns: Git is too mature, with little low-hanging
>   fruit left, making such projects harder

Too mature? Aren't there other projects that are "too mature" as well? In
particular I'm thinking about the Linux kernel.

I think it's not about maturity, but how they deal with change.

> * Does libgit2 want to remain under the Git umbrella, or participate
>   on its own?

Personally I don't see what libgit2 has to do with git.git. There isn't even
communication between the two projects.

-- 
Felipe Contreras
