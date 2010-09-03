From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Checking out a branch in another directory
Date: Fri, 3 Sep 2010 17:23:51 -0500
Message-ID: <20100903222351.GA26237@burratino>
References: <800379.5243.qm@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luben Tuikov <ltuikov@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 00:25:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orehh-0008Dv-4j
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 00:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab0ICWZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 18:25:44 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:59169 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0ICWZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 18:25:43 -0400
Received: by qyk33 with SMTP id 33so2419056qyk.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=orywGAGJ3CltiLLfGVTqFKBbm3QdoN9b2ez0vGCDPns=;
        b=SEqzgV62fTymBJZxjG8d2MLwQnAoc/J68ZsinVdzXWOiYid742nOQrRWg03S9LBCOo
         R9gzfk0qR8U5LQV6XuspAMII3mCJH7HVOcmW3PtxJWc8njIirIf5kJMycRVT5PPrE+fK
         55qs7vNOBfgwPusp6PheLqaddp0HF/zN9v9GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VWVnmmdlKUbWWesnL4fKGf3j6yW1t0z6WBbgZrxAsC9jHvz/QtErOkGb4C0aVnadcI
         M5bNLo4FFntwpp77wUuzrUuqmBnxrv9mG95AbAn4XxM1FxXfUrkETomJB/0aUrvBd2Ml
         S4kStW1ELJLxVFJ56dSwT65xdImk06ohj/p8Y=
Received: by 10.224.103.204 with SMTP id l12mr413441qao.351.1283552742469;
        Fri, 03 Sep 2010 15:25:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm2495847qcq.34.2010.09.03.15.25.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 15:25:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <800379.5243.qm@web31805.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155281>

Hi Luben,

Luben Tuikov wrote:

> For the last 4 years, I've been using a home-brewed
> git-mkdir-of-branch.sh from a local branch, which basically creates
> a bunch of symlinks and then runs git-read-tree HEAD;
> git-checkout-index -u -q -f -a.

You might like contrib/workdir/git-new-workdir (shipped in
/usr/share/doc/git by most distros).

An occasional topic has been how to integrate this functionality
into "git clone".  See [1], for example.

Good luck,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/150559/focus=151247
