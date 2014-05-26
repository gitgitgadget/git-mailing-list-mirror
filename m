From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Can we stage all files using "git add" command, except some
 specific files ?
Date: Mon, 26 May 2014 22:23:22 +0200
Message-ID: <1401135802.25483.1.camel@spirit>
References: <8392138.j8Dle5WGbS@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 22:23:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp1Qh-00055L-CU
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 22:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbaEZUX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 16:23:27 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:64839 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbaEZUX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 16:23:26 -0400
Received: by mail-wi0-f177.google.com with SMTP id f8so544075wiw.4
        for <git@vger.kernel.org>; Mon, 26 May 2014 13:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=GOsGGvuAmHI2JZjV9dqvS6bv9QCdmHK0uwzQ26zllhY=;
        b=Hvs9JdNRk4FRNLNXT2EuF1NlS6JE/NlubDshDep00laGj52ijoi8N+kc0EUN9R4Slm
         Uo0sNMOf9GnltCcKfK9WZGJ547/C2g6EM1RyVPiYIYG+Of8f0HLAwnMkqY9OzWLa5l8Q
         xdVr+FoWVmdBtHOjOsJUSPqz1hKavJDlorCl0Rr0mPq4o9YkEpcyPwKHqL1mSTsJBwjs
         DqK2X8Lk0rG9YbCcXGdYCZpZYnqNfN4qRcKzgd7KA5+oLKiAl+ryU5g/bijOM6B7LIfu
         rjSGq7DNgAuKh6IV18bcawy6C+NczIDPet6Ia+p2EX4df7iqGFm2/Dv4y++qnMCJzCZu
         Hu0w==
X-Gm-Message-State: ALoCoQmaeFuyYhD+7ogLKBYot+YvnPYRmIQ57CiP6rPMR1k5AgJWK0RhjlNZokvH5Wj3WlgIlsx5
X-Received: by 10.180.90.145 with SMTP id bw17mr31329411wib.43.1401135805320;
        Mon, 26 May 2014 13:23:25 -0700 (PDT)
Received: from [10.42.1.3] (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id l2sm2489399wix.13.2014.05.26.13.23.23
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 13:23:24 -0700 (PDT)
In-Reply-To: <8392138.j8Dle5WGbS@linux-wzza.site>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250119>

On di, 2014-05-27 at 00:33 +0630, Arup Rakshit wrote:
> 
> Now, you can see, I have staged all the files first using *git add
> -A*, then _unstaging_ those I don't want to _stage_ right now. Now can
> this be done, in the *staging* time ? I mean any way to tell `git add`
> command, that add all the files from the current directory, except
> some specific files.

No, there is no such option to do that, but you could use git add
--interactive and use its interface to quickly pick the files you want
to add.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
