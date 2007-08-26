From: Petr Baudis <pasky@suse.cz>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,
	.gitacls? etc.
Date: Sun, 26 Aug 2007 12:06:47 +0200
Message-ID: <20070826100647.GH1219@pasky.or.cz>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 12:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPF1A-00055a-B0
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 12:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbXHZKGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 06:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXHZKGt
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 06:06:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40329 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbXHZKGs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 06:06:48 -0400
Received: (qmail 25180 invoked by uid 2001); 26 Aug 2007 12:06:47 +0200
Content-Disposition: inline
In-Reply-To: <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56683>

On Sun, Aug 26, 2007 at 10:02:50AM CEST, Dmitry Kakurin wrote:
>>> My knowledge of Git internals is quite limited, but if *I* were to do
>>> it right now, I'd introduce a META entry in every TREE object that
>>> would point to a BLOB that contains combined content of
>>> .gitattributes, .gitignore etc.
>> A tree that has .gitattributes (and I am assuming in the longer
>> term you can use "ignore" and "precious" in .gitattributes
>> instead of using .gitignore) POINTS TO A BLOB already, so what
>> you are saying does not add anything to what we already have,
>> other than that you are renaming .gitattributes to "META ENTRY".
>
> Almost true! The difference is: META BLOBS are not created as files in the 
> workspace (not during checkout, not ever).
> In order to edit it you'd have to use 'git meta' command.
> So once again, there is only one place to check for metadata - the index.

That sounds so incredibly ugly, I really would hate to see that.

It's still not clear to me how this would help anything, though I didn't
watch late Git development. Can you explain some particular scenario
where this would improve the current situation?

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
