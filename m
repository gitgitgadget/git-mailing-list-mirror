From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 18:51:47 +0200
Message-ID: <4880CA23.40003@gmail.com>
References: <4876B223.4070707@gmail.com> <200807180149.18565.jnareb@gmail.com> <48809D31.5030008@gmail.com> <200807181735.15278.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtCM-0003zk-B3
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 18:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbYGRQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756909AbYGRQvv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 12:51:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:63835 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbYGRQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 12:51:50 -0400
Received: by fk-out-0910.google.com with SMTP id 18so286057fkq.5
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=0Fh71EUPdyfUZtyaaL3WdbQeajG6DhUOJELnj/oC9X8=;
        b=fQuSjBUn0zJZSoH0edC5yvJl1ulbxWDPLx0ZvxWbcugNQBeIajAbpgazS4/z4CxRAk
         fLamomtCDlZnzmXiKbMhHygN9ZpvUt/3hdoFDf0peaztfSjTH/L+gD30XC9wq7MbA3W1
         p4wR10VP42YA0HSF5tovk6xCHM5aEP3GArwww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=n8AAyhh4zWkDzMcqvGQVdg5qlh1emLQj4daKTLeagvnVgllAcMVSp1MdjCfN9mvOvZ
         yRPo/3WLhvgeQ3vaqIAYP+pVrmMnHY22iAWATTZVavcUmICyF7pZg0myCTBN4Cv5Ymyq
         N1dpPTf5QZdSTkQWsGIKREd/qDsNfM6ZaAayA=
Received: by 10.181.24.14 with SMTP id b14mr267316bkj.22.1216399909345;
        Fri, 18 Jul 2008 09:51:49 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.253.216])
        by mx.google.com with ESMTPS id 22sm3780731fkr.4.2008.07.18.09.51.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 09:51:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807181735.15278.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89052>

Jakub Narebski wrote:
> Besides if decoding is done in Perl API, we can convert it simply
> to Perl internal form (which, IIUC, in modern Perl is UTF-8 and
> marked as such).

FWIW, Perl strings actually contain non-encoded Unicode code points.
IOW, they're not byte strings.

> Still I think that putting cmd_output and other in Git::Repo
> is not a good API.

Yup; that's why I'm underscore-prefixing it (and taking it out of the
man page) for the next version of this patch.

> By the way, would you prefer if I commented on 3/3 patch as it is now,
> [...] or would you rather I wait for next round (next version) of patches?

I suggest you wait for the next version of the patch series, which I'll
post in a few hours.  There are quite a few changes; I'll list them in
the parent message for the series.

-- Lea
