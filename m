From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: Deprecate git-fetch-pack?
Date: Sun, 11 Nov 2007 17:10:53 -0800
Message-ID: <62679E54-6913-46E9-8EC5-D86A7DE2C236@develooper.com>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com> <Pine.LNX.4.64.0711111103240.4362@racer.site> <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org> <20071111222117.GA7392@thunk.org> <7vabpkbebj.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711112247350.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 02:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrNpZ-0007di-LA
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 02:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbXKLBKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 20:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXKLBKz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 20:10:55 -0500
Received: from x8.develooper.com ([216.52.237.208]:49116 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXKLBKy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 20:10:54 -0500
Received: (qmail 6105 invoked from network); 12 Nov 2007 01:10:54 -0000
Received: from gw.develooper.com (HELO g5.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 12 Nov 2007 01:10:54 -0000
In-Reply-To: <Pine.LNX.4.64.0711112247350.4362@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64548>


On Nov 11, 2007, at 2:50 PM, Johannes Schindelin wrote:

> I beg to differ.  The biggest problem with a new user seeing all those
> completions is that this user is scared.


How about moving the plumbing commands to libexec/ or some such?   (Or  
libexec/git/ - then you can put it back in your PATH if you really  
want easy access to run them directly).

Maybe I'm being pedantic, but it's not about "scaring the user" --  
it's simply that the "visible commands" is part of the UI and having  
it unnecessarily complex (many more commands than the user needs to  
learn) makes it much harder to get started using git.  It's a very  
practical thing.

I strongly second Theodore's suggestions for cleaning up some of the  
help texts, too.


  - ask

-- 
http://develooper.com/ - http://askask.com/
