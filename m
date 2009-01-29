From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Wed, 28 Jan 2009 22:31:21 -0500
Message-ID: <49812309.9010703@tedpavlic.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>  <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>  <885649360901281815q42199468v8658d864386efe2d@mail.gmail.com>  <46a038f90901281828t16ace3bdocc897eb5235d7c30@mail.gmail.com> <d30068860901281846v65baf431mdab5fe961ef9407d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	James Pickens <jepicken@gmail.com>, git <git@vger.kernel.org>
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSNed-0007vp-KO
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 04:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758581AbZA2Dba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 22:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbZA2Dba
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 22:31:30 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:39855 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754419AbZA2Db3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 22:31:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E3FDC80D805A;
	Wed, 28 Jan 2009 22:25:19 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vuvJoldXu5gb; Wed, 28 Jan 2009 22:25:19 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 7D7E880D8018;
	Wed, 28 Jan 2009 22:25:19 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <d30068860901281846v65baf431mdab5fe961ef9407d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107622>

> does the concept of me setting up my own central git server as well
> make any sense from the point of view of a way to ensure I can (when
> I'm not remote) "check-in" to the central git server&  thereby keep a
> separate copy of my code (i.e. effectively a backup)

You can always keep local clones that serve as "stable" backup repos. 
However, I think most people would suggest you just create 
stable/experimental branches and merge from one to the other as 
appropriate.

If you need some nice working examples of people using git for personal 
projects, I recommend you search Google for the many ways of using git 
to manage home directories. Applying git to home directory management 
involves many of the same questions (and answers) as what you're 
bringing up here, and it probably will give you some ideas about the 
most effective git usage for your case.

--Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
