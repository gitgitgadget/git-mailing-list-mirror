From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [RFC/GSoC] Proposal: Make git-pull and git-am builtins
Date: Wed, 25 Mar 2015 21:32:28 +0100
Message-ID: <55131B5C.90109@gmail.com>
References: <20150324163730.GA8366@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 21:32:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaryj-0001YO-R0
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 21:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbbCYUcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 16:32:36 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35761 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbbCYUcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 16:32:32 -0400
Received: by wibbg6 with SMTP id bg6so39528366wib.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2TiP9kau69HPpiUvIvamYGS7ffq3Bs6yFe7fZuontxo=;
        b=CttH9RisNn64GJGW0RVmJDk7xLIjd6lLU+NknlfTxlE4+BJICtuu7lPursMe+M6nwz
         oUXw3WXpJGTMaa5FHieQ40BvKxKu3SDqYCg8BNFBKdl3b4+D24MQi69B52soZFLIRH4V
         Z2rBpPyETUZVZEdtj6BE+UxYEJ3Uvl4sVSrYudTckrm/001uT0CsSvhW25lJUPqKq5Nu
         BA6mipBo7y+cQiYGL/KzjMpF3QcHHDOtwo11O2Y1KesXtPqa+ZqClfL6B+t0DDmqHFRp
         KETFV+PU6aJF28CecWxO+w2QTJm5jcEbPRUSzb/RDfdCOMru6+mqPGM0rNYmvB33yI8e
         pZtg==
X-Received: by 10.194.24.35 with SMTP id r3mr21041688wjf.125.1427315551139;
        Wed, 25 Mar 2015 13:32:31 -0700 (PDT)
Received: from [192.168.188.20] (p4FF456B9.dip0.t-ipconnect.de. [79.244.86.185])
        by mx.google.com with ESMTPSA id dc9sm22206925wib.9.2015.03.25.13.32.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Mar 2015 13:32:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20150324163730.GA8366@yoshi.chippynet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266302>

On 24.03.2015 17:37, Paul Tan wrote:

> I'm applying for git in the Google Summer of Code this year. For my
> project, I propose to rewrite git-pull.sh and git-am.sh into fast
> optimized C builtins. I've already hacked up a prototype of a builtin
> git-pull in [1], and it showed a promising 8x improvement in execution
> time on Windows.

I cannot thank you enough for starting this effort. As one of the 
project owners of Git for Windows I can confirm the (shell) script Git 
commands to be a major source of pain.

I really hope your proposal gets accepted and you'll be able to 
successfully complete this task.

All the best!

-- 
Sebastian Schuberth
