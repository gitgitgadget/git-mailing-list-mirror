From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 14:09:11 +0800
Message-ID: <4959BB07.6000106@gmail.com>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 07:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHXoN-00064Y-EL
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 07:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbYL3GJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 01:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbYL3GJR
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 01:09:17 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:43984 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYL3GJR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 01:09:17 -0500
Received: by ti-out-0910.google.com with SMTP id b6so7951070tic.23
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 22:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=R0Km+dACQP+ooWRcfubSpI6Inta194nMB4hH8OmZwhg=;
        b=UzRyQka6TNXHspZIRdsHz3Vmd8pBiQJ7zFsqwC/x5TjIujkKmjtZYCGyf8hrr/FNoN
         Ei1j5sy4j4bLeP1N3bX/NkRMRK/mZKdddxJIb7VI+jiy1RbQlZWuf+3D7SGqbQnB/COz
         pGB4Cl2ls0f2ff2hqnr3E8rwcMbuKJ3MXJ8aA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=t532dAPtSYOtk8lu2uBThxBsAD3904nJloR7luamM1TL4Fc/4vNF5U2D34tP7DebeD
         mYnEch4MgzDnT1kAPafJ0JSt/+P9x7Pit8TtNmxtQJsEZ6K3jrH9UGzSslHBJXxKUakh
         RL79POZzRoI8HajtZsVHFgLudS2begU/9YqZs=
Received: by 10.110.105.5 with SMTP id d5mr143449tic.11.1230617355558;
        Mon, 29 Dec 2008 22:09:15 -0800 (PST)
Received: from ?10.64.1.142? ([211.157.41.194])
        by mx.google.com with ESMTPS id a4sm18773829tib.7.2008.12.29.22.09.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Dec 2008 22:09:14 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104163>

Ping Yin wrote:
> Yes, i know this topic has been discussed for many times. However, i
> am still not clear about the real reason.
> 
> So which is the reason?
> 
> 1. it's by design, intentional
It's saied somewhere git is a "stupid content tracker", it cares file content
not file name, and empty directories will complicate the merge algorithm
unnecessarily.

> 2. unclear logic, for example, whether to remove the directory after
> the last file in it is deleted
> 3. hard work, no one has picked it yet
> 4. hardly done in current model
> 
> Ping Yin
