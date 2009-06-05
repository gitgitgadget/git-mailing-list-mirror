From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 18/23] http-push.c::remote_exists(): use the new http API
Date: Fri, 05 Jun 2009 13:54:54 -0700 (PDT)
Message-ID: <m33aae5rn2.fsf@localhost.localdomain>
References: <20090606000557.18c55768.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:55:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgRT-0001zT-Mv
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZFEUzC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZFEUzB
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:55:01 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:42912 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbZFEUzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:55:00 -0400
Received: by fxm9 with SMTP id 9so842844fxm.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GeS0BOK7gZ9JWadrRn295knpe5nMIj6dVRgKqMpx4NA=;
        b=GO7P0xSD4tgRVhQAA4w2zQMtN9rbJGVU9MN4S3+9H0j2xVxQkG1Lhl4tgqzRS2wKvK
         OHhI4Vv3mzzS96xw4TVGlNwJnT+TTBTJ2hDVErqj+4S+tHa5pmnaa2FIsAK/huwI6DH0
         zU/YfJPve9P+92wBPqEaVUQhVc9LTbXrhnjlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=dwCmZjh0VcuOX8p2qXxveltvYGR1NiYiEOUCC9e/ZZhTnhkNO9JMTVfRbcjvkfd5eD
         uHXzfcf1hFvH+uTmT433ncvgDreCZdA7AEtuHfB2iU5xWqtIyJe/Aucv2gqhrBq8sfry
         LWkp7HBust+x2B0BJDXLKKldfsqxfv/rWQiUA=
Received: by 10.204.119.70 with SMTP id y6mr3588511bkq.72.1244235295025;
        Fri, 05 Jun 2009 13:54:55 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 1sm379174fks.41.2009.06.05.13.54.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:54:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55KsDSa024715;
	Fri, 5 Jun 2009 22:54:24 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55KrbjP024704;
	Fri, 5 Jun 2009 22:53:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000557.18c55768.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120836>

Tay Ray Chuan <rctay89@gmail.com> writes:

> From:	Mike Hommey <mh@glandium.org>
> Subject: [WIP Patch 08/12] Use the new http API in update_remote_info_refs()

What is the subject of this patch:
  "http-push.c::remote_exists(): use the new http API"
or
  "Use the new http API in update_remote_info_refs()"?

> Date:	Sun, 18 Jan 2009 09:04:33 +0100
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
