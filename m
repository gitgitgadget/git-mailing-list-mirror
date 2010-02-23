From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Mon, 22 Feb 2010 22:20:41 -0500
Message-ID: <4B834989.50502@gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com> <4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix> <4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Feb 23 04:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjlKN-0003PT-EU
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 04:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0BWDUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 22:20:47 -0500
Received: from mail-qy0-f191.google.com ([209.85.221.191]:54563 "EHLO
	mail-qy0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab0BWDUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 22:20:46 -0500
Received: by qyk29 with SMTP id 29so637543qyk.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 19:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=O4D0yDmCVoCuhuHTWWZixFm3zey0ciHhqQlyGUQRQOY=;
        b=JJoXHJ/g8fKllxKrcqdQGJ1a0rIw2fvJwkbC7AcKpB2sc61YabzWTHNI78fjcMmuYd
         LPZZbuy6X/avrS91sLduj+IdwjRiRh8PH6qlySNNAi5cpE0v824St+xqt85FBBjy8gl5
         srJdZR0a4Pmll5hFEjzEeuVt7nKEzJSlYJGlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wqY1cddT6fRSSxReAnG86YKmgT2939TL0tFlTPNbUdKJA8sf375zpO7meUwSLZzTkA
         hf97UaVjHPU+X1g3KU77C8u+DC+wO7AV9UXGT3aa1CZpjq556wy4r6D8Puz2kcdNA0LK
         Z7jRAQanx1+NDi1GR+LRrhh9Mux2DcabtIfEU=
Received: by 10.224.36.69 with SMTP id s5mr6522103qad.359.1266895245302;
        Mon, 22 Feb 2010 19:20:45 -0800 (PST)
Received: from ?192.168.2.202? (dsl-147-130.aei.ca [66.36.147.130])
        by mx.google.com with ESMTPS id 23sm3221812qyk.7.2010.02.22.19.20.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 19:20:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <20100222105133.GA10577@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140765>

On 2010-02-22 05:51, Ilari Liusvaara wrote:
> bzr::ssh://something/somewhere ?
> 
> That goes to git-remote-bzr (as 'ssh://something/somewhere').
> 
That would be feasible. But for users, when they copy URLs from sites,
they'd probably like to use it as is. (I'd like it to be like that :P )

But, as long as it's not possible right now to use "+" in the URL, I can
implement it exactly like you said and maybe change it later if helper
names obtain the right to have non-alnum characters.

-- 
Gabriel Filion
