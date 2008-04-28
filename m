From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Yet another Git tutorial
Date: Mon, 28 Apr 2008 18:40:38 +0200
Message-ID: <4815FE06.90002@gnu.org>
References: <2D3D2E55-74C7-4373-BC22-9CF4C26C197D@newartisans.com> <4557C7EE-2B56-4836-A2AC-09EAF05FD95C@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Wiegley <johnw@newartisans.com>,
	git list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 18:41:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqWQF-0007Oj-Fp
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 18:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933649AbYD1Qk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 12:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933691AbYD1Qk4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 12:40:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:31513 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933649AbYD1Qk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 12:40:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1928613nfb.21
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 09:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=gdcobjrzRcx+qlm4KBmdeK8IyLNMTLqs033HHYuH4/8=;
        b=e6CG+y3hOqIkaGb9geHd5Qnf7wZrxrZ8WCQb6GDJ63bDB3mt59B7Klq5Cx3mJMobCF0I1GuhhwWpnWj36QAavfPxIQ8oBE+614C16hhkISNymTLcpd+ZWuA2hxYL66JXjPSM5qjX4KVBxUr5MeJaz06vQW3N3RqXKXL2SzXhgbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=cBGaiJILOCKj+WUcTbCpXUIUsclC8tVKnG6WIZ3juWexxw+jhm/x2qKxJapXlJKOJAVDSytQ12xwKHr/B7OMBfk++fBRYKpMBBWc0Xz9nWKZCYMqZUe64CV/Q91gIkv2YYwkcfV0GE7h/gu+jbBSHtjdXMlkSrRw4M7DfNTyIec=
Received: by 10.78.172.5 with SMTP id u5mr4165637hue.10.1209400854169;
        Mon, 28 Apr 2008 09:40:54 -0700 (PDT)
Received: from scientist-2.local ( [213.55.131.23])
        by mx.google.com with ESMTPS id 36sm5542674hub.16.2008.04.28.09.40.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Apr 2008 09:40:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4557C7EE-2B56-4836-A2AC-09EAF05FD95C@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80558>

> (p.4) On my system, `echo "Hello, world\!" > greeting` puts the 
> backslash into greeting.  Of course, leaving it out leaves an error.

Using single quotes, as in `echo 'Hello, world!'`, should work fine.

Paolo
