From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 22:42:07 +0200
Message-ID: <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>  <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>  <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>  <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 22:42:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUNE-0004DO-LK
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab0EGUmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:42:11 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:49173 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab0EGUmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:42:10 -0400
Received: by ey-out-2122.google.com with SMTP id d26so139844eyd.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=WPFDPKn95lMi+kV+T70gfJ18EhJvzrP92kzgCBASMqA=;
        b=ss0tcJXhqzYqNFG3gTO0yszIl5ggX2VCXXV8uyn/rGT53ONowc7o3ZdupRy1MLod6+
         KDjcpuWlryVP76dw8bvxob8QEtG22kt2BGhBWHkmhZ2OY8J+ATIbMUlB8Mk0DdW2h3k5
         lyyYIDq3bMnKIF0JVWF7It3oX3ZMtjfpqLzfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=jJFqiUkJtDdp1YGzA/93EqW3d7L1ZCtXeCyg176Jc6Oq3iYO4bCo0hATODDETqLXo5
         QKkCJJue2qqzA4APpKVBi2JQCrVoEMw/J6HqcfiwATBF4B61Qwtyfu4Yo+Sw2eBF6wrm
         ulO7bQ1aDOmEl//HDI9SSO5RrLpPoMKNsUImA=
Received: by 10.213.37.67 with SMTP id w3mr4278129ebd.69.1273264928966;
        Fri, 07 May 2010 13:42:08 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 16sm1324319ewy.15.2010.05.07.13.42.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 13:42:08 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146592>

On 7. mai 2010, at 22.17, Linus Torvalds wrote:

> 
> 
> On Fri, 7 May 2010, Linus Torvalds wrote:
>> 
>> Now, the thing is, we can go for even simpler syntax still, by just making 
>> that ".gitconfig: core.autocrlf=true" entirely unnecessary. 
> 
> Exact semantics I'd suggest for 'core.autocrlf':
> 
>    Setting		path in .gitattributes	path _not_ in .gitattributes
>    =======		======================	===========================
> - not set at all	attribute value		no crlf
> - "off"/"false"	no crlf			no crlf
> - "on"			attribute value		autocrlf	
> - "input"		attribute "input"	autocrlf "input"
> 
> Which is different from what we do now for the "not set at all" case, 
> in that it still takes the .gitattributes value for those cases if a path 
> matches.
> 
> We could add a few core.autocrlf entries, like "force" (to force output to 
> be CRLF even on a platform where it isn't the default).

How can you say that this is simpler than my syntax?  I have an attribute that means "line endings should be normalised" and a configuration variable that decides what line endings should be used in the working directory for normalised files.  If you like CRLFs you set it to "crlf", if you like LFs you set it to "lf".

I'll replace "auto-eol" with something like "crlf=auto" because I actually think that's pretty neat, but I won't pretend that "true" and "input" are sane ways to indicate if you prefer CRLF or LF line endings in your working directory.
-- 
Eyvind
