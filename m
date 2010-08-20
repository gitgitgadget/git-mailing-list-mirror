From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/4] fmt-merge-msg: Update fmt-merge-msg and merge-config documentation
Date: Fri, 20 Aug 2010 10:36:18 -0700 (PDT)
Message-ID: <m31v9tp4pv.fsf@localhost.localdomain>
References: <1282323292-11412-1-git-send-email-artagnon@gmail.com>
	<1282323292-11412-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 19:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmVW1-0007Lv-T6
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 19:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab0HTRgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 13:36:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46080 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0HTRgX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 13:36:23 -0400
Received: by fxm13 with SMTP id 13so1913416fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UI92loo0iuoEF3d09Xd8XIXOFLbYEYrIXjguuo3inb8=;
        b=sTgha0kJSij9y5VyAxXdIC8sVR3A46IZvOB/2IJonnf8keNSQkvKbiJKzFNXm6PPbR
         eoLT70kGERuxCem6rViMUF86G/tWqECzRxcKaP39B86yej3zsEBEgMR/FChBS0lOr4BI
         joDY8MJTzpc4D4PHZE+gFOOjt7FhOibc685Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=UqWbboqeqnvsHPU8ihG3tCBleGEsaDQrLG8/ms+kHm+LUr6iNKh2VMDEtONmlGHg/M
         XbsLdHNFavnRe+dDR7f0LdW1E1AriHx3V2dm0yIwq6EdGrZCXYjsZO52VIa/ztvZZ8C+
         Q9S/8tIOVYg7Q4CPsvaOxZn97mbwAewPaDkfw=
Received: by 10.223.107.82 with SMTP id a18mr1382347fap.86.1282325779981;
        Fri, 20 Aug 2010 10:36:19 -0700 (PDT)
Received: from localhost.localdomain (abwo112.neoplus.adsl.tpnet.pl [83.8.238.112])
        by mx.google.com with ESMTPS id k25sm1270381fac.41.2010.08.20.10.36.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 10:36:18 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7KHZkVf020293;
	Fri, 20 Aug 2010 19:35:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7KHZP21020286;
	Fri, 20 Aug 2010 19:35:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1282323292-11412-5-git-send-email-artagnon@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154059>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Update the documentation of fmt-merge-msg and merge-config to reflect
> the fact that `merge.log` can either be a boolean or integer option
> now, instead of just a boolean.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-fmt-merge-msg.txt |   20 +++++++++-----------
>  Documentation/merge-config.txt      |    8 ++++++--
>  2 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
> index 78c8a6d..720af64 100644
> --- a/Documentation/git-fmt-merge-msg.txt
> +++ b/Documentation/git-fmt-merge-msg.txt
> @@ -9,8 +9,8 @@ git-fmt-merge-msg - Produce a merge commit message
>  SYNOPSIS
>  --------
>  [verse]
> -'git fmt-merge-msg' [-m <message>] [--log | --no-log] <$GIT_DIR/FETCH_HEAD
> -'git fmt-merge-msg' [-m <message>] [--log | --no-log] -F <file>
> +'git fmt-merge-msg' [-m <message>] [--log=<n> | --no-log] < $GIT_DIR/FETCH_HEAD
> +'git fmt-merge-msg' [-m <message>] [--log=<n> | --no-log] -F <file>

Shouldn't it be

  +'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>

i.e. isn't <n> in '--log' optional?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
