From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v5 1/3] git-svn: Support retrieving passwords with 
	GIT_ASKPASS
Date: Mon, 8 Mar 2010 21:07:56 +0800
Message-ID: <1976ea661003080507o5255ca4fqd093ee9fd3240ff4@mail.gmail.com>
References: <1267713074-4316-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: davvid@gmail.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 14:08:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nocgl-0000S7-9H
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 14:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab0CHNH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 08:07:59 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64612 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab0CHNH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 08:07:57 -0500
Received: by gyh3 with SMTP id 3so829622gyh.19
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 05:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=N+X2niXzMJZXsG6kyxyeLWJnxY8z0Sc43AUDzFWAGYA=;
        b=jQD5ZmcBUSngB0UVkP+G2OoBxEs0GdHz8RBAFlcSFmnVNKAQDnDSskP+kfK5o3iV4b
         QrXE5A0oEYgxAnY5HyzdTG09+OVGJ0o053BHW8zGe8tWyvyOxsSZRraqUhxCQwva6glN
         DlhPFaolmadkh4Bh70aDLy7zuDt6uC9WVSzRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Dvc+7yu++ee2lE7U7YUOERfGI2Yf/lUK9dNMQsLLCUtdSjWbS6AAAzzfNmhT+DEjcf
         r86R7dby30tiDNMygub5TneXSSQiK22gqSYNAP1hOgMek8t0OWNe2j8B+9crTfQTyKUg
         hwdsvrKX6SOfssXLiZPbcPUjVd9dRCuhf8oAI=
Received: by 10.151.29.7 with SMTP id g7mr4164462ybj.246.1268053676509; Mon, 
	08 Mar 2010 05:07:56 -0800 (PST)
In-Reply-To: <1267713074-4316-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141766>

2010/3/4 Frank Li <lznuaa@gmail.com>:
> git-svn reads passwords from an interactive terminal.
> This behavior cause GUIs to hang waiting for git-svn to
> complete
>
> Fix this problem by allowing a password-retrieving command
> to be specified in GIT_ASKPASS. SSH_ASKPASS is supported
> as a fallback when GIT_ASKPASS is not provided.
>
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---

How about this patch? How about this patch? is it accepted?
