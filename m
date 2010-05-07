From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 21:23:47 +0200
Message-ID: <D735B346-968F-4AAE-8990-27ECCCA812AF@gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com>  <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>  <alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org>  <alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 21:24:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAT9S-0003sG-W3
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012Ab0EGTXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:23:53 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:65384 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884Ab0EGTXv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 15:23:51 -0400
Received: by ewy20 with SMTP id 20so380816ewy.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=moMTgnjJrrDom+zlJba6Ntu9ZOi5O1N5t82cJJliA2o=;
        b=euzhYx8Z+O3N5r8C4gl4INkQDEkHjyJFhUyrcO+MSP/fV+IPQMv+KeusVXQ0XQaA1q
         U5zgWcge/37SFoLNGLiZQpR9UkUUjfHMfE467QFb72z6Ve23/S6nlBlfpH6wtlNnvoEY
         Ghi0ET+Ce946R5YxqhRdX2628tCIBbuMzwoQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=o7LOI3LXr7+6iG0Pz2uE+hW7WgMvvhji21QFcbWMsaxA0NQVbNqqPH2OdDVN+k476A
         U+XzWf0lc4+/0hevg9eF4xTAHNyB/m4l+FYRFuMWIqPLMjUcu+vHwi1soLniMgGvvWo+
         ZJdl7VkaJhNRS/tNbAzAtg6uv19qyjz6CI7XU=
Received: by 10.213.43.66 with SMTP id v2mr4262928ebe.97.1273260229262;
        Fri, 07 May 2010 12:23:49 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm1282214ewy.9.2010.05.07.12.23.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 May 2010 12:23:48 -0700 (PDT)
In-Reply-To: <n2k32541b131005071211sb2411334v4f0919abfeb4cbb7@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146559>

On 7. mai 2010, at 21.11, Avery Pennarun wrote:

> On Fri, May 7, 2010 at 3:02 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Btw, another option might be to start searching ".gitconfig", but only
>> allow a certain "safe subset" of config options in that. Things that can
>> really be about the project itself, and not per-user or per-repository.
>> [...]
>> Things like
>> 
>>        core.autocrlf
>>        i18n.commitEnconfig
> 
> Unfortunately this option wouldn't be as flexible as Eyvind's current proposal.

Thanks for the support!

My objection to this idea is more practical: I suspect that parsing .gitconfig from the repository would be a lot more work than my simple hack :)
-- 
Eyvind
