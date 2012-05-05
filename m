From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: recipe to use git for deployment
Date: Sat, 05 May 2012 00:30:27 -0500
Message-ID: <4FA4BAF3.10601@gmail.com>
References: <jo283q$kna$1@dough.gmane.org> <1336190286-sup-3813@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 05 07:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQXZk-0003tC-Qw
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 07:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab2EEFac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 01:30:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35457 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2EEFab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 01:30:31 -0400
Received: by obbtb18 with SMTP id tb18so4976746obb.19
        for <git@vger.kernel.org>; Fri, 04 May 2012 22:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=QNxWJNu/h9fkFbFL1uVmDOCtrCXekfprJks7sPd3M3M=;
        b=Rudh1prLRgs4yIm0NcO/gp/AYX/IWYEcUv/y0xGptOcIc9KiaLLqdyJdfIbgfUmu4f
         e2StqvA1GPxz0/cvHdJljihI6ww4yF9tl6luozczcNhSE8ARvJAsuvOSjS27X+JvNUCy
         Vr7olQDI8uzMmsl1NpqB0QFQNZctclyH+ioVXKdBc0oT7lpvIMZMzb0qIJa0b1t7hcDk
         Y+QgnJo3dOpmv1ml2LVcEeTSWxSPhxtimjqPkIwooPHZkHQ6HnlHYswTnBQK0N6DyIF1
         k6GiPbsm/4nBqv+mrmczhJ+9kMSPIY87S4cwxMen5g1ZKo3amli7tC/IK12Zyy4/Mnof
         lWLg==
Received: by 10.60.10.231 with SMTP id l7mr2072537oeb.4.1336195830703;
        Fri, 04 May 2012 22:30:30 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id bk8sm11369007obb.0.2012.05.04.22.30.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 22:30:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1336190286-sup-3813@nixos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197096>

On 5/4/2012 11:10 PM, Marc Weber wrote:
>
> If you really care that much about history why not push a zip file
> using git archive --format=zip and unpack that on the deployment
> server instead?
>
I summon forth the ents to do my bidding
with one command to find them:  --format=tar
one command to transform them:  --prefix=deployed/path
one command to arm them:  config tar.umask (executable bits)
one command to gather them:  tar -A
and one command to bind them:  gzip

(We don't have the new tar with the transform option)

They are faithful and true and have won many battles, but I fear they 
may be too slow and lumbering for the gathering whirlwind of patches 
about to descend from above and legion of servers encircling them on all 
sides.

Interestingly, git-archive was not intended for deployment, but it does 
pretty good at it.

(Sorry, I haven't even read LOTR, but couldn't resist the opportunity to 
use the word 'ent' after reading about it in git-glossary ;)

v/r,
neal
