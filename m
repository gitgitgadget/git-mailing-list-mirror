From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Sat, 19 May 2007 02:43:48 +0200
Message-ID: <200705190243.49788.jnareb@gmail.com>
References: <20070517023112.21056.62390.stgit@rover> <f2k4d5$879$1@sea.gmane.org> <20070518123538.GW4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat May 19 02:44:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpD39-0006fr-Pv
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbXESAnv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbXESAnv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:43:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:57635 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbXESAnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:43:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so627506uga
        for <git@vger.kernel.org>; Fri, 18 May 2007 17:43:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U07J7Tdeoa1eTHqdM1cbfJw7WRWHuRRcRE//haM0H+zaNoYoDabDUVcRMziQO/Hlrbba279tCuO07wKn+3IRNh/3uQqO+V9kf2zDuHV5SVCzrsKgEwPozwujDbG4jdxkyee+0UL4DeGOaMJEexuGAtNr2WtzJMozClr/hJuDDsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mYHukU/AzrZY/DLi+Wjw+TIhxrxjyKFt2ceqvQP4H03ecGyguWxOEEyj5DZx9u7/chXS8W18CgOfpd2oES9aEUgQq1FJMb2aQ5u65QkoQXD9FI6ptP53z34cDH7zJlUg0fYbtNQNe22MzbRJFJBpwVVtXgRZbCLIJPz058EUHc8=
Received: by 10.67.31.17 with SMTP id i17mr1414157ugj.1179535429515;
        Fri, 18 May 2007 17:43:49 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y2sm8168261mug.2007.05.18.17.43.46;
        Fri, 18 May 2007 17:43:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070518123538.GW4489@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47698>

Petr Baudis wrote:
> On Fri, May 18, 2007 at 01:58:28PM CEST, Jakub Narebski wrote:

>> Additionally it would be nice to have links from search results page to
>> have search match highlighted, like search results on GitWiki.

For example 
  http://git.or.cz/gitwiki/SubprojectSupport?highlight=%28Subproject%29
 
> I'm sorry, I don't understand.

For example search results for commit search ('author', 'committer'
and 'commit' searches have link to 'commit' view. Pickaxe has link
to 'commitdiff' view. Grep search would have link(s) to blob views.
In those views the 's' (searchtext) parameter could be passed, and
matched fragment should be somehow higlighted, e.g. using background
color to not interfere with syntax highlighting.

-- 
Jakub Narebski
Poland
