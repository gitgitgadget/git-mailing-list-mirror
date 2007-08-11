From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [BUG} git-fetch - won't fetch wildcarded tags
Date: Fri, 10 Aug 2007 23:25:29 -0400
Message-ID: <46BD2C29.3040002@gmail.com>
References: <46BD25FC.1050201@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 05:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJhbk-0002GO-RE
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 05:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761664AbXHKDZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 23:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760465AbXHKDZh
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 23:25:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:32532 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759953AbXHKDZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 23:25:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so715605wxd
        for <git@vger.kernel.org>; Fri, 10 Aug 2007 20:25:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FU3HsYiQseoKs2AJl/2Wj/Z2I21GkZ6McaMJCHSgY3GD70QhA5VpON30HXdelsFeGbI83MqnT7YbREHdJDzD45CAESFgQO7j6H2LffMhr5Kufpj/6ycCh4Mr6Cw/jfKa0q7A6lAo/Cl39yuC19SjDbkV0y8L/dkqBs+AZV8RDJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oE6yi+FSaIcq7dm+7B1eMPWhScioYsp2uJiyjjnNm1vK8G6PIZ9kUENPbVEecs9z5OPlFqaGt1YX8CVPN/JwQNHhaH7LTFQlAmzrOYGyQnzxyHRXYyykkA3t1gI4L5qJNcDyvcwZXE1c/bsOAZkpZiFeoCVGsaqQtX3UHO9TU08=
Received: by 10.70.52.1 with SMTP id z1mr6456605wxz.1186802735828;
        Fri, 10 Aug 2007 20:25:35 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.233.117])
        by mx.google.com with ESMTPS id h34sm6658943wxd.2007.08.10.20.25.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Aug 2007 20:25:33 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <46BD25FC.1050201@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55584>

Mark Levedahl wrote:
> git fetch does not seem to handle refs/tags/* refspecs, at least no 
> from bundles...
>
groan - Never mind
git fetch -t /tmp/foo
