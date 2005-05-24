From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 17:25:32 -0700
Message-ID: <7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
	<7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
	<7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
	<87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 02:27:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaNG0-0007NS-MT
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVEXA2D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVEXAZz
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 20:25:55 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55741 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261151AbVEXAZh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 20:25:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524002532.IAEW12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 20:25:32 -0400
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org> (Chris
 Wedgwood's message of "Mon, 23 May 2005 17:12:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "CW" == Chris Wedgwood <cw@f00f.org> writes:

>> +  (1) a colon.
>> +  (2) mode for "src"; 000000 if creation or unmerged.
>> +  (3) a space.
>> +  (4) mode for "dst"; 000000 if deletion or unmerged.
>> +  (5) a space.
>> +  (6) sha1 for "src"; 0{40} if creation or unmerged.
>> +  (7) a space.
>> +  (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
>> +  (9) status, followed by similarlity index number only for C and R.
>> + (10) a tab or a NUL when '-z' option is used.
>> + (11) path for "src"

CW> What if the path has embedded tabs or spacs?

Then you would use '-z'.  (10) becomes NUL which your path
cannot have inside.  So do (12) and (14).



