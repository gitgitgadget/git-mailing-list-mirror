From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: creating tracking branches with git gui
Date: Thu, 8 May 2008 08:36:11 +0530
Message-ID: <2e24e5b90805072006j311b276cpe0a0d0eea9fa13a0@mail.gmail.com>
References: <2e24e5b90805070104i337f9196g90134d11f35a1094@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 08 05:07:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtwTL-0004Xa-84
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 05:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbYEHDGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 23:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756144AbYEHDGP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 23:06:15 -0400
Received: from ti-out-0910.google.com ([209.85.142.188]:21839 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbYEHDGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 23:06:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so208798tic.23
        for <git@vger.kernel.org>; Wed, 07 May 2008 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7JhlPGF9ZG7qphrLWSaDO1tYsdPARa+D1RBfGvQGU1U=;
        b=TlCIji487vQlUJ928PBPsu1aWUUWqWLRMdO0KS3OmyzBRRou+GwTrsad3HjoCQ7hTMMYbjX0x3TjuztqZpOY4mDoaQj5CTI9bo2+mHg8gxqlqTlJtqf7Xb0F6OdvxeXmU58ExRTiZ1tpdQ0sN5sLFrohAMK/t+nDB8IawK9HuOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hRvCCtsSa9xlANTlq1+Uk++pgollH0Qe9CQ5aPJBOrB4e7gahHIjXQAFQhTizaDbruUMWtaZ8MIUhG9TDgtqrX9Wzpyj/oquaRGukEIB0vE/q0khtoMa1VQxjiz+TfyeuB9HG0NHTIwnJyCyj1hjK9QMZWPEtmeMAxXgFxGq2Ko=
Received: by 10.110.93.11 with SMTP id q11mr260994tib.10.1210215971231;
        Wed, 07 May 2008 20:06:11 -0700 (PDT)
Received: by 10.110.105.1 with HTTP; Wed, 7 May 2008 20:06:11 -0700 (PDT)
In-Reply-To: <2e24e5b90805070104i337f9196g90134d11f35a1094@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81502>

Can someone help me with this please or at least put me out of my misery? :-)

Over on another thread I found a config variable called
gui.matchtrackingbranch, but setting that to true only saved me a
mouse click -- it didn't really create the tracking, as seen by "git
remote show origin".

Thanks,

Sitaram

On Wed, May 7, 2008 at 1:34 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Hello,
>
>  Using git gui to create tracking branches only creates the local
>  branch, but does not establish tracking.  Using the command "git
>  branch newbr origin/newbr" works as expected of course.
>
>  I clicked on "Branch", then "Create", chose the "Match Tracking Branch
>  Name" radio button, chose the appropriate branch (origin/newbr) in the
>  list below, then finally hit Create at the bottom right.
>
>  I can write up a more detailed note if required but I thought I'd ask
>  if this was a bug in my understanding first :-)
>
>  Thanks,
>
>  Sitaram
>
