From: "Benjamin Collins" <aggieben@gmail.com>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 08:18:47 -0500
Message-ID: <b3889dff0708290618s79cffdb5nb6cc69d14efa8b9@mail.gmail.com>
References: <1188319608.6106.63.camel@beauty>
	 <20070828172709.GB1219@pasky.or.cz>
	 <200708291005.08795.andyparkins@gmail.com>
	 <20070829095202.GE1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 29 15:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQNRd-00051K-E7
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 15:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbXH2NSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 09:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756377AbXH2NSu
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 09:18:50 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:55597 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268AbXH2NSt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 09:18:49 -0400
Received: by an-out-0708.google.com with SMTP id d31so36390and
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 06:18:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hboi3FFJTzwuWD07k0AVrLW71xGCDDsQztvNZAbdEUvm+Y8jrfVeC7ATM9qzv9hUTujYGFDunLMxEzbxHGbrdGwlg2II/Mj8JMNqFbc1oM/dMTdwUZDlKQoLt6vkRMUM1CBrytcFQrN3+DtVti3GWKYNZfrHVM1tgnLddndqdRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AiJQH0ZJfgyAa3c6D960ZYh3O4roGanEY7Cn9O6EW/Sgtq5fqcgpYaH4qn0IjjFhZv3O2dv5aPUzZlEFXOsVqMfKTULd8p19LD0qYSWg8AuuEHNjv0D4W11J8b20odwkEvyqYALJgqBz0WmGehU28NpPkyithtp/CLN4kIhlRN0=
Received: by 10.100.195.10 with SMTP id s10mr454083anf.1188393527799;
        Wed, 29 Aug 2007 06:18:47 -0700 (PDT)
Received: by 10.100.109.10 with HTTP; Wed, 29 Aug 2007 06:18:47 -0700 (PDT)
In-Reply-To: <20070829095202.GE1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56944>

On 8/29/07, Petr Baudis <pasky@suse.cz> wrote:
> But overally, I'm still not convinced that there is a feasible use-case
> for the cloned hooks at all. Someone has a particular example?
>
> --
>                                 Petr "Pasky" Baudis

My group at work would like this capability.  We have a homogeneous
environment with well-known NFS shares, and some scripts that do
things in this common environment (e.g., release scripts).  It would
be nice if when we do a clone, all the hook scripts (that would be
valid on any machine, in any directory, for any user) would come with
it.

Of course, I understand why it's not already like that, particularly
given the context of Linux development practices.  Still - there are
those of us that think this would be a great convenience.  Having an
option to git-clone to retrieve the parent's hook scripts would be
preferable, and have git-clone just disable them by default.
'git-clone -t repo' or some such.

-- 
Benjamin A. Collins <aggieben@gmail.com>
http://bloggoergosum.us
