From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Prevent deleting .gitignore file
Date: Wed, 16 Feb 2011 16:02:17 +0530
Message-ID: <20110216103113.GA20959@kytes>
References: <1297848579774-6030991.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: baluchen <murugan.bala@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:31:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpefT-0008Eu-Ip
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902Ab1BPKb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:31:27 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36384 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755173Ab1BPKbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:31:25 -0500
Received: by iwn9 with SMTP id 9so1160245iwn.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VT7sW2Q8ByLjZ+MneEWH2uTsikJHHo+20JeTEYY/LzA=;
        b=eBhvyNrHOEv+YoIk+A6addpdCi1b9VB/YxOdLF8t1XX7iQ6KoF301xtv9r2OphzyqC
         sLuHjYH8EV2R0TRHCleZILbF5ga26g7b44npWqPS4oOha8ZhXN90vwQz+YHbyTQzdh4X
         9RouO+8UdWRFoX3N8E3lzOpEAUqY6UlP1dzy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=acyFm6yZOywVNjWKHQVn4gbN0VV6GtsG+xElbGoj6affPzXE8UQ6hvPQu3yt0o+GB3
         XvVQJSJAsbyEYhb3VUTCahVGrsLJXDPQhAGQWOQf+ZH8NXapQE5OLUAQbfW8ai4/mgRc
         YFADpIBpO3sjHElAbl8mDaGVhI3wgcyL5Pegg=
Received: by 10.231.16.197 with SMTP id p5mr318446iba.39.1297852284809;
        Wed, 16 Feb 2011 02:31:24 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i16sm456454ibl.0.2011.02.16.02.31.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:31:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297848579774-6030991.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166951>

Hi,

baluchen writes:
> Is there anyway to prevent/modify .gitignore file?

Just track it in Git? Everytime you try to stage changes and commit,
Git will alert you when .gitignore has changed.

-- Ram
