From: Ian Hilt <ian.hilt@gmail.com>
Subject: Re: [PATCH] Rephrased git-describe description
Date: Wed, 14 May 2008 14:00:04 -0400 (EDT)
Message-ID: <alpine.LNX.1.10.0805141329020.28504@sys-0.hiltweb.site>
References: <1210774947-27995-1-git-send-email-ian.hilt@gmail.com> <19174A63-BE44-4898-9CAD-935BE1A28FFF@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed May 14 20:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLHX-0000Iz-2B
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756397AbYENR77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756270AbYENR77
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:59:59 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:9919 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbYENR76 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:59:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so3692and.103
        for <git@vger.kernel.org>; Wed, 14 May 2008 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type;
        bh=waUqdKElAc7ya9zFsUKi6+nVJQKdv0+zfyUnY+nqhEk=;
        b=mclbs/dLfpjpgkhILi4aZg6mIOjlyIJnstuHnNtoqHLEEpMaCdjxzj7e8IYYw8cm08hDmMdupjpnS5vOtn7phwS+uLncfP3DqCYr3eWQGtsNtzA9RbahOQ3zTN3Geg8/vmNCCClLbe7TXTex0QJ8NR5F/AUkXSDUTc2An6QG+no=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:in-reply-to:message-id:references:user-agent:mime-version:content-type;
        b=gm5Uq/dKHV9d35VWwttTEiU/G/6Iki0VNTSpyop/S0cF23sV5s71nsRSXeB+d0jXzsfNcO4Gn6U0F30yq1XhCz47cwBflW5VzgSkr8DljuoWNOqLkDsMrCJksmSd3MTeRM6MNoknSDB73ZYhLoQ/N14mgUXxI25IrF3cULSkoPw=
Received: by 10.100.41.9 with SMTP id o9mr1612823ano.84.1210787997763;
        Wed, 14 May 2008 10:59:57 -0700 (PDT)
Received: from ?192.168.1.1? ( [75.185.208.72])
        by mx.google.com with ESMTPS id c30sm2805322ana.27.2008.05.14.10.59.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 10:59:57 -0700 (PDT)
In-Reply-To: <19174A63-BE44-4898-9CAD-935BE1A28FFF@sb.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82123>

On Wed, 14 May 2008 at 11:57am -0500, Kevin Ballard wrote:

> On May 14, 2008, at 9:22 AM, Ian Hilt wrote:
>> DESCRIPTION
>> -----------
>> The command finds the most recent tag that is reachable from a
>> -commit, and if the commit itself is pointed at by the tag, shows
>> -the tag.  Otherwise, it suffixes the tag name with the number of
>> -additional commits and the abbreviated object name of the commit.
>> +commit.  If the tag points to the commit, then only the tag is
>> +shown.  Otherwise, the number of additional commits on top of the
>> +tagged object and the abbreviated object name of the most recent
>> +commit are suffixed to the tag name.
>
> I disagree that this is more readable. Specifically that last
> sentence. In the original description it tells me what it's
> doing (suffixing) before it tells me what objects it's
> using. In your version, it tells me the objects, then tells me
> what it's doing (suffixing), so I have to effectively process
> the sentence in reverse. In other words, it took me two
> readings of your last sentence to match the one reading of the
> original last sentence.

How about this?

   The command finds the most recent tag that is reachable from a
   commit.  If the tag points to the commit, then only the tag is
   shown.  Otherwise, it suffixes to the tag name the number of
   additional commits on top of the tagged object and the
   abbreviated object name of the most recent commit.

> Also, you should use a more descriptive commit description. At the very 
> least, do something like
>
> git-describe: Make description more readable.

Something like this:

git-describe: Changed subject from commit to tag in the first
               sentence, clarified what the number of commits is
               referring to, and pointed out which object is
               referenced by the suffixed object name.

-- 
Ian Hilt
ian.hilt (at) gmail.com
GnuPG key: 0x4AFC1EE3
