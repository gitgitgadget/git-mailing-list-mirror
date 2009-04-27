From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] builtin-merge: fix a typo in an error message
Date: Mon, 27 Apr 2009 11:41:51 -0400
Message-ID: <20090427154151.GA9380@linux.vnet>
References: <20090413181008.GA8273@linux.vnet> <20090413231250.GA16990@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:42:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LySyJ-00044H-QB
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 17:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132AbZD0PmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 11:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757299AbZD0PmA
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 11:42:00 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:26223 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757657AbZD0Pl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 11:41:59 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1834710wfd.4
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 08:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=CkOtccTqYBUNfO3YLnB7qo9ZbW5vFTR3so8WC4zwiFs=;
        b=RMBarkLaB4LpDkus7GMI1SP+IGZ4S6103iAFf6J4Yu9qcIjFGfqQxR8gvwIWjLhYdm
         GaTHF4IZpLRlfIqbjkFVVrtX7m0279ARDTRm2uIxvTIo+mEjOGI+sipXEDmJcwi7wYCV
         MK0miBe8PWMsy0a2ppblLDlwe887BHgQLoqwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=unnQex3ThmaX1ZuwQ/HAOEdRKoYDoduS6fpR7R9RLMFahmn1JwxRzJ8KEVHrOIJg8m
         QPoy0IhVbJxWVMJjuBDWkse6YhPjqmZukH36WrFJ8bOjfrYSnHUQ8yzmK/dP9DOrvuMp
         +z4hvfko5xGIhK0pmpK4XWRfHo+W4LBNDybLI=
Received: by 10.142.142.16 with SMTP id p16mr1144661wfd.231.1240846918343;
        Mon, 27 Apr 2009 08:41:58 -0700 (PDT)
Received: from linux.vnet (n2-51-168.dhcp.drexel.edu [144.118.51.168])
        by mx.google.com with ESMTPS id 30sm50353wfa.35.2009.04.27.08.41.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Apr 2009 08:41:57 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
Content-Disposition: inline
In-Reply-To: <20090413231250.GA16990@genesis.frugalware.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117678>

Hello Junio,

On Tue, 14 Apr 2009, Miklos Vajna wrote:

> On Mon, Apr 13, 2009 at 02:10:08PM -0400, Allan Caffee <allan.caffee@gmail.com> wrote:
> > -		die("Could open %s for writing", git_path("MERGE_MSG"));
> > +		die("Could not open %s for writing", git_path("MERGE_MSG"));
> 
> Acked-by: Miklos Vajna <vmiklos@frugalware.org>

Is this one ready for maint?  (The issue dates back to 1c7b76be.)
