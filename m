From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2010, #06; Wed, 24)
Date: Thu, 25 Mar 2010 16:11:15 +0100
Message-ID: <fcaeb9bf1003250811g777b2881l332e6f61456d699@mail.gmail.com>
References: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 16:12:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuoil-0008GK-QH
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 16:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0CYPLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 11:11:38 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:50963 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0CYPLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 11:11:37 -0400
Received: by qyk26 with SMTP id 26so5596183qyk.19
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+33+m/x4XzK1dwEHQoFyTMpwU6JXOxDISKMoFSu9rSI=;
        b=EOtTBInT4XpLvU4MI4eBCsW8TOcvdhFyV06brpekYASrSe3fsr/cCDBRlxI50SYXnx
         6IvDNxDd1SIDoszCDKDwk6u8rW9U6a2RzU7IqXD+/ILgSrg5T6D9QpCV+1b4sXZ2hVYh
         xu7SEXzSElnGhcFef6RF2LpfNmXLpyTFa7XIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=AaQamTu/Zn3waa92YqG8mEL0d5O8bShF5UIM8K2f4aK916365+wGY/HvCnk9MnKKkY
         3Gk1hxGZrZA/zzdtEmogXhpKHLOjVraDtwAqQhDso8WDukr3e2+smoeekV6tNbJ5UzBx
         dja0XbaKumAYOMKb51Me/nU+PtqCHijaohlm8=
Received: by 10.229.191.138 with SMTP id dm10mr586381qcb.52.1269529896141; 
	Thu, 25 Mar 2010 08:11:36 -0700 (PDT)
In-Reply-To: <7v7hp1kzbn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143182>

2010/3/25 Junio C Hamano <gitster@pobox.com>:
> * ar/config-from-command-line (2010-03-19) 1 commit
>  - Allow passing of configuration parameters in the command line
>
> * bc/t5505-fix (2010-03-19) 3 commits
>  - t/t5505-remote.sh: escape * to prevent interpretation by shell as glob
>  - t5505: add missing &&
>  - t5505: remove unnecessary subshell invocations

This breaks my build on Solaris because it uses strndup, which is not available.
-- 
Duy
