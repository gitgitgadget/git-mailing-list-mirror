From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 13/13] some document update
Date: Sun, 11 Jul 2010 01:27:04 -0700 (PDT)
Message-ID: <m3hbk6l901.fsf@localhost.localdomain>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<1278829141-11900-13-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 10:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXrsc-0004DF-SW
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 10:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0GKI1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 04:27:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60076 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab0GKI1H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 04:27:07 -0400
Received: by bwz1 with SMTP id 1so1847891bwz.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3iCcFTvOBIL4inOYlUbSQikxK0f+7RfPzdUb7LIbZ+g=;
        b=a4hnduQNlgRMDloSofYDY6zWBCb8Jugx3c1rqgUMsJk2SLribU7kXj/1caIT/4HkVw
         IV6KyMJ7iIV7BZrBEpu8gb8dQBOQyyBVZxNCAs7EOQTI3avJDCzl1WVwYXAbx6rfBPf9
         E3KBtRE39x8PiCrkZl24Pr+clogLFo9eeq0o4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WvZ3iXuF4nDzWWpSKEiCk+pRJGXwZtZZhyJ4nYxv5ggr907PO6Y1ZdaauKcPACLeAF
         ELKd75WpW0DCC+HO7LvaRbbGganm54NrgndcSwYn+07ZSzr6nwbV9AtoAHafjPHDu5pl
         AwuvZpXmX7s+oxRNfSghgJAs7jdipUstU4HYk=
Received: by 10.204.6.24 with SMTP id 24mr9396553bkx.181.1278836825551;
        Sun, 11 Jul 2010 01:27:05 -0700 (PDT)
Received: from localhost.localdomain (abwj181.neoplus.adsl.tpnet.pl [83.8.233.181])
        by mx.google.com with ESMTPS id a11sm9223776bkc.0.2010.07.11.01.27.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 01:27:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6B8Qfb5016919;
	Sun, 11 Jul 2010 10:26:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6B8QM0N016912;
	Sun, 11 Jul 2010 10:26:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1278829141-11900-13-git-send-email-struggleyb.nku@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150767>

Bo Yang <struggleyb.nku@gmail.com> writes:

>  Documentation/git-log.txt |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)

[...]
> +-L <start>,<end>::
> +	The line range.  <start> and <end> can take one of these forms:
> +
> +- number
> ++
> +If <start> or <end> is a number, it specifies an
> +absolute line number (lines count from 1).
> ++
> +
> +- /regex/
> ++
> +This form will use the first line matching the given
> +POSIX regex.  If <end> is a regex, it will search
> +starting at the line given by <start>.
> ++
> +
> +- +offset or -offset
> ++
> +This is only valid for <end> and will specify a number
> +of lines before or after the line given by <start>.
> ++

If the parsing code for -L <start>,<end> is the same for git-blame and
for git-log, and therefore documentation is the same or nearly the
same for this option, wouldn't it be better to separate this
documentation into separate file, e.g. line-range-option.txt, and
include it both in git-blame and git-log manpages?  If there are minor
differences, they can be covered by ifdefs.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
