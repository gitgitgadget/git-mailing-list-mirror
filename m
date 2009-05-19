From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Tue, 19 May 2009 09:13:41 -0700 (PDT)
Message-ID: <m3my99jclg.fsf@localhost.localdomain>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
	<32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 18:13:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Rwt-0004bg-QS
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZESQNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZESQNm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:13:42 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61617 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbZESQNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 12:13:42 -0400
Received: by fxm2 with SMTP id 2so3976747fxm.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=qdrkLXzKzhX6mbE8+OpSnarcKRnm2PUx2vR8hEPNSBg=;
        b=HDKD2pCpMqDJfN5Nh5UsEfm0BvTDX2bpAKI5+Xpho2lO78kPTyPRZBy3FYRzXKVyJq
         bbPbfZC/gx8Q5KWsIQloe6u0hbf/UAU6fdjUjWv82/B7KyXxZqtgof/QpLgzb/HAGYSW
         4upECGjfFc1a2xOAQPKCLx6XUfCOamYpyZiz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fDXi9vuHVlcDLFqG058E419pd2s/qK2+Ry/ZRH67iwyQC28K7Fq+7WzSDRBZnYYZcn
         VaLM/UGDSkBPwnLOwlfuMGQnndBlKYpj2vy0xvgNe6VgwKV20IJhOTDcIFeClnGTpI93
         meeCLDS8LTIIMlqKW6t9TZP4/PEyWPq0TpSfY=
Received: by 10.103.246.1 with SMTP id y1mr122867mur.72.1242749622226;
        Tue, 19 May 2009 09:13:42 -0700 (PDT)
Received: from localhost.localdomain (abvi55.neoplus.adsl.tpnet.pl [83.8.206.55])
        by mx.google.com with ESMTPS id n10sm209322mue.17.2009.05.19.09.13.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 May 2009 09:13:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4JGD2P6015621;
	Tue, 19 May 2009 18:13:13 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4JGCh0S015617;
	Tue, 19 May 2009 18:12:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119542>

Avery Pennarun <apenwarr@gmail.com> writes:
> On Fri, May 8, 2009 at 6:39 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> >
> > I first sent out this patch set a couple of weeks ago
> > (http://article.gmane.org/gmane.comp.version-control.git/117612) and got a
> > couple of positive comments, but no negative ones, so I'm guessing people
> > haven't reviewed it as closely as I would have hoped :)
[...]

> Just checking in again.  Since I originally announced git-subtree, it
> (or rather the concept) has received a bit of positive feedback out in
> the wild.  My original blog post about it:
> http://alumnit.ca/~apenwarr/log/?m=200904#30

[...]
> Meanwhile, I've been keeping it in a separate git repo here:
> http://github.com/apenwarr/git-subtree/commits/master (that's a web
> link, not a git link).

I have added information about git-subtree to git wiki on
http://git.or.cz/gitwiki/InterfacesFrontendsAndTools (which page I
imagined to be clearinghouse / list of relevant git related tools).
Please correct any mistakes, and perhaps expand information there.

You might want to add SubtreeMerge page to git wiki, and link it
from subproject pages (SubmoduleSupport, GitSubmoduleTutorial)
and perhaps also from GitDocumentation. But it is not necessary.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
