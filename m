From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: make logo optional
Date: Tue, 4 Jan 2011 12:52:39 +0100
Message-ID: <201101041252.40254.jnareb@gmail.com>
References: <20110104050206.GA8280@burratino> <20110104050555.GC8280@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 12:53:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa5Ri-000622-2C
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 12:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab1ADLwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 06:52:53 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58225 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855Ab1ADLww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 06:52:52 -0500
Received: by bwz15 with SMTP id 15so14476068bwz.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 03:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pX0bYcWDd52KFtSIRE7I/aMOgvaaJcq9IyT1FvDeif8=;
        b=BrPDnYJfuTkySdj2+5Q6MDwVSHMBYFb7A/Jd4GiC3agrwX4/X0UJ4xy2Q7K8iB68Ot
         VQXrL4kML4eUXdrIT+p9KqVpU2rk70y8pHdRu+fG9vOxZ7yCb3avu8sqBgSV10HMqtSh
         uuX1xeaIxTUS5xpLwrLoP/l445OF5i+VnYHtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=scX3wI0LSuad87Mz2y4eq/XftVOIBAbEgUunX1fXvOCAQ5UaCd/hJX5yVRp+eHptKN
         nbVK1Vadv0uxAWpEWHl3OblqdV0GKJMcSLzXYDgGHrR1Gdgk6TltTMtSZEi0qLwjBTo5
         KHVbN7j8hY4cdPQnC4crWQYphguZD+BUuE6dU=
Received: by 10.204.72.130 with SMTP id m2mr764802bkj.15.1294141970901;
        Tue, 04 Jan 2011 03:52:50 -0800 (PST)
Received: from [192.168.1.13] (abvw52.neoplus.adsl.tpnet.pl [83.8.220.52])
        by mx.google.com with ESMTPS id b17sm12152292bku.20.2011.01.04.03.52.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 03:52:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110104050555.GC8280@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164484>

On Tue, 4 Dec 2011, Jonathan Nieder wrote:

> Some sites may not want to have a logo at all.  In particular, git
> instaweb can benefit from this.

Why do you think that git-instaweb can benefit from not having logo?
You need gitweb.css anyway, so it is not much more trouble to serve
additional static file, git-logo.png.

> 
> While at it, use $cgi->img to simplify this code.  (CGI.pm learned
> most HTML4 tags by version 2.79, so this should be portable to perl
> 5.8, though I haven't tested.)

corelist (Module::CoreList) says that Perl 5.8.0 has CGI.pm version 2.81;
IIRC gitweb requires something later than 5.8.0 for good support of
Unicode (Encode module).

> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

For what it is worth it:

Acked-by: Jakub Narebski <jnareb@gmail.com>

-- 
Jakub Narebski
Poland
