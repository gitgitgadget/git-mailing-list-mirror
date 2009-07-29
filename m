From: Saikiran Madugula <hummerbliss@gmail.com>
Subject: Re: [PATCH] Documentation: Fix build failure of docs.
Date: Wed, 29 Jul 2009 10:09:49 +0100
Message-ID: <4A7011DD.5020709@gmail.com>
References: <4A6F29C5.6030608@gmail.com> <4A6F3D57.2010602@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5B1-0002xL-VQ
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbZG2JJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbZG2JJx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:09:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:1079 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbZG2JJw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 05:09:52 -0400
Received: by ey-out-2122.google.com with SMTP id 9so162055eyd.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=aGOysynIcO/IDCDxnUL7/jTReemg04//m4pQVnj2ZC0=;
        b=hu7TJQdQ8jTsx8pT7vslQzDx9iNzqZcs6kfiGwCBc2acenkjLfJfTNl5mX9L0NAiam
         x0yTfjFCiFJJ4dKp2ryyePbZUjIU3nR7hDA2LzPGlDBrxIgssFH4+Fi2EM751p8/cZfQ
         o1cfm4prXGV+iJC810XZqZPMz2Suog68rmfFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JSjk1beHqKZl8uFnP+xLbsbKfIaj27LCWRSVZcR+EeFmOTNOlFd3st/L175Q3U0Fk9
         cgcvQiYNiqC/7NjmMiV6LhE+id6G3+4mZnqny3YUxjechUbFvdDeHjjorBJ64lPW1f3T
         JXsSvducy3HLluHEYFKqKHzB3SI/4GxMI7SyU=
Received: by 10.211.178.8 with SMTP id f8mr8048485ebp.91.1248858591635;
        Wed, 29 Jul 2009 02:09:51 -0700 (PDT)
Received: from ?10.0.11.140? ([85.118.31.194])
        by mx.google.com with ESMTPS id 7sm2140622eyb.22.2009.07.29.02.09.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 02:09:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <4A6F3D57.2010602@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124333>

Michael J Gruber wrote:
> Saikiran Madugula venit, vidit, dixit 28.07.2009 18:39:
>>>
>> People would start using latest versions of ascii doc which has no problems,
>> wouldn't it be better if the default compile options suit them ? Also, it would
>> be good if "make install man", would do "quick-install-man" as default to
>> prevent users from the painful compilation of manpages everytime they try to
>> install latest git.
> 
> "make install" does not build any documentation at all, so that should
> be no source of pain.
> 
> The user decides which we to go: install-man or quick-install-man.
> 
> Having the defaults set up so that recent "mainstream" versions of the
> tool chain work without extra options may sound like a good idea - but
> that would mean changing options again and again. I think we should do
> this for major milestones (say git 1.7).
> 
> Michael
Sure.
