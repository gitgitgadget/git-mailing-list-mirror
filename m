From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git clone --bare doesn't create refs/heads/*?
Date: Thu, 29 Jan 2009 22:36:26 +0800
Message-ID: <be6fef0d0901290636m5b472499mdf614841a06ec978@mail.gmail.com>
References: <be6fef0d0901290606q25ad7c82ob250a5f89d4db0cf@mail.gmail.com>
	 <20090129142657.GG21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:38:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSY1i-0007cV-VQ
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbZA2Oga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbZA2Og3
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:36:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:62229 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZA2Og2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:36:28 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1319213wah.21
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 06:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KSotFqN/Xun739FomnwyAVjGttyGsdD7sLtmwOOkg3o=;
        b=YuDRMB1J9Yy8xoXebnhrKIwCYUKwcsT9md4QXStEUmfBqFaPziWmyiu410b+wjqJ+c
         0JwGoSUSZviltLv7KhKztgFBWgFlQOFISJFJ8/os6U8+VUYh2ZHvRkvVjLWQYaHXgQ+z
         RM6waYefqJl3e4wJ42GuxERXZAw18LfTrdpWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jd9epkLyhaupJBZHt1UYZVk6rl0DrQF3To32/dwXNgnBEshc1E/1a1ZLUxDa2F2VcN
         J3jrjmQjnt71Fmbxovo3ZPdaBHfRsuMkgSQouGB0vtIZnqG3yHVqYHpAfKgXx2pvoXM/
         1xJ03+JJ5gYJUzZGheFLSxI+81TPOOTT43ZR0=
Received: by 10.114.26.11 with SMTP id 11mr84383waz.38.1233239786955; Thu, 29 
	Jan 2009 06:36:26 -0800 (PST)
In-Reply-To: <20090129142657.GG21473@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107686>

Hmm, no, --mirror adds extra remote tracking information.

Quoting the git-clone man page:

"...the branch heads at the remote are copied directly..."

which is to say, git clone --bare isn't doing what it's supposed to do.

that said, i'm not too sure about this, hence this thread.

On Thu, Jan 29, 2009 at 10:26 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Thu, Jan 29, 2009 at 10:06:39PM +0800, Tay Ray Chuan <rctay89@gmail.com> wrote:
>> afaik, a bare repository is just a copy of the .git folder of the
>> cloned repository. why isn't any of its branches copied too?
>
> Maybe you're searching for git clone --mirror and not git clone --bare?
>



-- 
Cheers,
Ray Chuan
