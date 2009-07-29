From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 17:40:00 +0900
Message-ID: <20090729174000.6117@nanako3.lavabit.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
	<7vljm84htf.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4iG-0007eA-6j
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbZG2Ika (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 04:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbZG2Ika
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:40:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49092 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbZG2Ik3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 04:40:29 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id C0A8E11B799;
	Wed, 29 Jul 2009 03:40:29 -0500 (CDT)
Received: from 2373.lavabit.com (190-14-246-42.ip.mediacommerce.com.co [190.14.246.42])
	by lavabit.com with ESMTP id FKP06WGRDJ2X; Wed, 29 Jul 2009 03:40:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tXccUPKxPqeRbdUnzbNejubnAaWdM5mZAI9DpcxsrSniEl5t40nClskg6Xj08vESeDQ9zf5yc2qY1P3k7gDUgOe+1+8Ph7mlfIHLUgNr04svBQ+/9uGie76uTX7Phm9IeuTd59IpJcxJeN4PXrDMVugOphkMZA6vSLexUlVW9bc=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124325>

Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

>> Perhaps --ignore-space-change, to be consistent with a "git diff" option,
>> would be more appropriate. Doing so has an added benefit of leaving the
>> door open to add --ignore-all-space option to the patch application side
>> later.
>
> On the other hand, --ignore-whitespace matches the option name (and
> behavior) of the 'patch' command (just like "git diff"'s matches the
> 'diff' option name and behavior). Principle of least surprise says
> that someone coming to git from raw diff/patch setups would expect
> --ignore-whitespace on the patch side.

Not everybody shares your diff/patch background.

I wouldn't be surprised if git were the first system they ever learn for
majority of users of version control systems in this century, especially
because now there are many books written on it.

Isn't it more important for git to be internally consistent across its
commands for such an audience to satisfy the principle of least surprise?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
