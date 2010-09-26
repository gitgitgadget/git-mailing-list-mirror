From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 10/12] gitweb: git_repo_url() routine
Date: Mon, 27 Sep 2010 00:34:28 +0200
Message-ID: <201009270034.29603.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-11-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 00:35:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzzoE-00064o-Dh
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 00:35:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193Ab0IZWes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 18:34:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57850 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758228Ab0IZWer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 18:34:47 -0400
Received: by fxm3 with SMTP id 3so1505810fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1gD7qufKZyrqCy0spawGA8/gV9nFu9QfZ6cZwJsLmJk=;
        b=Otz8g5TegJFPmx7PwMRTy3jm1twCxW/nWx0qlSOgnouYCiO0GxSjahLMirvH6M4BOq
         dDJ8scmgvHpHBEnOjvNQYe/MIilp5UI/gyw7w9a0NCXNETw0HD9mpqArX3Yt977obMqY
         Oc2m129L51sevuRBWMe2yKSKNp55N0L5WSHHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jRrFxp+2pz/PBNRDOBaQIyS0cPPc8EeYR77rzRthEMkR9Q6KAVWARKecRPk7LLMyJY
         B/tnLkZ6uve30pFs319S/9ORq5v+FyVe7NS072VUzmsj86nxpogUBulaFQ3V0Y3a7ebV
         2Vd7GkrgFduCgGBxx7j4MoN5yIDb+4gKVfcxA=
Received: by 10.223.104.11 with SMTP id m11mr6623749fao.50.1285540485600;
        Sun, 26 Sep 2010 15:34:45 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id 10sm2087057fax.42.2010.09.26.15.34.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 15:34:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-11-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157264>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> The routine creates a table row with a name and a repository address,
> like the one used at the top of summary view.
[...]

> +sub git_repo_url {
> +	my ($name, $url) = @_;
> +	return "<tr class=\"metadata_url\"><td>$name</td><td>$url</td></tr>\n";
> +}

It should be  *format_repo_url*, and not git_repo_url, isn't it?

By the way, doesn't gitweb include code dealing with repository URL;
why you don't _use_ this subroutine, then?

-- 
Jakub Narebski
Poland
