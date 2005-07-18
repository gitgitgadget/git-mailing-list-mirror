From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: Last mile to 1.0?
Date: Mon, 18 Jul 2005 10:48:50 +0400
Message-ID: <200507181048.50303.snake@penza-gsm.ru>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net> <200507180853.41633.snake@penza-gsm.ru> <7vfyucfzgt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 18 08:49:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuPR0-0007tN-FJ
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 08:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVGRGsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 02:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVGRGsy
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 02:48:54 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:28622
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261554AbVGRGsy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2005 02:48:54 -0400
Received: (qmail 21703 invoked from network); 18 Jul 2005 06:48:51 -0000
Received: from unknown (HELO snake) (192.168.0.20)
  by fileserver.penza-gsm.ru with SMTP; 18 Jul 2005 06:48:50 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
In-Reply-To: <7vfyucfzgt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-102.8 required=5.0 tests=ALL_TRUSTED,AWL,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Monday, 18 July 2005 09:35 Junio C Hamano wrote:
> Alexey Nezhdanov <snake@penza-gsm.ru> writes:
> > I'd add the UTF-8 native support. Currently neither commit nor gitk
> > doesn't support that. Probably this should be done at as low as possible
> > level.
>
> I do not understand your proposal.  Care to clarify?  You can
> write your commit messages in UTF-8 today and "git-cat-file
> commit $commit_ID", which is as low level as you can go, gives
> you that commit message in UTF-8.
Yes. But it have not integration with user environment. Personally I use 
koi8-r environment and doing "cg commit" (and probably "git commit" too) 
results in koi8-r text written as commit text. I remember that this issue 
were discussed on this list and all come to conclusion that utf-8 is the only 
sane encoding that can be used in this case.
But this should not be user's problem - it's just the UI that doesn't 
understands when transcoding should be done.
Similarly - when I start gitk then I see only weird symbols instead of commit 
text, not matter what encoding I use for commits - koi8-r or utf-8. BTW 
russian koi8-r encoded text _in_diff_contents_ show correctly. Wonder why...
-- 
Respectfully
Alexey Nezhdanov
