From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-push: add option --repo-all
Date: Fri, 18 Sep 2009 13:15:59 +0200
Message-ID: <4AB36BEF.5050508@gnu.org>
References: <1253258222-11475-1-git-send-email-catap@catap.ru> <m3r5u43a8h.fsf@localhost.localdomain> <877hvwzkw7.wl%catap@catap.ru> <200909181302.49335.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Kirill A. Korinskiy" <catap@catap.ru>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 13:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MobS9-0006vM-Ub
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 13:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbZIRLQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 07:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756486AbZIRLQE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 07:16:04 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:41329 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469AbZIRLQC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2009 07:16:02 -0400
Received: by ewy2 with SMTP id 2so1215225ewy.17
        for <git@vger.kernel.org>; Fri, 18 Sep 2009 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=sVfSrL0/I7B/Mh64sNXTG9UoGGHZS+9oYjrqGKqP2ok=;
        b=QoWToRtlogtSFBF70r3ZZYGdSEw+Am0Q/Hl/Z3IMqZawYwneH3gt/sXBy4eeSoiQJQ
         MMumIpr7Ct+ooAtK5Ia33ytGOKUBCwjNifFrX7eoF48zV/6dGsloNF0s8ODTJ6+ToYoq
         4J1AXzVeTof8j1bpKTKjPnT9nh0UFbYE5RePQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=iS1Aii9Z0SYDGhvuWAVa53iWtlXUPAbvQ7qUbt1I+pJF41/wZx14PTAqQtoNnYW7Zq
         xRxxciRA2QbLmkjwehnPJkE3qEeoFOHYkaPospP45b0vWVVG/RwH2cDmu3t3W1dWB38k
         p0NNFdvUOWRO6pk2F0Ix/OCtvlXr3w8QnwNgE=
Received: by 10.211.154.10 with SMTP id g10mr1939582ebo.49.1253272563257;
        Fri, 18 Sep 2009 04:16:03 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id 5sm4346437eyh.27.2009.09.18.04.16.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Sep 2009 04:16:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Lightning/1.0pre Thunderbird/3.0b3
In-Reply-To: <200909181302.49335.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128795>


> Well, git-remote has "git remote update" subcommand for fetching from
> a group of remote repositories, so it is not only about managing remotes.
> I think "git remote push" (or something like that) would fit in
> git-remote area of competence.
>
> Besides git-remote understands groups of remote repositories for fetch
> (update), which would be (I think) a good idea also for push.

Agreed.

Paolo
