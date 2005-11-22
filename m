From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: index manipulation -- how?
Date: Mon, 21 Nov 2005 23:35:38 -0800 (PST)
Message-ID: <20051122073538.4708.qmail@web31806.mail.mud.yahoo.com>
References: <7vbr0dgo1f.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 08:39:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeSgp-0002hL-2N
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 08:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVKVHfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 02:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKVHfk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 02:35:40 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:64614 "HELO
	web31806.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932387AbVKVHfj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 02:35:39 -0500
Received: (qmail 4710 invoked by uid 60001); 22 Nov 2005 07:35:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W040Tw/kCEDD0Uv2jIZzR2Z3fS33VSWXBsejUwdWntgXN86RixEM+sYV0RhCc/boxM/2aqBkJxmCY3EbMlJEXzwCNMQCuZlifaRMPo0zRBY0hQMe+U+xUTkzd4DB/LLjXe0SwGSHp/VwA5k0sGSHDsne8vEBuNVG3FvlwkqTeC4=  ;
Received: from [68.221.119.157] by web31806.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 23:35:38 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr0dgo1f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12533>

--- Junio C Hamano <junkio@cox.net> wrote:
> 
> I thought what you originally wanted to do was revert only index
> without losing your changes from the working tree, so just to
> make sure, the above does _not_ do it --- the named file in the
> working tree is also reverted to the one from <tree-ish>.

Exactly what I want.

Thanks,
   Luben
P.S. I figured this one out in three stages:
Since checked out files are in rw- mode, but unchecked
files simply do not exist, first I want to "revert"
a changed file in the working tree -- this one is easy.
Then the second stage is if also the index is updated
(but no commit), and the last stage is if also
there is a commit, for which I think I know what to use.
