From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-filter-branch : LANG / LC_ALL = C breaks UTF-8 author names
Date: Fri, 20 Aug 2010 08:32:44 -0500
Message-ID: <20100820133244.GB15736@burratino>
References: <4C6E8109.5030202@leadformance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard MICHAEL <rmichael@leadformance.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:34:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRk0-0007Qi-Db
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab0HTNee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:34:34 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37737 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0HTNec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 09:34:32 -0400
Received: by qwh6 with SMTP id 6so2984422qwh.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Rp1YSdGydUHsSZiS9bIN5OvrJyMfLJiMuuI6se8rmdY=;
        b=wXCrjtkO7gjDRxmD5LTKcKUuVXSycl4HyhMg3ONbTIAK/R1TLOw7t64Dcl/+Rf5pzq
         tysGEmhf4qnK/6FpYF/HJjwGYgNaGz9gMY2ddBXnkx1SUQsky1rOHd+WiqJeQiZiDY0I
         V+8kwBoiKiK6SH1rqy4qV7szbQsikdxAJXTro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=StDUGeuOHAg4DgJhoE4KL4FmDOEkstuCtYRXWk7NhiwjEmA2erd5pknAaQBIsgUWya
         KGGMXaIw8tSwUGUC4I3MFoQkdF8nqbJILCSI4+iXCQ252We+fw41h98nSPVWi6SfQ52r
         w/Z+4UFAIFo3bUiDpqpfwAlB+XtfTc3/E0ZOg=
Received: by 10.224.37.19 with SMTP id v19mr963315qad.184.1282311271869;
        Fri, 20 Aug 2010 06:34:31 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm3177831qcs.35.2010.08.20.06.34.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 06:34:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6E8109.5030202@leadformance.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154035>

Richard MICHAEL wrote:

> I am filtering our repo with git-filter-branch, but as the sed
> script runs with LANG=C LC_ALL=C (7 bit US ASCII), it dies on
> commits authored by our team members with accented names.

Yep, someone else recently sent a report about such a sed version,
too.  It is breaking our fragile minds; we ought to find some way to
deal with it, but we haven't yet.

Jonathan
