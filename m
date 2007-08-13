From: "Evan Carroll" <me@evancarroll.com>
Subject: git-peek-remote vs git-pull (error in latter)
Date: Mon, 13 Aug 2007 17:01:38 -0500
Message-ID: <428b865e0708131501m45b6e2f9t9926821cf93b7abc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 14 00:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKhyr-00084o-C0
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbXHMWBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758596AbXHMWBl
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 18:01:41 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:12184 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbXHMWBj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 18:01:39 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1278420rvb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 15:01:39 -0700 (PDT)
Received: by 10.141.145.11 with SMTP id x11mr2762182rvn.1187042498854;
        Mon, 13 Aug 2007 15:01:38 -0700 (PDT)
Received: by 10.141.212.7 with HTTP; Mon, 13 Aug 2007 15:01:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55790>

I'm having a *major* problem with git-pull and ssh locations. Notice
the bottom works, and the top not so much can't find --upload-pack. As
an aside, an error when people try ssh://user@location/ an error would
be nice. die "Bad ssh-location syntax" if $cmd =~ /^ssh:/

ecarroll@x60s:~/Desktop/scraper$ git pull
--upload-pack=/home/dealermade/bin/git-upload-pack
dealermade@chason:/home/dealermad
/Desktop/scraper/.git
sh: /home/dealermade/bin/git-upload-pack: not found
fatal: The remote end hung up unexpectedly
Cannot get the repository state from origin

ecarroll@x60s:~/Desktop/scraper$ git-peek-remote
--upload-pack=/home/dealermade/bin/git-upload-pack
dealermade@chason:/home/dealermade/Desktop/scraper/.git
00af556bab4850c1f52eb259445688689f1dd4ff        HEAD
00af556bab4850c1f52eb259445688689f1dd4ff        refs/heads/master
fe0e395cc4161071ac871215919563edc8de59c3        refs/heads/origin

Please cc me in all correspondence, me@evancarroll.com

Thanks again!

-- 
Evan Carroll
System Lord of the Internets
me@evancarroll.com
832-445-8877
