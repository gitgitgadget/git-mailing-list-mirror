From: Ted Pavlic <ted@tedpavlic.com>
Subject: Vim's gitconfig filetype (and folding)
Date: Wed, 28 Jan 2009 11:56:54 -0500
Message-ID: <49808E56.3090300@tedpavlic.com>
Reply-To: vim_use@googlegroups.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080807070007050500090604"
To: git <git@vger.kernel.org>, vim_use <vim_use@googlegroups.com>
X-From: grbounce-kKpDswUAAAD87BKvZoWWIqgvt2_Vg0cp=gev-vim-moved1=m.gmane.org@googlegroups.com Wed Jan 28 17:58:35 2009
Return-path: <grbounce-kKpDswUAAAD87BKvZoWWIqgvt2_Vg0cp=gev-vim-moved1=m.gmane.org@googlegroups.com>
Envelope-to: gev-vim-moved1@m.gmane.org
Received: from yx-out-2122.google.com ([74.125.44.26])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSDkB-0006Sn-Hm
	for gev-vim-moved1@m.gmane.org; Wed, 28 Jan 2009 17:58:27 +0100
Received: by yx-out-2122.google.com with SMTP id 22so2095342yxm.63
        for <gev-vim-moved1@m.gmane.org>; Wed, 28 Jan 2009 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :x-virus-scanned:received:received:message-id:date:from:user-agent
         :mime-version:content-type:to:subject:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=gwninZCaraDIa04QCye2gjeJg+Y+NmcSFvxrDip3u/g=;
        b=TgoOrmUNiQGyBaJ/C8QczFY9BP3ft8JSVc3SP92GuVVD6LomLYcvKcxUq99UNWrRIj
         1Y/JUY2oo/5uCRsueeQgPjy0bKzHmXYk4q+/CgggsLZXz4zJUtTDFj0W40GFe98u9me7
         d2hfr59N6a8m2U6ff3NJJ5ZRK8i4MwVtgCtCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-virus-scanned:message-id:date:from:user-agent:mime-version
         :content-type:to:subject:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=UpDoSDuVQXwlPqqeun5/TdWcuHFhncEmP9c8xw76icKwGUDjN5xgeQucmCz4Bg88BK
         5YUU/UPPw95xy+cD/WZsgJTS2pkdJTZayH51K3icgib3WvVU9BZQuqtjUZFZmMlyZ2IQ
         jOYmGtO3L5QnD3Ym2tflyunu0XfdwrFcZt4sQ=
Received: by 10.100.136.15 with SMTP id j15mr2762610and.16.1233161823997;
        Wed, 28 Jan 2009 08:57:03 -0800 (PST)
Received: by 10.177.127.42 with SMTP id e42gr20261yqn.0;
	Wed, 28 Jan 2009 08:57:01 -0800 (PST)
X-Sender: ted@tedpavlic.com
X-Apparently-To: vim_use@googlegroups.com
Received: by 10.90.96.1 with SMTP id t1mr3488149agb.15.1233161820911; Wed, 28 Jan 2009 08:57:00 -0800 (PST)
Received: from gallifrey.ece.ohio-state.edu (gallifrey.ece.ohio-state.edu [164.107.167.66]) by mx.google.com with ESMTP id 22si2702754yxr.10.2009.01.28.08.57.00; Wed, 28 Jan 2009 08:57:00 -0800 (PST)
Received-SPF: neutral (google.com: 164.107.167.66 is neither permitted nor denied by best guess record for domain of ted@tedpavlic.com) client-ip=164.107.167.66;
Authentication-Results: mx.google.com; spf=neutral (google.com: 164.107.167.66 is neither permitted nor denied by best guess record for domain of ted@tedpavlic.com) smtp.mail=ted@tedpavlic.com
Received: from localhost (localhost.localdomain [127.0.0.1]) by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 662C180D804B; Wed, 28 Jan 2009 11:50:52 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1]) by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id snQV6Th3vylu; Wed, 28 Jan 2009 11:50:52 -0500 (EST)
Received: from TedBook.local (cpe-76-181-62-78.columbus.res.rr.com [76.181.62.78]) by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 23DF780D8017; Wed, 28 Jan 2009 11:50:52 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: vim_use@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list vim_use@googlegroups.com;
	contact vim_use+owner@googlegroups.com
List-Id: <vim_use.googlegroups.com>
List-Post: <mailto:vim_use@googlegroups.com>
List-Help: <mailto:vim_use+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/vim_use/subscribe>,
	<mailto:vim_use+unsubscribe@googlegroups.com>
X-BeenThere-Env: vim_use@googlegroups.com
X-BeenThere: vim_use@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107551>


--------------080807070007050500090604
Content-Type: text/plain; charset=ISO-8859-1

I don't know who is responsible for maintaining the git-related files 
distributed with Vim, but it would be nice if folding was enable for the 
gitconfig filetype.

I've attached a sample set of folding rules that works well for me... 
Right now I have the attached file in ~/.vim/ftplugin/gitconfig.vim.

I'll paste those rules here (but beware of word wrap):

:set 
foldexpr=getline(v:lnum)=~'^[;#]\\s*\\(ex\\\|vi\\\|vim\\):'?\">1\":((getline(v:lnum)=~\"^#\\\\=[\")?\">1\":\"1\")
:set fdm=expr

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.

--~--~---------~--~----~------------~-------~--~----~
You received this message from the "vim_use" maillist.
For more information, visit http://www.vim.org/maillist.php
-~----------~----~----~----~------~----~------~--~---


--------------080807070007050500090604
Content-Type: text/plain
Content-Disposition: inline;
	filename="gitconfig.vim"

:set foldexpr=getline(v:lnum)=~'^[;#]\\s*\\(ex\\\|vi\\\|vim\\):'?\">1\":((getline(v:lnum)=~\"^#\\\\=[\")?\">1\":\"1\")
:set fdm=expr

--------------080807070007050500090604--
