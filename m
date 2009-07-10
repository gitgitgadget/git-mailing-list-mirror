From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH v4] add --summary option to git-push and git-fetch
Date: Fri, 10 Jul 2009 00:33:14 -0700
Message-ID: <4A56EEBA.3070806@gmail.com>
References: <20090703044801.GA2072@cthulhu> <7viqiat965.fsf@alter.siamese.dyndns.org> <20090707015948.GA525@cthulhu> <h35bda$kgv$1@ger.gmane.org> <20090710022415.GA27274@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 09:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPAbm-0007jf-QV
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 09:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbZGJHdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 03:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbZGJHdS
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 03:33:18 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:63554 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZGJHdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 03:33:18 -0400
Received: by wf-out-1314.google.com with SMTP id 26so213471wfd.4
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=bhaZ7JWWGqMTnVAj3emExmaH+knMI6+m4CfU9//Adu8=;
        b=VqCLT9N15vzcr3JLjJrMf1WvmNrjXBTLvChsi0QUknznr8QpuB2PhuTL1FMg3el2lG
         PHUo6RWfNRhj/1uaq/UKQqu353H8SueUJTphg7uUB6S08fOk7F13dfbsLEfwQzdMsyh5
         +4SLGx0swBuX7/9pX9N7gVYssQHcDfYxvT6p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=dWUGl9CpkRAiJNZm5wmuCKFq6F/DVaefvzI2NB1UFAF8IsQ0st9OJHRkrRPlOsxgdQ
         uYO5fDB/WJ4EYXfCAGqDIdPTw9FRAlNeG+GkmK+B2DboVan5tQPIvKNWFxwo19JhiPs5
         C3ifPdrMJkcZTnloL+4hekFBr6hkJso2hsg2g=
Received: by 10.142.126.6 with SMTP id y6mr561868wfc.163.1247211197258;
        Fri, 10 Jul 2009 00:33:17 -0700 (PDT)
Received: from ?10.10.0.4? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id 28sm1567497wfd.24.2009.07.10.00.33.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 00:33:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090629)
In-Reply-To: <20090710022415.GA27274@cthulhu>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123040>

Larry D'Anna wrote:
> --summary will cause git-push to output a one-line of each commit pushed.
> --summary=n will display at most n commits for each ref pushed.
>
> $ git push --dry-run --summary origin :
> To /home/larry/gitsandbox/a
>    80f0e50..5593a38  master -> master
>     > 5593a38 foo
>     > 81c03f8 bar
>
> Fetch works the same way.
>
> Signed-off-by: Larry D'Anna <larry@elder-gods.org>
> ---
>
>  Changes since last version: 
>
>  * fixed the segfalt bug.  commit->buffer was NULL.
>   

Maybe adding a few tests to exercise this new option will give reviewers
a better assurance you've squashed the bugs in previous rounds?
