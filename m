From: Andreas Ericsson <ae@op5.se>
Subject: Re: Tilde spec - befuzzled
Date: Tue, 28 Feb 2012 10:50:12 +0100
Message-ID: <4F4CA354.2070503@op5.se>
References: <4F4C995D.9000504@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 10:50:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2JhP-00040t-J9
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 10:50:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275Ab2B1JuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 04:50:18 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48495 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756115Ab2B1JuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 04:50:16 -0500
Received: by lahj13 with SMTP id j13so1983644lah.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 01:50:15 -0800 (PST)
Received-SPF: pass (google.com: domain of exon@op5.com designates 10.152.102.145 as permitted sender) client-ip=10.152.102.145;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of exon@op5.com designates 10.152.102.145 as permitted sender) smtp.mail=exon@op5.com
Received: from mr.google.com ([10.152.102.145])
        by 10.152.102.145 with SMTP id fo17mr14985389lab.2.1330422615200 (num_hops = 1);
        Tue, 28 Feb 2012 01:50:15 -0800 (PST)
Received: by 10.152.102.145 with SMTP id fo17mr12496691lab.2.1330422615110;
        Tue, 28 Feb 2012 01:50:15 -0800 (PST)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id fl2sm21261639lbb.4.2012.02.28.01.50.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 01:50:14 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <4F4C995D.9000504@diamand.org>
X-Gm-Message-State: ALoCoQktcs/sa/y1gsBOeBZphFFkQUc3Ksnb6kITaOsDsPidkw7QAm4PoySIUKSP9bYd8rNM43Ks
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191706>

On 02/28/2012 10:07 AM, Luke Diamand wrote:
> The documentation for caret and tilde specs is making my head hurt, even though they always _do_ exactly what I want. And I thought I understood them until I read more carefully.
> 
> A suffix '{caret}' to a revision parameter means the first parent of
> that commit object. '{caret}<n>' means the <n>th parent (i.e.
> '<rev>{caret}'
> 
> So far, so good.
> 
> '<rev>{tilde}<n>', e.g. 'master{tilde}3'::
> A suffix '{tilde}<n>' to a revision parameter means the commit
> object that is the <n>th generation grand-parent of the named
> commit object, following only the first parents.
> 
> Hang on, *grand*-parents?
> 

Replace "grand-parent" with "ancestor" and your head might hurt a
little less. Caret only ever describes parent, while tilde can
describe either parent or n'th generation grand-parent. Since parent
and grand-parent are all ancestors, that would be a better term.

I believe this stems from the fact that most git-gurus use a single
caret to specify 'parent' and only go to the tilde when they want
grandparents. It might be because caret was implemented first, or
because of english keyboard layout. On swedish keyboards, using tilde
is far more convenient than using caret, so that's what I mostly use
when I want the parent of a single-parent commit (it requires only
one hand and no thumb-acrobatics even on my laptop).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
