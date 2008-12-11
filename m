From: rdkrsr <rdkrsr@googlemail.com>
Subject: Fwd: after first git clone of linux kernel repository there are changed files in working dir
Date: Thu, 11 Dec 2008 18:15:44 +0100
Message-ID: <d304880b0812110915o6968050cufbb1e29c8bcea984@mail.gmail.com>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	 <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	 <e32b7bb40812101220s370a64f1n3f7ecb56dd352405@mail.gmail.com>
	 <d304880b0812110142g41b80745ic09a7200e02dcdb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 18:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAp9s-0007n2-Vi
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 18:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561AbYLKRPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 12:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756575AbYLKRPq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 12:15:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:36014 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756480AbYLKRPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 12:15:45 -0500
Received: by rv-out-0506.google.com with SMTP id f9so2035309rvb.4
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=00VOuI6UGVJpK/K3v0LXOaEtCWD0ZT6dhfIT4JkpNvE=;
        b=BAUReHfrbjo1xXm3snmxnggzVVZE/Mgja8UD2fgTGqqxABwXeqbIiIdNDgTBcCG0as
         xkRheZsgjkfwAUivfgs0WsGjOpNsGj0YiaAOGQ7TNrc/U6N9arg8oRMC3TKF+42wADII
         4koqK40jK/lWMxKC0YPPP8G9pluBysxLgQyxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EPziV/Tg/UZNQ6amzs6qF0wr2yvsMHSbqe4grBoYQHExegy3Rw9ElWrNYdtQ3QvzTA
         lMWDjx3Fh0fgAtVEGI9sH1JEsBpvn3sEhZSPyQy3nPAscShvUFuYwwgC6QzHX84QqOCU
         MRFBrZ/NKIHU+JFnVs7T93pUukJtJ2C8t9Bug=
Received: by 10.141.193.1 with SMTP id v1mr1373817rvp.186.1229015744118;
        Thu, 11 Dec 2008 09:15:44 -0800 (PST)
Received: by 10.140.172.16 with HTTP; Thu, 11 Dec 2008 09:15:44 -0800 (PST)
In-Reply-To: <d304880b0812110142g41b80745ic09a7200e02dcdb0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102806>

I'm sorry that I didn't answer to git mailing list address. So here
comes the email again.


Here is what I did:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li
t linux-2.6
Initialize linux-2.6/.git
Initialized empty Git repository in c:/Dokumente und Einstellungen/Ge
Eigene Dateien/vbox/linux-2.6/.git/
remote: Counting objects: 980697, done.←[K
remote: Compressing objects: 100% (161545/161545), done.←[K
remote: Total 980697 (delta 818552), reused 978923 (delta 816954)←[K
Receiving objects: 100% (980697/980697), 236.14 MiB | 90 KiB/s, done.
Resolving deltas: 100% (818552/818552), done.
Checking out files: 100% (25254/25254), done.

$ cd linux-2.6

$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   Documentation/IO-mapping.txt
#       modified:   include/linux/netfilter/xt_CONNMARK.h
#       modified:   include/linux/netfilter/xt_DSCP.h
#       modified:   include/linux/netfilter/xt_MARK.h
#       modified:   include/linux/netfilter/xt_RATEEST.h
#       modified:   include/linux/netfilter/xt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_CONNMARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_DSCP.h
#       modified:   include/linux/netfilter_ipv4/ipt_ECN.h
#       modified:   include/linux/netfilter_ipv4/ipt_MARK.h
#       modified:   include/linux/netfilter_ipv4/ipt_TCPMSS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TOS.h
#       modified:   include/linux/netfilter_ipv4/ipt_TTL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_HL.h
#       modified:   include/linux/netfilter_ipv6/ip6t_MARK.h
#       modified:   net/ipv4/netfilter/ipt_ECN.c
#       modified:   net/ipv4/netfilter/ipt_TTL.c
#       modified:   net/ipv6/netfilter/ip6t_HL.c
#       modified:   net/netfilter/xt_CONNMARK.c
#       modified:   net/netfilter/xt_DSCP.c
#       modified:   net/netfilter/xt_MARK.c
#       modified:   net/netfilter/xt_RATEEST.c
#       modified:   net/netfilter/xt_TCPMSS.c
#
no changes added to commit (use "git add" and/or "git commit -a")

2008/12/10 Brett Simmers <swtaarrs@gmail.com>:
> On Wed, Dec 10, 2008 at 1:22 PM, rdkrsr <rdkrsr@googlemail.com> wrote:
>> I just fetched the sources without changing anything, but git diff
>> shows, that there are changes that are not yet updated (changed but not
>> updated: use git add to ...). Why is it like that?
>>
>> I use msysgit on windows, maybe that is one reason?
>
> What are the filenames? I've seen git on Windows get confused if a
> repository has two files that are the same except for the case of some
> of the letters (since both can't exist by default on NTFS).
>
> -Brett
>
