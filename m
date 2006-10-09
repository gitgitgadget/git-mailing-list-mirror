From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Cleanup Git logo and Git logo target generation
Date: Mon, 9 Oct 2006 11:26:16 +0200
Message-ID: <200610091126.17055.jnareb@gmail.com>
References: <20060919212725.GA13132@pasky.or.cz> <200610090914.59834.jnareb@gmail.com> <7vvemtdfst.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 09 11:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWrO5-00030M-UI
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 11:25:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWJIJZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 05:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWJIJZV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 05:25:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:40184 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750710AbWJIJZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 05:25:21 -0400
Received: by ug-out-1314.google.com with SMTP id o38so548435ugd
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 02:25:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YvHs5XabuecKqlzAhci/qL7Zaht4809N3FilVb6upSRqrVoBu7YFfnkI0xFP6R7x9PbAP6cf3S7Yl/XwOnLzeTv2P9xg8n09cNl/W5NoO+n55mHnxfCJhtVoOlXwVQgRHwkwMNyc2Abj4wALJnNGMOzLakiDCbfsKTwMhJvTObk=
Received: by 10.67.117.18 with SMTP id u18mr6445241ugm;
        Mon, 09 Oct 2006 02:25:19 -0700 (PDT)
Received: from host-81-190-27-91.torun.mm.pl ( [81.190.27.91])
        by mx.google.com with ESMTP id 24sm1189905ugf.2006.10.09.02.25.18;
        Mon, 09 Oct 2006 02:25:19 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vvemtdfst.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28566>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Partial improvement is better than no improvement.
> 
> Not necessarily.  As the maintainer, I found that when we say
> "we will fix it later", later tend to never come, and one
> effective way to fight that tendency is to prod the contributors
> a bit harder, which worked reasonably well so far.

Well. Perhaps.

But first, it is also bugfix for esc_html on URL, and second I though 
you rather have one feature per patch; this one has two - cleanup of 
logo generation, and moving style to CSS. "Better" patch would have 
three...

-- 
Jakub Narebski
Poland
