From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] ls-remote: print URL when no repo is specified
Date: Sun, 9 May 2010 17:01:23 -0500
Message-ID: <20100509220122.GA2098@progeny.tock>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 00:01:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBEZD-0004rw-PB
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 00:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab0EIWBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 18:01:38 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:57036 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab0EIWBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 18:01:37 -0400
Received: by qyk13 with SMTP id 13so4993211qyk.1
        for <git@vger.kernel.org>; Sun, 09 May 2010 15:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z5GKtwUf9jBf55F/Xk9S13ziBfs9KDiRpwCkIisGEw4=;
        b=KzFWtrS/8uiUmQ+dcQEXMURMyAsiFKE5ihDecrMYZ3VZ52kwgo1qYcIAII3IfqBi5K
         qXa4uLm4E3Z3t7UlQFAOdJUQi9zz8VPb6EgwLl/IDIn5I1TtAvFampyzIS1h/xB/25gW
         N5EI1zgmFX0C5Hwg6Hn2KE0wfI10abjFBwcf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t/TNReKWxQkfCPlq911JfHcSzDNahBwlKqkhgQeiA3CwQmwXE/ctQ9YgLbUkfWswJE
         lkDcw67k1dM5jodthy2LmXy8VH4h+WdNZVg6qh6/Hzh6MWXP4/UH/2cg8JBDn5pXE2v5
         z/FeaN2GgqJFt4f4Zrk9AYHjsIPcnbxEUKSSc=
Received: by 10.224.85.148 with SMTP id o20mr1842682qal.65.1273442490802;
        Sun, 09 May 2010 15:01:30 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g19sm3316825qcq.11.2010.05.09.15.01.28
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 15:01:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1273416140-5044-1-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146749>

Tay Ray Chuan wrote:

> when no repository is specified, ls-remote may use
> the URL/remote in the config "branch.<name>.remote" or the remote
> "origin"
[...]
> In such cases, print a simple "From <URL>" line to indicate which
> repository was used. This message is similar to git-fetch's

Makes sense.  The code and tests look sane.

Testing on Linux and Msysgit does not reveal any problems, either.

Thanks,
Jonathan
