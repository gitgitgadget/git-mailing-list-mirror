From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Wed, 27 May 2009 00:02:22 -0700
Message-ID: <20090527070221.GC2986@gmail.com>
References: <1243394364-13772-1-git-send-email-davvid@gmail.com> <1243394364-13772-2-git-send-email-davvid@gmail.com> <4A1CDF11.4080507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	markus.heidelberg@web.de, nick@incise.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 27 09:02:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9D9s-0007s5-HR
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 09:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760670AbZE0HC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 03:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760085AbZE0HC2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 03:02:28 -0400
Received: from mail-px0-f123.google.com ([209.85.216.123]:42063 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758946AbZE0HC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 03:02:28 -0400
Received: by pxi29 with SMTP id 29so232113pxi.33
        for <git@vger.kernel.org>; Wed, 27 May 2009 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tY7lTghBrNjJmgVb1gMXeJPvKf1km0aA9ZoDaWelXmI=;
        b=lbz28nSi8sZ0flaKnfYRnBKgM752PdAVBDEXsTJZN5LXr6HwTn1wr5wU6ZlNoZ9+La
         S1OreM0Fm9N6f6tr85eCqm0IdT3YpV9a8DAJm65b9PFR8KbojXDXH6xjvJFXf5QimAUG
         V4pmwMMvYX9+yRzW87diFrLi7vak0NvtjQh/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oOGP/qY86KJNZhLTjPUW0wKEfo5tY8Oe3nx+vx7nkWLfGQ2dxYTISVmaTI6kGW/1Z1
         IHnXmNPXq/0hcFjDwoLBi0zcKWWuEghP8WZ11oHOZCd99lRkg+xwcNlaU30aHlwTP9hS
         J5S6j+8D3sFCD0kCLmH1qZ8GVlnwVQqcsL+8c=
Received: by 10.115.18.3 with SMTP id v3mr19475708wai.141.1243407749128;
        Wed, 27 May 2009 00:02:29 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g25sm18648375wag.8.2009.05.27.00.02.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 00:02:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A1CDF11.4080507@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120038>

On Wed, May 27, 2009 at 08:34:57AM +0200, Johannes Sixt wrote:
> David Aguilar schrieb:
> > +#include <libgen.h>
> 
> We don't have libgen.h on Windows :-( (at least not with my aging gcc
> 3.something). Would you please open-code the call to basename()?
> 
> -- Hannes
> 

I don't know much about Windows.
Do we need to check for \ in addition to /?

-- 

	David
