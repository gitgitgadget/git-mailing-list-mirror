From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Submodules use case: web development based on modular CMS
Date: Mon, 28 Jan 2008 11:44:48 +0100
Message-ID: <200801281144.51261.jnareb@gmail.com>
References: <200801270139.57830.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 28 11:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRUv-0005J1-Ox
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972AbYA1KpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 05:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758785AbYA1KpF
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:45:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:1781 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758972AbYA1KpC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 05:45:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1664207fga.17
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 02:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=y+lgClKzEav7P2xKhSJTjyjZSyq0GhYQNh/Rbhmojuc=;
        b=eeEI+mfNVkssdQTkKnYNWkzqgbnVKB63lQMsmCTIYxb/i3F0MJ9A0KUuJWQRUhPVGDU6iwDol+ln9rBdcSusq7J3wg8+/9O5C+5G2ylLgzdfNJ122l8mUTmBh6h6E3dZ3AGs1eBKyDls1QaT25oQBSLvh1hbYtPJ8i2q5oMpc68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Y8KTe8b/apGi6t5v0wsebNQ2DxyvSLpkckZmvvETwgWNjb25KqyF3b4AswyfPzox8sEvhqqCPELouVOzYN6awbjZNGUOi9KWXNs8XGYoxJz4ttGrhz9wwOqz0x8AYD1nF3TtWmHcKOY0hfEVj4NngjJdTFviUazAc1Y9xzR2gPA=
Received: by 10.82.106.14 with SMTP id e14mr9464087buc.38.1201517100854;
        Mon, 28 Jan 2008 02:45:00 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.198.108])
        by mx.google.com with ESMTPS id j8sm6878285gvb.7.2008.01.28.02.44.58
        (version=SSLv3 cipher=OTHER);
        Mon, 28 Jan 2008 02:44:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200801270139.57830.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71877>

On Sun, 27 Jan 2008, Jakub Narebski wrote:

> Somebody (in comments) proposed using Subversion externals; I have 
> proposed using Git submodules (subproject) support. 

BTW. Mercurial supports something similar by so called (unofficial) 
"forest extension":
  http://www.selenic.com/mercurial/wiki/index.cgi/ForestExtension

If I understand it corectly the mechanism follow idea of manifest-like 
file Mercurial uses, and is similar to one of the test implementations 
of submodule support before we had current "in core" version.

I wonder if Bazaar-NG has similar extension / plugin...


It would be nice to have comparison of submodule / subproject support in 
different version control systems...
-- 
Jakub Narebski
Poland
