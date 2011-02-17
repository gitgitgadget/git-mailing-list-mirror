From: Miles Bader <miles@gnu.org>
Subject: Re: set-upstream for existing branch...?
Date: Thu, 17 Feb 2011 16:11:37 +0900
Message-ID: <buo8vxfxhhy.fsf@dhlpc061.dev.necel.com>
References: <buoei77xmpc.fsf@dhlpc061.dev.necel.com>
	<AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 08:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppy1u-0006J0-6j
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab1BQHLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:11:53 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:53872 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1BQHLv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 02:11:51 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p1H7Bik2028554;
	Thu, 17 Feb 2011 16:11:44 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id p1H7Bid23110; Thu, 17 Feb 2011 16:11:44 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.46])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id p1H7Bhrx005724;
	Thu, 17 Feb 2011 16:11:44 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Thu, 17 Feb 2011 16:11:38 +0900
Received: from dhlpc061 ([10.114.96.71] [10.114.96.71]) by relay41.aps.necel.com with ESMTP; Thu, 17 Feb 2011 16:11:38 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 146E752E1DC; Thu, 17 Feb 2011 16:11:37 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <AANLkTikqj8NjLwR647E1tHUuDO=OitUJ1dm5Fs7gtXXt@mail.gmail.com>
	(Jay Soffian's message of "Thu, 17 Feb 2011 02:08:55 -0500")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167048>

Jay Soffian <jaysoffian@gmail.com> writes:
> On Thu, Feb 17, 2011 at 12:19 AM, Miles Bader <miles@gnu.org> wrote:
>> Is there a convenient, intuitive, way to set (or change) @{upstream} for
>> the current branch, without doing anything else...?
>
> $ git branch <current_branch> --set-upstream <new_upstream>
>
> But note that this is deceptive: what's important is the relative
> positions of <current_branch> and <new_upstream> on the command-line,
> and they must be in that order. It doesn't (currently) matter where
> you place the --set-upstream.
>
> I've got it on my todo list to make --set-upstream take <new_upstream>
> as its argument so that you can just say:
>
> $ git branch --set-upstream <new_upstream>

Thanks, the latter sounds nice, but for now the former is good for an alias...

-miles

-- 
Dictionary, n.  A malevolent literary device for cramping the growth of
a language and making it hard and inelastic. This dictionary, however,
is a most useful work.
