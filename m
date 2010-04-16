From: David Aguilar <davvid@gmail.com>
Subject: Re: Feature or a bug: git aliases are executed in git-root
	directory
Date: Fri, 16 Apr 2010 01:34:21 -0700
Message-ID: <20100416083419.GA30372@gmail.com>
References: <4BC5A483.6060206@plusserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jens Otten <j.otten@plusserver.de>
X-From: git-owner@vger.kernel.org Fri Apr 16 10:34:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2h0W-00028s-S6
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 10:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0DPIec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 04:34:32 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:55187 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab0DPIea (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 04:34:30 -0400
Received: by yxe37 with SMTP id 37so1332110yxe.21
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eXsK8a37A7tdmfmsC6gpuAV3w+poIP33Rn0FZowpCyQ=;
        b=mzLR/lDmkYpdXrOmTQU/DRw6TQNuaRg0lmlDkkSAQBg7lEkdIB5cmnbZf89WJlXa1O
         EpBhCeg5HPrhEU2uRwFoK25Y9y3zgSxBYOUT5Cq91dsEfiqFbwovfOc/Io4dmaSgJkC9
         fmUhGpTgcbdcrJcc8iZqj8frAhitXK2Vn4tjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vxqojQT60VQVCuu5oAZ2aYP7Xu7Cqq8PDMyuokAKH7Z7MwhusZdzbwEjkKKb15eeTF
         b1tdaSmODVQ0uJ/MCoK+ECrQkpARkf9/WdI4EE8Xh8ouwfAoJaQMLmmyM0CJRa+950Cf
         PDrEGRF4G/IMiqFdV4DR749v8kjOy0IK0Fteg=
Received: by 10.91.152.5 with SMTP id e5mr807330ago.78.1271406868346;
        Fri, 16 Apr 2010 01:34:28 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm710102ywf.55.2010.04.16.01.34.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Apr 2010 01:34:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BC5A483.6060206@plusserver.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145058>

On Wed, Apr 14, 2010 at 01:18:27PM +0200, Jens Otten wrote:
> Hi,
>
> i started to use git (version is 1.6.3.3 (ubuntu)) and it is really great!
>
> but i have one problem when using aliases. maybe i made a mistake, but  
> here is my problem.
>
> i set up my ~/.gitconfig as follows:
> ----------
> ...
> [alias]
>    meld = !GIT_EXTERNAL_DIFF='git-diff-to-meld-redirect' git diff
> ...
> ----------
>
> now when i work in a subdirectory of my git-root dir and want to make a  
> diff, this works perfectly:
> $ cd ~/git-root/subdir
> $ git diff some_file
>
> but when doing the same using the alias i get an error:
> $ cd ~/git-root/subdir
> $ git meld some_file
> fatal: ambiguous argument 'some_file': unknown revision or path not in  
> the working tree.
> Use '--' to separate paths from revisions
>
> whereas using the relative path starting from the git-root directory works
> $ cd ~/git-root/subdir
> $ git meld subdir/some_file
>
> is there a way to solve this problem?

Yes.  Use git-difftool =)

http://www.kernel.org/pub/software/scm/git/docs/git-difftool.html

git difftool -t meld -- <path>



> thanks for your help
> jens

HTH,

-- 
		David
