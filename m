From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: diff/merge tool that ignores whitespace changes
Date: Sat, 01 Sep 2012 22:41:20 +0200
Message-ID: <504272F0.3070701@web.de>
References: <fab86cd5-e3cf-4ddf-aa00-aafe44e8ce8c@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Enrico Weigelt <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sat Sep 01 22:41:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7uVW-0004gH-3H
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 22:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab2IAUlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 16:41:23 -0400
Received: from mout.web.de ([212.227.15.4]:64964 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755650Ab2IAUlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 16:41:23 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LgpYk-1Tuwcx1EIg-00oOY1; Sat, 01 Sep 2012 22:41:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <fab86cd5-e3cf-4ddf-aa00-aafe44e8ce8c@zcs>
X-Provags-ID: V02:K0:p3pf0m6x3wa4O1owysdW1TA2XlDOfODTuR+7aCBf93L
 0rjPxFh7lBfmoux+8yhhWr6UgtxdHP70pps6tvKU7y6ZOnC/D1
 7Jes7UcKYg1vo3XOZMyHbA+H+DCUEdfnMgfWBdr+8bXAwtErEI
 y4rgI3zEgf6ZTfKSEDvQBlO8NjwK4JQSnVwSy9RxO7DV99pTbv
 /bgLiIhRXYDv6SCQPKIsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204650>

On 01.09.12 22:11, Enrico Weigelt wrote:
> 
> <snip>
> 
> Thanks folks, but that doesn't solve my problem. I'm looking for something
> that's usable on command line or in scripts.
> 
> Usecase a)
> 
> * git-diff or git-format-patch or tig should not show differences
>   that are only whitespace changes (eg. differing linefeeds or
>   tabs vs. spaces, changed indentions, etc)

Would that help ?
git help diff
[snip]
     --ignore-space-at-eol
           Ignore changes in whitespace at EOL.

       -b, --ignore-space-change
           Ignore changes in amount of whitespace. This ignores whitespace at
           line end, and considers all other sequences of one or more
           whitespace characters to be equivalent.

       -w, --ignore-all-space
           Ignore whitespace when comparing lines. This ignores differences
           even if one line has whitespace where the other line has none.
