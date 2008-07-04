From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [OT] Your branch is ahead of the tracked remote branch 'origin/master' by 50 commits.
Date: Fri, 4 Jul 2008 09:35:31 +0100
Message-ID: <25F65C20-1B9B-4626-AD06-449D8613D394@simplicidade.org>
References: <20080701091347.GA11817@elte.hu> <7vlk0mne5d.fsf@gitster.siamese.dyndns.org> <20080701100725.GE31309@elte.hu> <20080701111601.GT4729@genesis.frugalware.org> <20080701112235.GC11809@elte.hu>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jul 04 10:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEgmO-00036F-Cb
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 10:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYGDIff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 04:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbYGDIff
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 04:35:35 -0400
Received: from mail.sl.pt ([212.55.140.13]:35080 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752630AbYGDIfe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 04:35:34 -0400
Received: (qmail 14252 invoked from network); 4 Jul 2008 08:35:31 -0000
Received: from unknown (HELO [10.0.0.128]) (melo@[195.23.56.26])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 4 Jul 2008 08:35:31 -0000
In-Reply-To: <20080701112235.GC11809@elte.hu>
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.753.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87372>

Hi,

On Jul 1, 2008, at 12:22 PM, Ingo Molnar wrote:
> [ Oh, and i could switch between git versions without having to  
> rebuild
>   ;-) ]

hmms... Can you just use

version=`git-describe`
./configure --prefix=/usr/local/git-$version
make && sudo make install
sudo sh -c 'rm -f /usr/local/git && ln -s /usr/local/git-$version / 
usr/local/git'

and stick /usr/local/git/bin in your path?

Changing git versions is just a ln -s away.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
