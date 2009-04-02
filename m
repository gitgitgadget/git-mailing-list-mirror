From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] mailmap: resurrect lower-casing of email addresses
Date: Thu, 02 Apr 2009 18:58:02 -0400
Message-ID: <49D542FA.3070304@gmail.com>
References: <cover.1238458535u.git.johannes.schindelin@gmx.de> <f182fb1700e8dea15459fd02ced2a6e5797bec99.1238458535u.git.johannes.schindelin@gmx.de> <49D53ABF.80706@gmail.com> <alpine.DEB.1.00.0904030039290.10279@pacific.mpi-cbg.de> <7v63hmekyv.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 00:59:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpVsq-0003R1-Uj
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 00:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbZDBW6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 18:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbZDBW6J
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 18:58:09 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:3747 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbZDBW6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 18:58:07 -0400
Received: by yx-out-2324.google.com with SMTP id 31so733403yxl.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YDNTBACLbm7d38eZW8rYduYvZrd6xgLbOkPeSXfFOEs=;
        b=se3s1kL7UL3D5W1VpJBcrYYhTQVxz5ANEVKEAMCOUvz0/yl2zJgb3NIndA1r8Cefzq
         QD6svRNlIYf9XghY2jnQu6CKJ2XS1WjbWlTYh4KQZ5tHNtFIgQNW741wq3NWhPYfo/L6
         J0QdqhIQ43GmlWUs+xfsSpXcQLFbdXClZrGXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=TstxiQxPXh0DRYOJQjEIgtt2BzZumbVxk+BmMzpkwud6fmSV9QF6jp8YIKbaZOPk36
         uNEM2AKBDXvY4o+wFMXwIvORz+G66Fu8EsMMMvSLh01z7Xqhb0U069Gc1MDX3EcDFx4B
         UYh+HcmzLPFy9zPxwf/THZHSEj/QeufWtbTqU=
Received: by 10.90.93.17 with SMTP id q17mr298078agb.60.1238713085111;
        Thu, 02 Apr 2009 15:58:05 -0700 (PDT)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id 4sm2328498agc.52.2009.04.02.15.58.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 15:58:04 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7v63hmekyv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115503>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> What part of the email address is this going to lowercase? Only the domain
>>> name is case agnostic.
> 
> That is my understanding of RFC, too.  Let's see where this mail goes to
> find out how much more lenient the real world is ;-).
> 
> 

Many email providers/servers are lenient when it comes to case in the 
local part of an email address (after all, they control the 
interpretation) but not every provider/server is and the RFC is VERY 
clear on this issue.
