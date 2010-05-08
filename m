From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control end-of-line conversion
Date: Sun, 9 May 2010 00:53:17 +0200
Message-ID: <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 09 00:52:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAst2-0002W2-F4
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 00:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab0EHWwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 18:52:39 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:45243 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab0EHWwh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 18:52:37 -0400
Received: by ewy20 with SMTP id 20so585596ewy.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 15:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=vXRp+2wAJLConvSzBth59izy/KQGudeRUOLRA6yv08g=;
        b=xw4+w/6s+gW4ApKQXhfO9KHzKK29zcqsbzpnhP3HYMVPuAbuCuQ73GAyD3TXgDKwgG
         leUjoxyx9ZLY5hSZkqOb1+EPwuiXZcpiXPzIYDwULhZdRpyd1BcstdertpLXlrVGy4xv
         mdrF+AVhYQN9M4nm/WnX3WILtMV0QhyPPogxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=ZFuYGKOGE7pfCfyxtyGslRa8hPgWrhVBxdBiiPqCsiEsEOSuYgRvJ/Xmda17pj7D8S
         TuLwcm5uzJqD94PulgLW/EftWj9TVgSo2HsDm9eheo7UANgW6MuhmwOdeJ4UfwGlViXp
         WtXNgikshjfvCPCbov4KN9T8Ao7qcLdDzjR80=
Received: by 10.213.44.14 with SMTP id y14mr796946ebe.96.1273359155884;
        Sat, 08 May 2010 15:52:35 -0700 (PDT)
Received: from [172.16.3.207] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm1812868ewy.14.2010.05.08.15.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 15:52:35 -0700 (PDT)
In-Reply-To: <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com>
X-Mailer: iPhone Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146684>

On 9. mai 2010, at 00.17, Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com 
 > wrote:

> I'll try to think of a better name.

Heh. How about "localcrlf={true,false,native}"?

It breaks down a bit if we ever decide to support old-school-Mac-style  
CR line endings, but at that point you're approaching the borders of  
madness anyway.
-- 
Eyvind
