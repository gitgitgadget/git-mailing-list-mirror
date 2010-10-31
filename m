From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Pushing everything
Date: Sun, 31 Oct 2010 10:48:51 +0100
Message-ID: <m28w1epu9o.fsf@whitebox.home>
References: <loom.20101031T064406-734@post.gmane.org>
	<AANLkTikG5yTPwkjmnSv8yg2QRNNjDu_JxBdHzLBjO1RP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maaartin <grajcar1@seznam.cz>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 10:49:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCUXD-0003N8-2b
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 10:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab0JaJs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 05:48:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43584 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab0JaJsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 05:48:55 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 33B6E1C15A41;
	Sun, 31 Oct 2010 10:48:53 +0100 (CET)
X-Auth-Info: YNb0rOv/NfPhSY3YhX4luFXhejlyo3EQtoNK0BhYINE=
Received: from whitebox.home (ppp-88-217-112-158.dynamic.mnet-online.de [88.217.112.158])
	by mail.mnet-online.de (Postfix) with ESMTPA id 275081C003D0;
	Sun, 31 Oct 2010 10:48:53 +0100 (CET)
Received: by whitebox.home (Postfix, from userid 501)
	id ECB071E5320; Sun, 31 Oct 2010 10:48:51 +0100 (CET)
X-Yow: How many retired bricklayers from FLORIDA are out purchasing
 PENCIL SHARPENERS right NOW??
In-Reply-To: <AANLkTikG5yTPwkjmnSv8yg2QRNNjDu_JxBdHzLBjO1RP@mail.gmail.com>
	(Tay Ray Chuan's message of "Sun, 31 Oct 2010 14:43:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160431>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sun, Oct 31, 2010 at 1:47 PM, Maaartin <grajcar1@seznam.cz> wrote:
>> I'd like to push all my branches and tags to the server, but for whatever reason
>> "--all" ignores tags and is incompatible with "--tags". I could imagine there's
>> a reason I'm not experienced enough to see?
>
> You can spell the refs explicitly, like this:
>
>   $ git push refs/heads/* refs/tags/*

The first argument needs to be a reference to a repository, so insert an
origin here.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
