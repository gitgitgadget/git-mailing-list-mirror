From: Bryan Drewery <bryan@shatow.net>
Subject: Re: [PATCH 1/2] commit: add message options for rebase --autosquash
Date: Fri, 17 Sep 2010 12:47:37 -0500
Message-ID: <4C93A9B9.2060401@shatow.net>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com> <1284687596-236-2-git-send-email-patnotz@gmail.com> <4C93288B.7000908@gmail.com> <4C9393CB.4010107@shatow.net> <AANLkTimBnzWQYy8z1duQw=4UL4YCaeyiMugXG1O-Q8yq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Notz <patnotz@gmail.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 19:47:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owf2N-0000gI-L9
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 19:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925Ab0IQRrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 13:47:46 -0400
Received: from secure.xzibition.com ([173.160.118.92]:62190 "EHLO
	secure.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab0IQRrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 13:47:46 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; d=shatow.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sweb; b=g9k7Dd
	zcD20D0c0EkJaJUn+Ey83bGfY34F2gWu9GFy7ok4bXqOoeizjzgJ5F+chLBbgJt1
	P/EFkGRPcdjlPg25rZ0Xci9jKBv9Hw6C8ZakWbfWuvaT8YFvK/de2Sx7AyOt9Zsg
	9r2+to8ee6FQBiJLQCjA5XBheAeZfnxJ+cDuE=
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=shatow.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sweb; bh=d5LjemI60d2u
	aytB9N3mCSpYiK3dg27aqc+wkCo8QjQ=; b=1bKX7T0MC+zM3t4KsGX1jLj0jUj8
	4AL19ztddu6WO3/CxvmmtoaoTyShNtnxhDPE/AkoAEwqvMZiI5e12ROLCrxoQDqz
	1WBps76ZcJMIh6Orfd6zYaI8pc0oIVNVKpzwwt9ofJwJyUhVOzU0ZuYOWjyjSHyq
	ovrQlPeLFNKuHbA=
Received: (qmail 21499 invoked from network); 17 Sep 2010 12:47:42 -0500
Received: from unknown (HELO ?192.168.0.201?) (bryan@shatow.net@74.94.87.209)
  by sweb.xzibition.com with ESMTPA; 17 Sep 2010 12:47:42 -0500
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <AANLkTimBnzWQYy8z1duQw=4UL4YCaeyiMugXG1O-Q8yq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156405>


>>>> These options make it convenient to construct commit messages for use
>>>> with 'rebase --autosquash'.  The resulting commit message will be
>>>> "fixup! ..." or "squash! ..." where "..." is the subject line of the
>>>> specified commit message.
>>>>         
> `git fixup' is aliased to `!f() { git commit -m "$(git show -s
> --pretty='format:fixup! %s%n%nFixup for %h%n' "$1")" $2; }; f'
> `git squash' is aliased to `!f() { git commit -m "$(git show -s
> --pretty='format:squash! %s%n%n' "$1")" -e $2; }; f'
>   
Thanks.

I had missed that this was for the commit message. Thought it was doing 
the rebase as well.

Bryan
