From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 16:34:09 -0700
Message-ID: <20130521233409.GV3657@google.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
 <7vzjvokm7f.fsf@alter.siamese.dyndns.org>
 <CABx5MBQd8Q-NMdFb4p9hk91mpf4FgbTGc3E0oh1tHMfptZSyUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>,
	git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 01:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uew4Q-00063b-N8
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 01:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3EUXeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 19:34:14 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:62017 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab3EUXeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 19:34:14 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so1103438pbc.9
        for <git@vger.kernel.org>; Tue, 21 May 2013 16:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=whe2NaOrq0vSJSvqDFBqXKGmkWIiihxhAJQLwq0rQO0=;
        b=lyg4LBL3vawuVrJPkEkdp+92wmbtNktWIrnJf5PzWkwnsuAbE/XPaFjoC5fwxujWkr
         dFDBlYhJ5E12y1d5n+ce9/hSYwu9ZnppBqyG+EYlVqQ3/NMKpONvOJieBVQWyUTNEY8K
         7wL2sjnLxbu/pQ7vWnCXDEbsFCraOLb1xDoAOqZiIroQZRit0Fg1EpzQa+zWOTtkarv2
         +Ir0jubJcECZuIElNDXAJQU0PJw85g8jDt5VQM0SNVF/aiCwweCArTvpgHZR3W2KihNW
         WufvNNJk+2fNLBhXRUBvnaxPUt3Z6lvn8sEvHjX8k2gMxceYuWV73m2L3QeRlpdy0c6P
         rQ7w==
X-Received: by 10.66.88.38 with SMTP id bd6mr5628547pab.184.1369179253575;
        Tue, 21 May 2013 16:34:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v7sm4491363pbq.32.2013.05.21.16.34.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 May 2013 16:34:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABx5MBQd8Q-NMdFb4p9hk91mpf4FgbTGc3E0oh1tHMfptZSyUQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225095>

Chico Sokol wrote:

> We're trying to build a improved java library focused in our needs
> (jgit has a really confusing api focused in solving egit needs).

JGit is also open to contributions, including contributions that
add less confusing API calls. :)  See

 http://wiki.eclipse.org/JGit/User_Guide
 http://wiki.eclipse.org/EGit/Contributor_Guide#JGit
 http://wiki.eclipse.org/EGit/Contributor_Guide#Using_Gerrit_at_https:.2F.2Fgit.eclipse.org.2Fr
 https://dev.eclipse.org/mailman/listinfo/jgit-dev

Thanks,
Jonathan
