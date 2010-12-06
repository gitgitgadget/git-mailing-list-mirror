From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Can't seem to commit
Date: Mon, 06 Dec 2010 21:54:37 +1300
Message-ID: <4CFCA4CD.4050100@gmail.com>
References: <1291480384128-5803287.post@n2.nabble.com> <4CFCA445.2020205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: weloki <weloki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 09:54:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPWph-0007FK-VV
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 09:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133Ab0LFIxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 03:53:52 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64089 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab0LFIxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 03:53:52 -0500
Received: by pzk6 with SMTP id 6so1792228pzk.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 00:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=KT5vdSmMi8gOSvxU2fE7oZF8bpWE9XxN4LDazMoH/CQ=;
        b=CNfijxCsQi+oNfGbv4Xw8e3TaU8VpLQKG/iyDHvqYRUG1wPiGtqeQk2K2JYDOCR1wq
         o9Y9jQl0PmAmwQ9mHlGSsaYkSdFs3b8e3LrJd5QqTlbdawwgVQjASqBRqoKWyWhNzBZE
         tK+Fi6zWJC0ovYkwPcwEMIgEzVK+6JcqMUAA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rtBAAO1dXyupep4SP0Oax12AF2g82+8DOnYmDU/itzlB0L/S+RA7aexEn+EZd5mMNm
         WR4NvToyBtFy95R1EEBYhTnCW2z6kEIbipTUZqIRVBj4gVBJz804rByE5GoDhxcfGBrU
         KW/KkcRxwyVVCA3//1eQrNIC9eqvCOlp5iR+8=
Received: by 10.143.162.5 with SMTP id p5mr4741425wfo.230.1291625631819;
        Mon, 06 Dec 2010 00:53:51 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id y42sm7010879wfd.22.2010.12.06.00.53.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 00:53:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <4CFCA445.2020205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162985>

Sorry for the dupe, I forgot to CC the list.

On 05/12/10 05:33, weloki wrote:
>
> There is probably an easy solution to this but I'm seeing something really
> weird...
> I can't seem to commit anything to my new branch. When I try to commit it
> just says "no changes added to commit (use "git add" and/or "git commit
> -a")"
> When I try to do git add it doesn't seem to do anything.
> When I try to push it says "Everything up-to-date", but when I look at the
> branch on github my files aren't there.
> Strangely I was able to do everything fine with a different branch I created
> afterwards.

One thing to check is where you're pushing to ("git remote show origin"
should tell you). You may also want to check the value of "git config
branch.master.merge", "git config remote.origin.url" and "git config
push.default".

For me these are
refs/heads/master
<my github project>
tracking

Also on a very fresh repository you need to use "git push origin
master:refs/heads/master" to create the master branch on the remote end.
