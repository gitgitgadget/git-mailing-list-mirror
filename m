From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 16:59:56 +0200
Message-ID: <4840166C.3030903@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 17:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K266L-00058d-Dv
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbYE3O75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 10:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYE3O75
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 10:59:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:2005 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYE3O74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 10:59:56 -0400
Received: by nf-out-0910.google.com with SMTP id d3so32003nfc.21
        for <git@vger.kernel.org>; Fri, 30 May 2008 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=nujFuPsnxmK9/J8JEMm6sj938O0KtlD/xOORYovpTbg=;
        b=n7xz5uWFvrmfgpzc0bhGvkUPUmOvfSdxzO6Z3RttxhzZ6SwqL2fW8vIBx7DwMxUK2FJvZU134EpjAW7CBGye8sPJONpDoTn8kyVXe7NllM6I88qV3WISzS8d/fSJ5TY7/BJNWWHqT5WAgZss25R500gBg2lBkr0PD1xbOw7HvZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=HnOo8T737Gvc+gqvkL8e4W4E4yR/2SSp6OXBoMXKU2L+qpgn49rTAbbj99RG/yN0acGi+h2Z6OrWy+wH+fxeLCNB4zfE1+Am/CHelY9SJk+zk7qgJhGMiTW1w70KhGy6kS+yyN/Ok2x64uCqQVncP4pFJS6bEosfgoSqw3V20Xw=
Received: by 10.86.23.17 with SMTP id 17mr967786fgw.44.1212159589426;
        Fri, 30 May 2008 07:59:49 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.225.53])
        by mx.google.com with ESMTPS id e32sm1804075fke.15.2008.05.30.07.59.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 07:59:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200805301202.25368.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83305>

Jakub Narebski wrote:
> even if you don't implement two caching API's at least make it
> possible to easy change caching backend.

Sure, I'll keep that in mind.

> Note also that memcached may not have sense for single machine [...],
>  and does not make sense for memory starved machines...

For single machines, memcached certainly works fine.  For on 
memory-starved machines with HD caches, you'd have to cache the 
aggregate HTML data, not the data in the backend.  So as long as I'm 
working on the backend (repository) cache, memcached should be fine.

> IIRC the policy usually is that one can install packages
> from main (base) repository for Linux distribution used on server,

libcache-memcached-perl is in Debian stable; that's fair enough I think. 
  Cache::Memcached::Fast doesn't seem to be in Debian as of now, but I 
wouldn't worry about performance unless it comes up.

>>> By the way what do you think about adding (as an option) information
>>> about gitweb performance to the [HTML] output,
> 
> I'd try to add it when I'd have a bot more of free time

I'd probably wait with this until I've written the Perl Git API.

-- Lea
