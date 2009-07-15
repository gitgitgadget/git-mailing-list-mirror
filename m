From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] Re: git-am: fix maildir support regression: accept
	email file as patch
Date: Thu, 16 Jul 2009 00:43:08 +0200
Message-ID: <20090715224308.GA12971@vidovic>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRDC6-0006yj-3N
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272AbZGOWnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756239AbZGOWnO
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:43:14 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:35183 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167AbZGOWnO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 18:43:14 -0400
Received: by ewy26 with SMTP id 26so4437098ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ns2br1zOW2fl3wobQb5k2l1OLDQBNBNMMfAVzZ60Kz4=;
        b=MAfXFSM30jlsURnpwCKDuLS8V/JwJV46hcoKBRNvv2m1iASh6FE2Pc3WtfWdZo70kz
         atL5eLvcQxjIj46K+tChdPuyhdzHxYAl1wyfa2yeB43E09t/9WKN7GAU2RQAks4aHf/g
         mCMl9Q6Y1RJbDfyQpLWeVDyFJFQrU4azo3znw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eyja7lTNKt/XgeJ/fPOX343twEXR/NEdolHNVJipm0Stykn9J51FdVUAu3v6eKQE3g
         VstTbf/6Pt/SsqTFPimPTw5POGX9Vmsi9UsDm5Pllo+Y3jsk/VmiYjsGzTElt07f+K7q
         hBY8S67maubPP1itSQYZpkZCbzsocj16GJ6Hs=
Received: by 10.210.88.3 with SMTP id l3mr8813380ebb.17.1247697792606;
        Wed, 15 Jul 2009 15:43:12 -0700 (PDT)
Received: from @ (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 5sm3097602eyf.48.2009.07.15.15.43.11
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 15:43:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123342>

The 16/07/09, Nicolas Sebrecht wrote:

> Patch format detection introduced by a5a6755a1d4707bf2fab7752e5c974ebf63d086a
> may refuse valid patches.
> 
> We keep detection on the first three lines. Emails may have:
>  - header fields in a random order;
>  - folded lines.

I realized this patch is wrong. Please ignore it.

-- 
Nicolas Sebrecht
