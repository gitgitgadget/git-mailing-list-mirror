From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/8] bash: Remove short option completions for branch/checkout/diff.
Date: Mon, 5 Feb 2007 10:16:16 +0100
Message-ID: <200702051016.16785.jnareb@gmail.com>
References: <20070204073817.GA17603@spearce.org> <7vr6t6rycz.fsf@assigned-by-dhcp.cox.net> <20070205024704.GB12917@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 10:14:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDzw9-0002C1-Kk
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 10:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbXBEJOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 04:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752199AbXBEJOy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 04:14:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50362 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbXBEJOy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 04:14:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1240166uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 01:14:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=meCLGXMTSqYXBHSNb6YWHMd5dGCIgpNvI10MG1X6sErwOF0T+ldVT9APlHWn8HUfLiGuI0iZQ2wSFaWYogmmiOvPZ36y3FMy+Jj3Nrm9u9VcTtOBAii9hAQr4idvZVC9fedzpmgUBtbLUTSukjFNmb/oR5mFp0iXLfQEOF9ZOBg=
Received: by 10.66.232.11 with SMTP id e11mr8460770ugh.1170666892571;
        Mon, 05 Feb 2007 01:14:52 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id 24sm9925748ugf.2007.02.05.01.14.51;
        Mon, 05 Feb 2007 01:14:51 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070205024704.GB12917@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38734>

Shawn O. Pearce wrote:

> Completing single character options is rather useless in my mind.
> The bash completion is always out of date with respect to the
> actual set of supported options, and by definition they are a
> single character.  Hitting '-<tab><tab>' to identify the list of
> supported options gives *no* detail about what the options do,
> and I still have to enter the option letter to complete it.
> 
> Completing `git am --w<tab>hitespace=s<tab>trip ` with just 6
> keystrokes on the other hand is very informative (whitespace,
> strip!) and saves many keystrokes.  That's why long options are
> supported, for at least the more commonly accessed ones.

It would be nice to have long option for each git command single 
character (short) option, for example --patch as long option to 
git-diff-tree -p option, etc.

-- 
Jakub Narebski
Poland
