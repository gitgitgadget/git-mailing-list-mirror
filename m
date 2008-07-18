From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git submodules and commit
Date: Sat, 19 Jul 2008 00:11:54 +0800
Message-ID: <46dff0320807180911h63999019q5dd56e9341d0fbb6@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <32541b130807160843k25f1d7d3u8bfecd6c1c6eab91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJsZm-0005Y2-9M
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbYGRQL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 12:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYGRQL6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 12:11:58 -0400
Received: from ti-out-0910.google.com ([209.85.142.189]:12310 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYGRQL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 12:11:57 -0400
Received: by ti-out-0910.google.com with SMTP id b6so340558tic.23
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KvQlQVEaXg/H5tLeCffbJ3Ko4sbX15F/t1TTldB+Ug0=;
        b=rZmIhoIASRGDxy/AbAJiUESYcQnH8LWH+uUasXnk/IGwxECZFYbhOsFBpqTBIBNj7Y
         uH1cemNFGupS2kCwWeFJO6SUPg3ycUVRmf4zuK02Rez2M5tsdDbCw7/Ptwp4G2z3DzwN
         NA48EirtE0pGJEwjvv8XFNHU1uLmvSIAG8/3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lAHWl8fwLVdt1zv2uUcLSaslwYPHUupfcwTpjeuSmV80c9GSmk2J4yGTLRjKEZgEPD
         4uUShdg2qd6kPKpGmJzO5/5xihOXIpjH6XR/cnjw6r+sfczIDx2tO1Pxll/KelnbhX+w
         U5IPhHKZgbnZuKk79VemuXjRL9UNvi+dUlrtc=
Received: by 10.151.144.15 with SMTP id w15mr366969ybn.200.1216397514847;
        Fri, 18 Jul 2008 09:11:54 -0700 (PDT)
Received: by 10.151.114.1 with HTTP; Fri, 18 Jul 2008 09:11:54 -0700 (PDT)
In-Reply-To: <32541b130807160843k25f1d7d3u8bfecd6c1c6eab91@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89050>

On Wed, Jul 16, 2008 at 11:43 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On 7/16/08, Nigel Magnay <nigel.magnay@gmail.com> wrote:

> If you want to work with me on my new submodule workflow (and I'd
> certainly appreciate it!) then I'd suggest one or more of the
> following starting points:
>
> - Take the recursive push, pull, and update operations described
> above, make them general (ie. not referring to my submodules by name
> :)), and add them as commands in the real git-submodule script.  The
> trickiest part here will be figuring out which remote branch to
> push/pull.

See http://article.gmane.org/gmane.comp.version-control.git/69834
([PATCH] Added recurse command to git submodule)
Or search "submodule recursive" in gmane.

The recursive pull,diff,status for submodule is implemented by Imran M
Yousuf. And IIRC, with this patch, you can walk through the submodule
hierarchy to exectute any command.




-- 
Ping Yin
