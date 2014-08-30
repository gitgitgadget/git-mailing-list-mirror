From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Configurable filename for what is now .gitignore
Date: Fri, 29 Aug 2014 22:43:12 -0700
Message-ID: <20140830054312.GA28512@google.com>
References: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bostjan Skufca <bostjan@a2o.si>
X-From: git-owner@vger.kernel.org Sat Aug 30 07:43:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNbRj-000855-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 07:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbaH3FnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 01:43:20 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:47868 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaH3FnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 01:43:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id fp1so1851639pdb.12
        for <git@vger.kernel.org>; Fri, 29 Aug 2014 22:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qs7KJCcM4TMTb6F6Hmzho1SRTqBDtLyGb4Aw1PWkbsE=;
        b=yM5GTQZ9BazPATqzFT98SUFZUTu1s4nKrIFFofpP8wfHs/APCQ0tljMSsO7r5fS0P4
         TEjD/XGca9fz24gFytVEpTLYdz8P5jHbj7K1+Oh+sJm7qH/8/vzvXzZYM6og4Ro6dlro
         hY/xxZgiBs0rKBoVNjSHND2RKAvWXRQ4NvcZPDtnmZYWWfebrvx9bZpLRvGFPc9XMFRP
         Aa+zyEFX2VHxMEaMivh6vq3yaRaVnI9eMKEV8Pjvjil/No/i6Sz4oOQYOnCdcvYJxWPY
         kTlt2qP8wpaps+Xnd9P31LmLMB3UOyBnQg4Ghhux2brcHub7paWemFk5DAfIqYFWlV7N
         36JQ==
X-Received: by 10.66.90.229 with SMTP id bz5mr21166963pab.80.1409377399238;
        Fri, 29 Aug 2014 22:43:19 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id i8sm1650733pbq.17.2014.08.29.22.43.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 Aug 2014 22:43:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEp_DRDCQqkwL1N-PemLtOvPEv-xfBW4MatAOomwi+my9QeK8g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256208>

Hi,

Bostjan Skufca wrote:

> Git is great for tracking code development, but when deploying
> mentioned code by using git itself, various configuration files must
> be created additionally, which are normally .gitignored, for various
> reasons (code portability, sensitive data, etc). There is currently no
> simple way of tracking changes to those critical configuration files
> (at least none that I am aware of).
>
> One way to approach this would be tracking those changes in separate
> git repository.

Have you seen zit
<https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Zit>?

Curious,
Jonathan
