From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Tue, 06 Mar 2007 20:16:49 -0500
Message-ID: <45EE1281.5040506@gmail.com>
References: <45ECEB40.4000907@gmail.com> <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 02:16:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOklz-00038X-1r
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 02:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbXCGBQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 20:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbXCGBQt
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 20:16:49 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:19331 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161098AbXCGBQs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 20:16:48 -0500
Received: by wx-out-0506.google.com with SMTP id h31so235wxd
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 17:16:47 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VL2SiFxAKDVWbwi3lQtNehLLQ6yuNki2RfvqkWLN0bi/QZz9v/yM/ZqyDfFBcFCkYBSe9pI+WW5aLkHiJO3os7PC+d3raizuKOBGSVfaVo2zWUk1bKV73qotvrvlRrfpTmMbtB8hyfqXRFkIJXiwDdYXGifipRukk7AsA5QKcPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KA26AuLQcEQ+AO3oynxvuqtsT8opd0b/FzPTaTOrI94vbo0n7U/x+hjGHNrQdK00+MJXOmgNj7GF6aaLF7CutUeboPLI95hgo0ipg5dUoWsNlrGWOvNj0MkR85QxdLeCxC3b75+s76LYq5kpLQMwMGUKdSg/VYjz/B0LmaI7ZqE=
Received: by 10.70.29.2 with SMTP id c2mr9044422wxc.1173230207312;
        Tue, 06 Mar 2007 17:16:47 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id 3sm1984wrh.2007.03.06.17.16.46;
        Tue, 06 Mar 2007 17:16:46 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7vejo2stlw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41632>

On 3/6/07, *Junio C Hamano* <junkio@cox.net <mailto:junkio@cox.net>> wrote:


    * I'll have this in 'master' tonight.  Also I am thinking about
      changing 'git bundle verify' to spit out heads and prereqs
      unconditionally, in addition to 'foo.bdl is ok'.  Comments?

 
That is a good feature, much better than trying to list the bundle, and 
I have no issue with this suggestion.
 
We could also define "git bundle [depends|show-refs] bundle-file" to be 
more suggestive of the actual result. As the prerequisites have a common 
conceptual definition with those of a shallow clone, perhaps there 
should be a common way to get those. In this vein, git-ls-remote bundle 
already shows the references in git-like fashion.
 
Mark
