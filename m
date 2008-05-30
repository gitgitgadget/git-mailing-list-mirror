From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sat, 31 May 2008 01:03:03 +0200
Message-ID: <484087A7.2030107@gmail.com>
References: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 01:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2DdT-0005sZ-ME
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 01:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbYE3XCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 19:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754886AbYE3XCt
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 19:02:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:46305 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbYE3XCp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 19:02:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so210146fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=K566indzbLmHBWhCnueG0pPCcobhQEg5Eb1WGZ6LjgU=;
        b=mcOWmJJeCyxuL99SqXLem1O2Zz++Nz6Yw6X+JpbcbN6m3i1FI8+Dbi6f2k3edXm2W5SHo9pdq+K3rqzN1V0MIhyahlPQ4dHHVM9ALxsjFEQm/B8Xte81nAOIjQUyVuFOPDOTajOf8UQfR9ifZT5wVi0uwsxxwB47CL2qIWIJdd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=qI6j1vhgj890RZ69idqou4QQiayw7B6igZn53jo/IsKrzsHAuztDkTnRJzyyoDW9h1epCHk5dI8+ZUQqDDKuHFTz3ThEG31PCuxZNStDo1HcJjYd+LxqRFh6+p1ED/6CQgOXE3GagGXi5ZCP6G1wmA0TI9VphUJgUCNtb9X3Xww=
Received: by 10.86.100.19 with SMTP id x19mr1586412fgb.34.1212188564190;
        Fri, 30 May 2008 16:02:44 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id c28sm2774448fka.4.2008.05.30.16.02.43
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 16:02:43 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212188412-20479-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83354>

Lea Wiemann wrote:
> Subject: [PATCH] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash

For clarification, this is my first patch for refactoring Gitweb to use 
Git.pm's API.

In the end, I'm hoping that all (or at least most) of Gitweb's accesses 
to the repositories will go through this API, which allows us to add 
caching to the Git.pm API (rather than Gitweb) pretty easily and cleanly.

-- Lea
