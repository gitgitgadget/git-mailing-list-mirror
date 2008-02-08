From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make use of the $git_dir variable at sub git_get_project_url_list
Date: Fri, 8 Feb 2008 10:15:39 +0100
Message-ID: <200802081015.39707.jnareb@gmail.com>
References: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br> <20080208041542.GA28336@c3sl.ufpr.br> <7vbq6sm0j3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPLR-0005sS-JM
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 10:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbYBHJPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 04:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760943AbYBHJPz
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 04:15:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:27971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757654AbYBHJPx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 04:15:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so845210ugc.16
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 01:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=EnQ96FZZZPLSjdNhRoJn69Z/KaDg6usEt3UpERkgKtw=;
        b=P41LiQPKurIy9ExyPYpkk3FBj1dGxTnWgqt7cOHlz8b6DE//AqegA/B0Oa/VCcF9RiN7xl9Yzxr9eA0DTpB8BxgzwKC9u/R7z5LRggF6cnI3FDiIqnxKfe6C7r48bG3vjh4mBV+MxYObP1ftikPgLQ/mRV+YT5D19fEC3FMv4K4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RpljObYOKLXSFTySutqWsDOJogwPrdQi/LlrSwfvCtUyeKJx+Hm0HA9G4t0IIPldvz0QnbwjSA41iZsWchm7Eu0dZqM31LBQCUAGgYssOTNQ9jubf6nP51dumAYqpOlaeoNtg1XQ02IviRempLtur27tfqvjggUb4QQpSkHAXk8=
Received: by 10.67.98.15 with SMTP id a15mr5139829ugm.69.1202462151276;
        Fri, 08 Feb 2008 01:15:51 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.242.186])
        by mx.google.com with ESMTPS id j4sm3656394ugf.49.2008.02.08.01.15.47
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 01:15:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vbq6sm0j3.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73055>

Junio C Hamano wrote:
> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
>> On Wed, Feb 06, 2008 at 11:37:51AM -0800, Jakub Narebski wrote:
>>> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
>>>
>>><snip> 
>>>
>>> Good catch (although it wasn't actually a bug).
>>
>> Not a bug but makes the code cleaner =)
> 
> I think I saw very similar 's|projectroot/$path|$git_dir|' patch
> recently.  If there are more of the same, I'd rather see all of
> them in a single patch.

That's all that it is. Those patches are about places where we read
file inside repo or get repo config, and there are only two places now: 
description and cloneurl/URL list.

-- 
Jakub Narebski
Poland
