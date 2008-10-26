From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Sun, 26 Oct 2008 23:16:14 +0100
Message-ID: <cb7bb73a0810261516i32554afera3250e1b6a0f02b9@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <m3k5bvgz83.fsf@localhost.localdomain>
	 <cb7bb73a0810261418y3b114e2ag81cbb75c4a80603c@mail.gmail.com>
	 <200810262304.13582.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 23:17:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDvN-00082d-UM
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbYJZWQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYJZWQQ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 18:16:16 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51304 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbYJZWQP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 18:16:15 -0400
Received: by gxk9 with SMTP id 9so1710037gxk.13
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fh0mKJsb8ZT96zOzMDa4DHjhyMqqP5jyKkSdvrPQOaA=;
        b=QUh8ZDeCuptFZHJElhw3cpu39gy64I38JoM1t4XmXRjbv8/MODrtujOL+F+WJfodj0
         3j2iMFQE7+zw1ElnhMG5WTBavsFlDwwKFUbTVC992FZED/XCO4Gxf7OIWnC4vz/PapZS
         iTkqZoO5I6CSc5d9A7D9ixwKNhItaRJjo2TzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HHGwXP+Qk7ka56znqTO3n5+5g/aO9NLrJ6nQUtN0A5IGutWLnHdsC2IEODVPMBJxI4
         V08s5Ss2pTgn0zpKSDYMXdz4NdshTo4ZHlPa8XiATtWPUXARArSwP5IyOPRkM5hA5Qnu
         TX+ITDebJ7qvPAjKKYy91CCJ+dAEDvPV9bJEI=
Received: by 10.150.220.19 with SMTP id s19mr4875453ybg.217.1225059374471;
        Sun, 26 Oct 2008 15:16:14 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Sun, 26 Oct 2008 15:16:14 -0700 (PDT)
In-Reply-To: <200810262304.13582.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99189>

On Sun, Oct 26, 2008 at 11:04 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>  Gitweb config file variables
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  [...]
>   * @git_base_url_list
>     List of git base URLs used for URL to where fetch project from, shown
>     in project summary page.  Full URL is "$git_base_url/$project".
>     You can setup multiple base URLs (for example one for  git:// protocol
>     access, and one for http:// "dumb" protocol access).  Note that per
>     repository configuration in 'cloneurl' file, or as values of gitweb.url
>     project config.

Doh, thanks, I had totally overlooked it. Done 8-)

-- 
Giuseppe "Oblomov" Bilotta
