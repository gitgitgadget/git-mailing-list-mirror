From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 0/3] setup: stop ignoring GIT_WORK_TREE (when GIT_DIR
 is unset)
Date: Wed, 19 Jan 2011 07:05:24 -0600
Message-ID: <20110119130524.GB22496@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 14:05:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfXjM-00082I-Ec
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 14:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754332Ab1ASNFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 08:05:38 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55500 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1ASNFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 08:05:37 -0500
Received: by qwa26 with SMTP id 26so808654qwa.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 05:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dmw8zjG5N3e15MxcbmKm/NJ2/i7GH9HaonVwXMC2fnk=;
        b=nWp3AlAONC23tONcDjT+sUh6h1MrfddH3fDPCD3qUta0UYjSGqWwu708+xRE+aeduX
         1AIL69JpXI5PBvQ1IDXZI6YLf7DO8TR+etVToRiDsJYqkuHBvnUeSxdqYn3+QKxUqusG
         /fMkTFqrQ32g6+VNQTIn2M1elFiQ+QAreCB7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CBshNgyTanMr9WHUgIuldyYi9sVw9KhWFGDOBOSV4rtDtRjomUMfuHM091rbwwPz4s
         Sj/l07s764/VYr38ZQWngG13Za0I+K7zHsCM1w51XyiQjeAuxNNJZdm/0jC4lOGATS5w
         AtnnrfaSjtsfuZfkmzUiuSiWb6pTq06NNRfOQ=
Received: by 10.224.60.84 with SMTP id o20mr652723qah.334.1295442337283;
        Wed, 19 Jan 2011 05:05:37 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id g32sm4701980qck.46.2011.01.19.05.05.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Jan 2011 05:05:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110119123732.GA23222@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165266>

Jonathan Nieder wrote:

>   tests: cosmetic improvements to the repo-setup test
>   tests: make the setup tests briefer
>   setup: stop ignoring GIT_WORK_TREE and core.worktree
> 
>  setup.c               |   27 +-
>  t/t1510-repo-setup.sh | 5166 +++++++------------------------------------------
>  2 files changed, 729 insertions(+), 4464 deletions(-)

It seems that the second patch was too long to send by mail.  The
series can be retrieved by git at

 git://repo.or.cz/git/jrn.git worktree-with-implicit-git-dir

Patches are based on js/test-windows to avoid semantically
uninteresting conflicts.
