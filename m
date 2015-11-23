From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2015, #03; Fri, 20)
Date: Mon, 23 Nov 2015 17:00:03 +0300
Message-ID: <56531BE3.80803@gmail.com>
References: <20151120140937.GA17079@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 15:01:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0rfD-0004iT-Lc
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 15:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbbKWOAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2015 09:00:09 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33903 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbKWOAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2015 09:00:07 -0500
Received: by lbbcs9 with SMTP id cs9so96053871lbb.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 06:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=NevvXnSuIhGGZWDvQGjyh7qXVL6VnaCoVWB72LgVCs8=;
        b=cqJZ+km/9ivmgbcqRkwWU/CA4ngjB9IxGatGVosIbtNlWJarlHJXCyePoHtw6GsYHe
         AoG0AWdX/7U1vIP4+6Vk0Lr+a6e9ghSLg9OjD0HU1qXa7UehW1xkUuKWrWYZUtdnNncz
         DTZ7nvRL7JPuFlFE31vUggVybzRbvX168b6aAkvC+FbkMuBY5l2q/ISvaq6tfrAlmYjn
         oa7xVZMHHsxZpj1iXc41i9dNFSzLMFMGdgeBw2g8g2C8XfdUQzR94gLMe3GZCW09wtqj
         llBJZCUoviwLKCWow+GyLasS2tRmRgxkpFCJ2kJbncVjMinOgFxX6YPTwfDRsCuRvq8p
         0wwg==
X-Received: by 10.112.141.70 with SMTP id rm6mr1782084lbb.94.1448287205385;
        Mon, 23 Nov 2015 06:00:05 -0800 (PST)
Received: from [192.168.1.101] (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id br10sm1865063lbb.4.2015.11.23.06.00.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Nov 2015 06:00:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <20151120140937.GA17079@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281585>


On 11/20/2015 05:09 PM, Jeff King wrote:
> * vl/grep-configurable-threads (2015-11-01) 1 commit
>   - grep: add --threads=<num> option and grep.threads configuration
>
>   "git grep" can now be configured (or told from the command line)
>   how many threads to use when searching in the working tree files.
>
>   I haven't reviewed v6 yet. More eyes are welcome.
Actually v6 includes only changes to special meaning of "0" (0 is now 
default behavior - 8 threads), little corrections to documentation and 
getting rid of online_cpus() in decision-tree. All as discussed in 
comments for v4/5.

--
Victor
