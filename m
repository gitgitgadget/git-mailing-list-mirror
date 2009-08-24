From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: Teach mailinfo to ignore everything before -- >8 --
	mark
Date: Mon, 24 Aug 2009 09:17:11 +0200
Message-ID: <20090824071711.GE3526@vidovic>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name> <1250999357-10827-3-git-send-email-git@tbfowler.name> <7vvdkfx8rl.fsf@alter.siamese.dyndns.org> <20090823171819.6117@nanako3.lavabit.com> <7v1vn2yklo.fsf@alter.siamese.dyndns.org> <20090824060708.6117@nanako3.lavabit.com> <alpine.DEB.2.00.0908231705200.29625@GWPortableVCS> <7v7hwurwmu.fsf@alter.siamese.dyndns.org> <20090824041608.GC3526@vidovic> <20090824141623.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 09:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfTnx-0007mV-CN
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 09:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbZHXHRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 03:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZHXHRP
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 03:17:15 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:51784 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZHXHRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 03:17:14 -0400
Received: by ewy3 with SMTP id 3so2109905ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 00:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8uYXnBChtBnQbRQt3yF/QMUHo8KanAJXkacAm0SfLmY=;
        b=FFK4LHqqjk0pqH8R4oasMWCPDcE06fKwxOtkK2wD7/oC+dpwRIH0Ss/43LT7pqXkjK
         QeG/JlFR/llJl0yhR9Tmjir9kJzmBrJyp0knRG/C9yfX9Q0Urpjn4bSaCdOtq7Ga+ctM
         ED+RAFNN6NDoHbn8s9R2rZuyF70Q/eXMnOPPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OYDP74k1aKnS17HQWAbnJN2p062+tVZJ123KLApS04ebumuYhnrpfZ9QynpaWtYe4L
         nhUXyrYvkNdpznsQ8enmp8IthXQblg3m0d8ss6yel7LUYidCooBJdTb3R6cOdwvagfOj
         3dYFKW/HfmMjRQLvwC9VaFiurD/YVmRcsmW58=
Received: by 10.210.109.19 with SMTP id h19mr1329996ebc.63.1251098235627;
        Mon, 24 Aug 2009 00:17:15 -0700 (PDT)
Received: from @ (88-121-114-119.rev.libertysurf.net [88.121.114.119])
        by mx.google.com with ESMTPS id 7sm4159661eyb.37.2009.08.24.00.17.13
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 00:17:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090824141623.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126913>

[ Please, please, please, wrap your lines. ]

The 24/08/09, Nanako Shiraishi wrote:

> Looking at the way other people use the mark in their messages, I think this explanation isn't correct.

I'd say that should not document what people do but what the program
does.

> A scissors mark doesn't have to be at the beginning. The line has to contain the mark, and it has to consist of only the mark, '-' minus, the phrase "cut here", and whitespaces.

...and (">8" or "<8"), you're right. But isn't the following mark a bit
too much permissive?

->8
Subject: [PATCH] squashable to 925bd84 (Teach mailinfo to ignore everything before -- >8 -- mark, 2009-08-23)

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---

This patch supersedes my previous round.

 Documentation/git-am.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fcacc94..1d10371 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -138,6 +138,10 @@ The commit message is formed by the title taken
from the
 where the patch begins.  Excess whitespace at the end of each
 line is automatically stripped.
 
+If a line starts with a "-- >8 --" mark in the body of the message,
+everything before (and the line itself) will be ignored.
+Whitespaces and strings "cut here" are tolerated.
+
 The patch is expected to be inline, directly following the
 message.  Any line that is of the form:
 
-- 
Nicolas Sebrecht
