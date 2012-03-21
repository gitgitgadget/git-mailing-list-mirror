From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: link user-name with ssh-login
Date: Wed, 21 Mar 2012 22:00:37 +0530
Message-ID: <CAMK1S_iND20y+5GaeEpUzXWFZLMXa=XUs-b3hDaZ+WvhaCZvnw@mail.gmail.com>
References: <4F6765D0.5060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Roberto <mrgreiner@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 17:30:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAOQt-0000bB-Vx
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 17:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796Ab2CUQaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 12:30:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45823 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180Ab2CUQai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 12:30:38 -0400
Received: by ghrr11 with SMTP id r11so1094807ghr.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nOHprjWw1ze3V+H0y+FfOgP0h+hVso8Ceph6OStfKag=;
        b=PSwRBNuiyUb6dku4u+D7nLi98bxpWGE3WHVkdwOiyS1L1+KdUt+RtW5YHlcFGoRM7e
         6hIW/HOZ5ZlHuJ6p5w9ZD4xVkh7HltpbB162NvTo4NrtcJR/VurjPjNcneqKeP8z00Ea
         lXQF3vOW64zd1/J+zsLRUjbnJplDuMSL5aFDcI2X/ntbH66jM6MJoOCPMPHL/SyJL0Tt
         yOgm0EzFJ//iN/dLCsIqGKjSWDqrNNYXg1j2DV7vmHzf+WfQXYvmZvrfjZXxbZ6nNJum
         N5VJNjPkE+NGmZBNc1otxtkH+w+11SZP7jWB1Zc298L9LZjINUniMYx2VcA7ILKt1Pp1
         PEow==
Received: by 10.60.24.9 with SMTP id q9mr5487747oef.4.1332347437758; Wed, 21
 Mar 2012 09:30:37 -0700 (PDT)
Received: by 10.182.8.105 with HTTP; Wed, 21 Mar 2012 09:30:37 -0700 (PDT)
In-Reply-To: <4F6765D0.5060706@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193585>

On Mon, Mar 19, 2012 at 10:28 PM, Roberto <mrgreiner@gmail.com> wrote:
> Hi,
>
> I have small ssh-based git server used for insite code development. But
> there is one thing I can't find how to set.
>
> In the server, each developer has a valid ssh account (I switched the shell
> to git-shell). The problem is that when a developer commit's some code, he
> can freely set in his local .git/config file the user name he want's to
> appear in the commit logs. Is there any way to link/force a certain ssh
> login to a name?

along the lines of what others already said, here's my rant on this requirement:

https://github.com/sitaramc/gitolite/blob/pu/contrib/VREF/gl-VREF-EMAIL_CHECK#L37
