From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 16:20:46 -0500
Message-ID: <76718490901131320y6e3312f1o96b99407f318fafd@mail.gmail.com>
References: <loom.20090113T145019-951@post.gmane.org>
	 <loom.20090113T150220-345@post.gmane.org>
	 <496CD49D.1070201@drmicha.warpmail.net>
	 <loom.20090113T185918-397@post.gmane.org>
	 <20090113203922.GD30404@atjola.homenet>
	 <loom.20090113T204616-845@post.gmane.org>
	 <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_311437_19235151.1231881646432"
Cc: git@vger.kernel.org
To: "Vladimir Pouzanov" <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqik-0000eh-MX
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbZAMVUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757452AbZAMVUs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:20:48 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:9922 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365AbZAMVUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:20:47 -0500
Received: by rv-out-0506.google.com with SMTP id k40so182340rvb.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=h+580BZeblwza4TwhN/+ZPYvOzkH41eDDptT6n7oD+4=;
        b=GIi/kV67EnyZ2B6B03uLaRQ7uvveEaSPd5I9Wf49uH6V3xy6/kZFjBhFxPUt7bCGgZ
         uNIIlv4jHBKjIP7Rwzb5UJyZLXps17iUuZp8jKnyl0X+0npyJEXpKtIpmsZu4BDB1hT+
         9W7p0V6MxdyIOqyj+o25ePnPXz1iP/iUfKbKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=DnbJTY3w34bkVuJ9J8sC6rOT0scPgipB+d8heocxkV8+FaIl8L8fNe/Odf+gDb6WsH
         Cq7Yl+CpQOCZXIiQlMH9oK/pBqMrJSXRS1zoDwMX+Ql9ucM5BzaUMllXikQpYfukcueQ
         cXCr0GdIb17BbLHgWPiTWayMtU03rhV91MC4o=
Received: by 10.141.96.19 with SMTP id y19mr15483371rvl.89.1231881646446;
        Tue, 13 Jan 2009 13:20:46 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Tue, 13 Jan 2009 13:20:46 -0800 (PST)
In-Reply-To: <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105537>

------=_Part_311437_19235151.1231881646432
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Jan 13, 2009 at 4:12 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Your original email doesn't appear to provide the complete error
> message. I'm on OS X 10.5.6 (Intel), git 1.6.1.77.g81ea1, system perl
> (/usr/bin/perl - 5.8.8) and I'm able to clone okay:

BTW, since it's the system perl, it's also the system Perl subversion
bindings, which means 1.4.4.

IOW, even though I have MacPorts installed, I define NO_DARWIN_PORTS=1
during install. I've attached the script I use for compiling &
installing git for reference.

j.

------=_Part_311437_19235151.1231881646432
Content-Type: application/octet-stream; name=gitmake
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpx2ih2x0
Content-Disposition: attachment; filename=gitmake

IyEvYmluL3NoIC1leAoKZXhwb3J0IFBBVEg9LjokUEFUSAoKU1VETz0KZXhwb3J0IEFTQ0lJRE9D
OD0xCmV4cG9ydCBET0NCT09LX1hTTF8xNzI9MQoKbWFrZWNtZCAoKSB7CgkkU1VETyBtYWtlIHBy
ZWZpeD0iL29wdC9naXQiIFwKCUNGTEFHUz0iLVdhbGwgLU8yIC1JL3Vzci9pbmNsdWRlIiBcCglM
REZMQUdTPSItTC91c3IvbGliIiBcCglDVVJMRElSPSIvdXNyIiBcCglPUEVOU1NMRElSPSIvdXNy
IiBcCglJQ09OVkRJUj0iL3VzciIgXAoJUEVSTF9QQVRIPSIvdXNyL2Jpbi9wZXJsIiBcCglUSFJF
QURFRF9ERUxUQV9TRUFSQ0g9MSBcCglOT19GSU5LPTEgTk9fREFSV0lOX1BPUlRTPTEgXAoJIiRA
Igp9CgpidWlsZCAoKSB7CgkoY2QgZ2l0LWd1aSAmJiBzdWRvIG1ha2UgY2xlYW4pCgltYWtlY21k
IGFsbCBkb2MgZ2l0d2ViL2dpdHdlYi5jZ2kKfQoKdGVzdCAoKSB7CgltYWtlY21kIHRlc3QKfQoK
aW5zdGFsbCAoKSB7CglidWlsZAoJc3VkbyBybSAtcmYgL29wdC9naXQKCVNVRE89c3VkbyBtYWtl
Y21kIGluc3RhbGwgaW5zdGFsbC1tYW4gaW5zdGFsbC1odG1sCglzdWRvIHJtIC1yZiAvb3B0L2dp
dC9TeXN0ZW0KCXN1ZG8gbWtkaXIgL29wdC9naXQvc2hhcmUvZ2l0d2ViIHx8IHRydWUKCXN1ZG8g
Y3AgLWYgZ2l0d2ViL2dpdCogL29wdC9naXQvc2hhcmUvZ2l0d2ViLwoJc3VkbyBybSAtZiAvb3B0
L2dpdC9zaGFyZS9naXR3ZWIvZ2l0d2ViLnBlcmwKCXN1ZG8gY3AgY29udHJpYi9naXR2aWV3L2dp
dHZpZXcgL29wdC9naXQvYmluL2dpdHZpZXcKCXN1ZG8gY2htb2QgNzU1IC9vcHQvZ2l0L2Jpbi9n
aXR2aWV3CglzdWRvIGNwIGNvbnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoIC9v
cHQvZ2l0L3NoYXJlL2dpdC1jb3JlLwogICAgCXN1ZG8gY2htb2QgNjQ0IC9vcHQvZ2l0L3NoYXJl
L2dpdC1jb3JlL2dpdC1jb21wbGV0aW9uLmJhc2gKfQoKY2FzZSAiJDEiIGluCiAgdGVzdCkgdGVz
dCA7OwogIGJ1aWxkKSBidWlsZCA7OwogIGluc3RhbGwpIGluc3RhbGwgOzsKICAqKSBidWlsZCA7
Owplc2FjCg==
------=_Part_311437_19235151.1231881646432--
