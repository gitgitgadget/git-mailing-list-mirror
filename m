From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 23:17:02 +0200
Message-ID: <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org>  <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>  <alpine.LFD.2.00.1005071213550.901@i5.linux-foundation.org>  <i2i32541b131005071235z64c9de56w29a2d555cf801c9a@mail.gmail.com>  <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org> <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com> <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org> <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org> <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com> <alpine.LFD.2.00.10
 05071355380.901@i5.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 07 23:17:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAUvA-0001fs-2o
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 23:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab0EGVRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 17:17:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59647 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab0EGVRO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 17:17:14 -0400
Received: by fxm10 with SMTP id 10so1096058fxm.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=c6F5ihiFrJMl7ffMaBdJTBGxehVr8Sqn0n6q0ggq9dY=;
        b=QU32VSHQq9jGy2ERgx96hUZT5pPnNyWa9PFwj9fL72Fn/14oKSLp6A2GzeEA6Vk19D
         l7/aipH/WuqxED469mvHa5qwFUAX+joRgJJAzYZcTVky0BnnNbSO4SWPhqfbXUev+9kd
         YIF+eRE72D/Ix/+fvkoQFw47JXNY16psiOm2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=XE5POn8c27Eo4dtYYqvoKN/eO0JicRCYM/xXwX/lfN2bldvvc9AuCkN9dzNxHER5fM
         SM4taforShDMaYNnOLYZlKJBJy54Dgnf/KA6rY+ZwAW1rVqWrEK+4lZ/wq84+naMfYi5
         cHD/PFydIZVuJlfhyWsmf+g9E7uaSs9GGShLA=
Received: by 10.87.72.2 with SMTP id z2mr1744660fgk.29.1273267031410;
        Fri, 07 May 2010 14:17:11 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 26sm5037365fks.22.2010.05.07.14.17.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 14:17:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146601>

On 7. mai 2010, at 22.57, Linus Torvalds wrote:

> On Fri, 7 May 2010, Eyvind Bernhardsen wrote:
>> 
>> How can you say that this is simpler than my syntax?
> 
> Because your syntax adds totally new attributes, so now you can't even 
> take an existing .gitattributes and make it do something sane - instead 
> you have to write totally new rules.

I don't understand.  All you have to do is add "* auto-eol=true" to your .gitattributes, and line endings will be normalized exactly as if you'd set "core.autocrlf".  Why would you have to write totally new rules?  Which rules?

> My suggestion just makes any existing usage do the "what you'd expect".
> 
> THAT is simpler.

Well, sort of, but "simple for someone who already knows how core.autocrlf works" isn't what I'm aiming for :)
-- 
Eyvind
