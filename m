From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Sun, 19 Jul 2009 08:05:58 +0900
Message-ID: <20090719080558.6117@nanako3.lavabit.com>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Finn Arne Gangstad <finnag@pvv.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 01:13:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSJ5R-0003tW-8N
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 01:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbZGRXIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 19:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbZGRXIl
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 19:08:41 -0400
Received: from karen.lavabit.com ([72.249.41.33]:39496 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753697AbZGRXIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 19:08:40 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id C039E11B8F3;
	Sat, 18 Jul 2009 18:08:39 -0500 (CDT)
Received: from 4878.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id JLQKCX5XXLLZ; Sat, 18 Jul 2009 18:08:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=M6Cv/63/RkRpFuTLGGZFHcFw35BLolkLcC4yK0GUYo7zXP0/ojkLu8i+rbySeElcAFHleJzpPitCbnlk+NQqCE1AMRRra0Dg25nEBGOdNVunAN+fphX4rYGit3gJhYJf3D9SYCMQpADL+kglMUruaE/sPqbNnIIH3mVIqVPM2RE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123541>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> When the user does not tell "git push" what to push, it has always
> pushed matching refs.  For some people it is unexpected, and a new
> configuration variable push.default has been introduced to allow
> changing a different default behaviour.  To advertise the new feature,
> a big warning is issued if this is not configured and a git push without
> arguments is attempted.
>
> 	Side note: we might want to tone this down, as it does not seem
> 	likely for us to change the default behaviour when this option is
> 	not set.

I thought you applied this patch from Finn Arne:

    http://article.gmane.org/gmane.comp.version-control.git/119173

but apparently you didn't.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
