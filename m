From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: feature request: git-log should accept sth like v2.6.26-rc8-227
Date: Fri, 11 Jul 2008 01:08:43 +0200
Message-ID: <200807110108.45072.jnareb@gmail.com>
References: <200807102057.15063.toralf.foerster@gmx.de> <alpine.DEB.1.00.0807110022510.3279@eeepc-johanness> <7vk5ftnyhp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 01:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH5Hd-0001zz-GY
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 01:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbYGJXJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYGJXJn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 19:09:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:51237 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbYGJXJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 19:09:42 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1760693ywe.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AAFjZHNJgW6A2zME+VKkHgsdpSf9tOQL8bBZLY7HKRU=;
        b=j+55UrQJOWbXjpLSCEYWes7jrAZszx4EOfufjMnqJSZYJHpc0r3+35n6kaxYDC7RxT
         IppcNtbR5bhhyHM9QTUolAHwdn/JAvJsg4FElKcFlA3deyYC/kbS2RzqIBa27hyC3wxD
         Lg1bRT50eBSEznBoMZK/JQCYWKuVwtYH6TfOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qIk940gx4bmEZiBYXhf8aOQdCuZQ60fLY156MDV5Np4m+exBbZkeXrQ50ouKw0uYl+
         VOVkilRp406rgxbfYtbufhdqFgZxJ2YCmEiSAu91LnTjIus3u9PY3Gw+mIfnPkyojV6F
         ZxtGZ3er5hOGRiH5zwVfDjF18AhRalLxg3/6w=
Received: by 10.114.132.5 with SMTP id f5mr3983679wad.201.1215731364930;
        Thu, 10 Jul 2008 16:09:24 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.245.18])
        by mx.google.com with ESMTPS id 4sm962058fgg.9.2008.07.10.16.08.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 16:09:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vk5ftnyhp.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88049>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> On Thu, 10 Jul 2008, Junio C Hamano wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>> Besides, it would be nice to have some command (git-rev-parse 
>>>> perhaps?) which could take ambiguous commit-ish, and list all commit 
>>>> which matches it.
>>> 
>>> Have fun writing it and send in a patch.
>>
>> Note that this really could be a patch, but not for rev-parse.  Patch 
>> revision.c instead to parse the argument into _all_ matching revisions.
> 
> As Linus pointed out, that is "all _locally_ matching revisions".  It is
> of dubious value in a distributed environment.

It can be useful for example in situation where shortened sha-1 of
a commit (for example to 6 characters) stops being ambiguous...

-- 
Jakub Narebski
Poland
