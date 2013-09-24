From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #07; Mon, 23)
Date: Mon, 23 Sep 2013 17:12:31 -0700
Message-ID: <4EC9B557-98E7-4796-8789-CD59AF099CC5@gmail.com>
References: <20130923211047.GD9464@google.com> <5240B184.8060101@googlemail.com> <20130923215456.GG9464@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 24 02:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOGF4-0002h7-8X
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 02:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab3IXAMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 20:12:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42112 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab3IXAMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 20:12:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so3829973pbb.19
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=N9DwLbUva3HDUVDDnnGvzWOzHTgzP1YZtaE9BApY45I=;
        b=0+ZQjc24Q5ahOA8n12SIw/H7rFdE7zPPJT5jella23vVs9KZcXL8qVrcCI1Lb9dlOR
         Zj4kaR3jluSSPNQMz92mz1CB3VjIgUFb2y8JAJmMrjQkd215WSJuwBJ8tKT6HwZTssto
         BS2NXuJOgnXjs8skjSgU/KhssN+myye7nNFYMQCr3NBcIwAlM+kO+WS+ghsNmt/g7TcF
         nCzou0Qpi2X4WjAc2lay/e55DSQVlFo/uu/gtsCjBZ8P5zP72H2jL/7fM7ZCGCIi9/iN
         9vRlu6cK8uDmIVDIDLzuiR5NYHJ4mdy+IdKLcpwW4uHoPtKxgn56yFN1D+NP7cLQH9b6
         XPIw==
X-Received: by 10.68.113.99 with SMTP id ix3mr3505356pbb.180.1379981553594;
        Mon, 23 Sep 2013 17:12:33 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id go4sm36808998pbb.15.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 17:12:32 -0700 (PDT)
In-Reply-To: <20130923215456.GG9464@google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235251>

On Sep 23, 2013, at 14:54, Jonathan Nieder wrote:
> Stefan Beller wrote:
>
>> 	git fetch https://repo.or.cz/r/git/jrn.git
>> doesn't work, as it yields:
>> fatal: unable to access 'https://repo.or.cz/r/git/jrn.git/': server  
>> certificate verification failed. CAfile: /etc/ssl/certs/ca- 
>> certificates.crt CRLfile: none
>
> Ah, figured it out.  [1] http://repo.or.cz/h/rootcert.html explains.

The four possible fetch URLs are also listed on the http://repo.or.cz/w/git/jrn.git 
  page:

   git://repo.or.cz/git/jrn.git

   http://repo.or.cz/r/git/jrn.git

   ssh://repo.or.cz/srv/git/git/jrn.git

   https://repo.or.cz/r/git/jrn.git

As Jonathan has pointed out, fetching over https may require some  
additional setup as explained above [1].

Fetching using ssh can be accomplished without needing to create a  
user account by using the "mob" user as in the URL "ssh://mob@repo.or.cz/srv/git/git/jrn.git 
".

The git: and http: URLs should work as-is for fetching.
