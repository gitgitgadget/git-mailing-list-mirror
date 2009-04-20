From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 4/5] bisect--helper: add "--next-exit" to output bisect
 results
Date: Mon, 20 Apr 2009 00:25:07 -0700
Message-ID: <49EC2353.7080206@gmail.com>
References: <20090419115607.c7089503.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 09:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvntx-0004t5-Mz
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 09:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZDTHZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 03:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbZDTHZP
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 03:25:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:4705 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbZDTHZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 03:25:13 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1008966wah.21
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Vq7gAu8W5wahVndeJPmS4WXQpW46WlprS9iO/XHG5yg=;
        b=wKymNs+hcDI84ONGr8xOYr/dqHbD14pUcGAlBCBOELylq4kNTx0vVjjtFh+6CCiF49
         H8qneJQy9ZSa/ggBVdOkHz0Jv7cqjvgumysd51YX9zX9wbbwmunRzXGt/oO/eutzUcAB
         E/LTqFmxWlm7QA9wUU0Q6FAOFhL/hAq59sROQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=X0ffsYVGUNQ3c0LQ8Q6SMQnwHb4xEgktGAf89IkEkANiL2En00V6gU1xQrCyPXonDc
         JwgllTK8MYNVQjSUogmElVpZrfVnpP+8Wou1sxs+P6xuKwkvk7chHOEe5JTEA/Iep4bT
         77ATgfgzFLEluKC3JZeZcUk7K2fhhps8yEiKA=
Received: by 10.114.137.2 with SMTP id k2mr3153009wad.146.1240212312270;
        Mon, 20 Apr 2009 00:25:12 -0700 (PDT)
Received: from ?192.168.1.3? ([76.89.212.195])
        by mx.google.com with ESMTPS id k14sm7045185waf.58.2009.04.20.00.25.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 00:25:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090321)
In-Reply-To: <20090419115607.c7089503.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116939>

Christian Couder wrote:
> +	printf("There are only 'skip'ped commit left to test.\n"
> +	       "The first bad commit could be any of:\n")

Should this be "There are only 'skip'ped commits left to test"?
