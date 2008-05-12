From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 22:13:27 +0800
Message-ID: <48285087.3090402@gmail.com>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 16:14:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvYnJ-0002Ey-So
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 16:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbYELONg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 10:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYELONg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 10:13:36 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:2260 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbYELONf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 10:13:35 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2681434rvb.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=lugC24e+vnvmO3eb5VF/y9zdx9MaOTv7AxJAXf6El+Y=;
        b=omYLmfLCxMzoXGjHfYUUWTALnAUdwhio6GOoTC2TDO6jhvK/LKQ1NkmSBHFBnIYp9gG+BLLJiOJxyMOf+alZijjdmgiNTLU1mr/3iS/ADfVglhHxWZgZRXECn8W0Lp64K/dnPy7OX66oK18sKzZJEZyJ6GNbYdro3ZPtF3efyPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bHksGnDvU8yFpStfz+46HkoR0DUw+IJTsNVlHojydjfZxbgKudxwfGFD24iuKjjZhksa+jVzERyga6RNFDku3hvX5Q2wk9TRjMUDCOE6TCImu4ASp706FCFIwZX5afPhOzno86OvcLBXjAF0mfKyyIpuvINjpqutISFbRcOj/FM=
Received: by 10.140.82.40 with SMTP id f40mr3711661rvb.0.1210601613311;
        Mon, 12 May 2008 07:13:33 -0700 (PDT)
Received: from ?192.168.1.201? ( [219.77.1.137])
        by mx.google.com with ESMTPS id f42sm10148852rvb.5.2008.05.12.07.13.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 07:13:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0805121428310.30431@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81865>

Johannes Schindelin wrote:
 >> I'd rsync just the .git directory.

Thanks to all responders for quick reply. I still have a related question. svn 
has a hotcopy command to ensure integrity so that it is possible to backup 
without shutting down the svn server. If someone update the .git while I am 
performing backup using tar or rsync? Will the atomicity of that commit still 
preserve in my backup copy?

regards,
