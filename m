From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (May 2009, #02; Sun, 17)
Date: Sun, 17 May 2009 02:45:24 -0700 (PDT)
Message-ID: <m3zldcjc76.fsf@localhost.localdomain>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 11:45:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5cw4-0003RQ-Kz
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 11:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbZEQJp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 05:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZEQJp0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 05:45:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:2992 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZEQJpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2009 05:45:25 -0400
Received: by fg-out-1718.google.com with SMTP id d23so414049fga.17
        for <git@vger.kernel.org>; Sun, 17 May 2009 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UQ2n2jsSwIfFUMIVhx5ZwTULfdhNPC6XB++Nic3+6jQ=;
        b=cSYWUGDs3pdPv6tRFjAPwsW0H4768o72rtGv7JlkP8QEnGTzbDiM9tpNs7mx8IIpDV
         tFP9HMBKkzPYXdMHO3O8141Ym0pUVuXqaXwo8ZkBd/nFqkejuKeWJ/OcwTqf2DpOkePR
         srzk+HR0XsQjNsvuRszM91/c7ZYMZj1iFh/K8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TbwnIEzI5WmhuJh1UHUTUwxVKqIQ5AUPZzTmNVpwEBVIi8em+VZfS8FnZ9UI4qDC3b
         0ZqIPyB/L/G9FFj+LyDnDJM2P8rQPIKZX3uFx/dSioPgf5VWzsOPMGB1sUXoBmdlRRJP
         1RdQgyTPFlv6sMJHh7Vp+E0WYG725251dkUsg=
Received: by 10.86.33.10 with SMTP id g10mr5677129fgg.21.1242553524469;
        Sun, 17 May 2009 02:45:24 -0700 (PDT)
Received: from localhost.localdomain (abwo111.neoplus.adsl.tpnet.pl [83.8.238.111])
        by mx.google.com with ESMTPS id d4sm5594062fga.29.2009.05.17.02.45.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 May 2009 02:45:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4H9ikuV017550;
	Sun, 17 May 2009 11:44:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4H9iU68017546;
	Sun, 17 May 2009 11:44:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vab5ci281.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119388>

Junio C Hamano <gitster@pobox.com> writes:

> * jn/gitweb-cleanup (Mon May 11 19:45:11 2009 +0200) 8 commits
>  + gitweb: Remove unused $hash_base parameter from
>    normalize_link_target
>  + gitweb: Simplify snapshot format detection logic in
>    evaluate_path_info
>  + gitweb: Use capturing parentheses only when you intend to capture
>  + gitweb: Replace wrongly added tabs with spaces
>  + gitweb: Use block form of map/grep in a few cases more
>  + gitweb: Always use three argument form of open
>  + gitweb: Always use three argument form of open
>  + gitweb: Do not use bareword filehandles

Why "gitweb: Always use three argument form of open" is twice here?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
