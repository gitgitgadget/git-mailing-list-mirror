From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 2/2] read-tree: migrate to parse-options
Date: Thu, 25 Jun 2009 20:15:57 -0700
Message-ID: <4A443D6D.7060009@gmail.com>
References: <1245817672-25483-2-git-send-email-bebarino@gmail.com> <1245906361-20644-1-git-send-email-bebarino@gmail.com> <4A431F5E.6070109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 05:16:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK1v8-0006BG-OQ
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 05:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbZFZDP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 23:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZFZDP5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 23:15:57 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:56865 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbZFZDP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 23:15:57 -0400
Received: by pxi28 with SMTP id 28so1415051pxi.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 20:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=upFAvHmHhKhWrzAL6099MErUFdsop9Vupj1pjbxEpDk=;
        b=a/N+UgxeiFkZnORVCHA5H0bz2NYWyZtaao8Q5FazG/V7YHgtgR2UAT2Bq8nD91POs9
         NFZSBptOcOhqV+M+6msyUIJ5IMvzdPP1jjG+SJ8/IpQOU8q5j/xx/MT+v2rij1x+pGeQ
         qBd+LrDsiPoycrXj3EWK4+YVzZ7aVai+o5WQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WHDXkopo6VU08KbcnCIKSl9eM0c187FvTSc7I3KAS5YDYLz13urfGPafEg8dZb+p9M
         6xNPmJrwPiYrVJi1rOT8snlDx70S/tg+MNdJwXszXlR4DST0xPT53fnrgsiEoQK1/8oJ
         X9ExtldCiGh7UV4odDpLcDneBciy2sAON6Weg=
Received: by 10.114.93.1 with SMTP id q1mr4985793wab.212.1245986160358;
        Thu, 25 Jun 2009 20:16:00 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id k35sm5034818waf.53.2009.06.25.20.15.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 20:15:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <4A431F5E.6070109@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122266>

Johannes Sixt wrote:
>
> If you write more than one mode of operation, the subsequent text should
> better reference them, but the current text does not do that. I think it
> is OK if you leave only the second, particularly because the first is only
> a subset of the second.

I was contemplating this change, but I left it out because the single
tree case felt special. So special that I felt the merging and the
reading were two different modes. The description section hints at the
two types of uses, but I think you want it to be more explicit? I'll
have to think about this more.

> I don't think that the bitfields of struct unpack_trees_options are cast
> in stone. IMHO it is fine to make them regular struct members, so that you
> can take their address for read_tree_options and these foo ? 1 : 0 become
> unnecessary

Thanks. I'll fix this up and resend the series.
