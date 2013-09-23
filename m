From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2013, #07; Mon, 23)
Date: Mon, 23 Sep 2013 14:44:23 -0700
Message-ID: <20130923214423.GF9464@google.com>
References: <20130923211047.GD9464@google.com>
 <5240B184.8060101@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 23:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VODvl-0001HV-9g
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 23:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567Ab3IWVoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 17:44:30 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43392 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab3IWVo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 17:44:27 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so3725632pdj.36
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eVdEngYPWpKOcnhGlOJwQiz8bhcKUmXmWltBesuQAik=;
        b=rth12htvz4dKg38/eyHUYM/56sXFix9fuYIsiw2bPP9u/jkJqP35WH5nRB7qHhHW51
         lHhlFNWOgotMzDPyURmYr7SYnuBOAGITz+kAwH9c6jUmPLtiBeNosakECSBtOBDMDSl9
         utFc3vwpJ0vsB5xf0PHaJIjKG02moPVZkLqyxfjWjnbFXOjYSxIOfjbsLemfbO8C9Zvw
         HUHseLwRFHw7dtKs3WE+O3Zn0/FaVn47Y97QO/5o56VuziwsKlqj/CvfbS75abjsBLFB
         HosTEpyDvC/UVBySwlLQ4t/KFV3bK0DLGCZ0acAla7JxxeYRRj90SNEAAtXrJYgxe/z5
         a9rg==
X-Received: by 10.68.197.200 with SMTP id iw8mr2743711pbc.197.1379972667246;
        Mon, 23 Sep 2013 14:44:27 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ta10sm40515456pab.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 14:44:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5240B184.8060101@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235249>

Stefan Beller wrote:
> On 09/23/2013 11:10 PM, Jonathan Nieder wrote:

>>     https://repo.or.cz/r/git/jrn.git
[...]
> How would I get these changes?
> A plain 
> 	git fetch https://repo.or.cz/r/git/jrn.git
> doesn't work, as it yields:
> fatal: unable to access 'https://repo.or.cz/r/git/jrn.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none

Thanks for noticing.  Hm, I'll bug the repo.or.cz admins about this.

The URL

	git://repo.or.cz/git/jrn.git

should work for access by git protocol.  Web interface:
http://repo.or.cz/w/git/jrn.git

> So I'll try without security:
> 	$ env GIT_SSL_NO_VERIFY=true git fetch https://repo.or.cz/r/git/jrn.git
> 	fatal: Couldn't find remote ref HEAD

Fixed, thanks.  (I had left HEAD pointing to branch that doesn't
exist any more.)

Jonathan
