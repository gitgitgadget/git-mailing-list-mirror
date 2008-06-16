From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/WIP/PATCH v2] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Mon, 16 Jun 2008 11:10:21 +0200
Message-ID: <48562DFD.4090108@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <200806152001.34350.jnareb@gmail.com> <4855634C.8060606@gmail.com> <200806160240.18539.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:50:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8GyP-0008Rq-H5
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbYFPPta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754029AbYFPPta
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:49:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:29820 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbYFPPt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:49:29 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3290820fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=KXMwiN8VprW56nJJdQducXIc8APzgS9IWuLB921v9Mw=;
        b=OEliyQZKOFneZEwXQAGI7lIzUWdXEzirOOh8uvHo2xYMXanmpQw9AGTMx9KSzQt09g
         AzPl82uhuE9EDzE2wqK+9wM2lrjL6Byyy4BTKmmbhSfWWcmtZCHA6POyrm7hdJWOyLuc
         82K+RMQmbFt4hhfOYJilopLZEcBup+qOnlNhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=xIj+X1RIgB/FSzrPAv/2FRAGZWUQSd/yYy4hiaJGvTlT39KqMUenGIYZIqW7ckquKM
         io/BwEi+HeP/PKBAG88vkpnzU8+DSLHuGx4BtP7wj8LzJLIrMchGsMnfvfuiz9Q3w1X4
         2sBqpyB1WnD2SpSA1tIMiqejQpETiDE8BgNaI=
Received: by 10.78.203.20 with SMTP id a20mr2683960hug.99.1213631368023;
        Mon, 16 Jun 2008 08:49:28 -0700 (PDT)
Received: from ?172.16.30.128? ( [84.181.171.31])
        by mx.google.com with ESMTPS id y18sm4173871hua.51.2008.06.16.08.49.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 08:49:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200806160240.18539.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85196>

Jakub Narebski wrote:
> How would you ensure cold cache?

Use a unique key prefix, like "gw:test-$PID:<key>"

>> 3. Get all those URL's again *with* caching (from a warm cache), and 
>> assert that the output is identical.
> 
> it might have "cached output" somewhere in the output.

We can make that deactivatable so that the output is actually identical.

-- Lea
