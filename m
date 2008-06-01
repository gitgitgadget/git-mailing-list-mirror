From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Mon, 02 Jun 2008 01:18:29 +0200
Message-ID: <48432E45.9070200@gmail.com>
References: <20080531130450.GI18781@machine.or.cz> <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 01:19:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2wpq-00060W-Vh
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 01:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYFAXSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 19:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYFAXSc
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 19:18:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:46730 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYFAXSc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 19:18:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so596069fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 16:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=PExcjBTc7hlDRs+q12NSnyl0/gxZ83bz7YvWjpYkMR4=;
        b=WOsCBga5m6vclgZC50lxL9iORwR4bOXg/QX3/unVDqG5q0DlNoKEG+riJ0IeFQJUD1lqCUkBMCXKPxPPCmDNrz8SdzAZ6cBtejsNq5zYgn0C991YbtIQLcHzsDE9RGYsPDzBKANpMVL6jSfcTFohf1sDrYWC8K9Ej2EMtqMTLS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=EAmiWi+VFr/Nkh3YgaD0KqoaIE9rYB5FbPh/b5sbqHXMoj+KglCBsqEXb6ovaRel2nmRpHPo+8b8MpsSEi7Az9+ZJker/DXrCFSky0AG70uoEk7mNZCZxwZFMl123t/s57BGXNnZUYOp6+pXRas72i0foTraAPUhDH5Ppx3BvEw=
Received: by 10.86.49.3 with SMTP id w3mr4443404fgw.4.1212362310759;
        Sun, 01 Jun 2008 16:18:30 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.205.25])
        by mx.google.com with ESMTPS id d6sm3927329fga.2.2008.06.01.16.18.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 16:18:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83478>

Lea Wiemann wrote:
> Re: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash

Since I just renamed the method from parse_rev to get_hash, I would 
technically have to post a v3 of my patch, but I'm afraid that at some 
point I'll have a v4 and v5, with a lot of time wasted. :)

Hence, to minimize effort on all sides, I'd rather suggest that I won't 
post any Gitweb patches (other than as RFCs, or perhaps bug fixes to 
existing code) for now, so that we don't introduce an unnecessary Git.pm 
dependency while the refactoring happens.  Also, since I'm posting 
(too?) many patches around Git.pm and Gitweb already, this will reduce 
the load on reviewers.

-- Lea
