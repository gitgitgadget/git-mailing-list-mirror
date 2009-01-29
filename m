From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 13:20:20 +0100
Message-ID: <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
	 <20090129035138.GC11836@coredump.intra.peff.net>
	 <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com>
	 <20090129113735.GA6505@coredump.intra.peff.net>
	 <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
	 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
	 <20090129115026.GB10792@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 13:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVu1-0006aR-VF
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 13:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbZA2MUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 07:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZA2MUX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 07:20:23 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:2857 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbZA2MUW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 07:20:22 -0500
Received: by rn-out-0910.google.com with SMTP id k40so2867889rnd.17
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=Eenh3EzVCSf0IZmQDqEdwTmfiYxIwXGH6MW2fqSC3VY=;
        b=PZivwkGwVx0RciDC+ee2vzoM2b+HvhkIm/F9xXy19ooA7mGahTwJdLHRk5Nxq3SeaR
         WMqO/LRY5ngxqBVlYTgT7JiDl1xqEj+ALV8FotKOMncbCuk+gp2nvnAe3KVza8zQl2Nl
         jvt5b3NzuPeceV31euyj2oUqAiK0/Jvc/lteM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=nGVaXQIXk70OhM+sItS/y4cBSTj84u3vB5gpUDBUixHhphn3AF6fJzLM9I/+P63dV5
         s9dNA1KAOiA0cumZOgmijfIfEJgghY/PkVz3wJLs4rPOn6qki+SHxaHGyv7nTNPqKCHQ
         BCzLa7GgMqkOUPJRVGMre4YhJ88qzjufzmsm0=
Received: by 10.151.144.15 with SMTP id w15mr84700ybn.40.1233231620787; Thu, 
	29 Jan 2009 04:20:20 -0800 (PST)
In-Reply-To: <20090129115026.GB10792@coredump.intra.peff.net>
X-Google-Sender-Auth: a48e3b2e99370f7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107668>

On Thu, Jan 29, 2009 at 12:50, Jeff King <peff@peff.net> wrote:
> I think that would be reasonable.

Yay :).

> It wouldn't help the case of "somebody
> else pushed some content that you want to pull", but like you said, I
> think the primary workflow is that you immediately push after cloning
> the empty repo.

Also, the only way to support the "somebody else pushed already"
workflow would be to assume the user wants to name the branch
'master', which might not be the case at all.

-- 
Cheers,

Sverre Rabbelier
