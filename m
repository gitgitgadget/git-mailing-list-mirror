From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] detection of directory renames
Date: Mon, 27 Oct 2008 06:35:44 -0700 (PDT)
Message-ID: <m3fxmignz3.fsf@localhost.localdomain>
References: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
	<20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 14:37:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuSHG-0001ar-2V
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 14:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYJ0Nft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 09:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYJ0Nfs
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 09:35:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2357 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbYJ0Nfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 09:35:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so672685nfc.21
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 06:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=/X7lBGioKtiNl2Y26aoXxjQLqmmLLqJ3gpuqBKIRG1A=;
        b=IxNL+uzB27D5LkTkVzS0MB+rwsjmy4FgfXq4o1LP4vHYvWhLwFv9Qpp0POhTfLgFOl
         51Yf/g4YfQBIIAhoYhfZqfeN9zTtj6VA029QLLNkPFN4KWe04ABp+ydOS8h8PX67Eb8h
         B11RX/iyYF5P5K1qD1z3GVpys9g36wGYMl/1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=bvSaeMNtmgbpBAJMntnEFxf6bnmrJ7XmkRswRGwcN+PI62aqU0iLLmubdwC1dtDBDr
         HnzJv30Cv1kbk+rqtlBMC6Q5/e8X0TmkZk9epoxjQuEHtAk46QGWrzXVft4S5LYooXIH
         iKTqv0mx/s3EY2kdeDCIREFVPCTfbE45dxrj4=
Received: by 10.210.59.14 with SMTP id h14mr6660380eba.169.1225114546728;
        Mon, 27 Oct 2008 06:35:46 -0700 (PDT)
Received: from localhost.localdomain (abvq236.neoplus.adsl.tpnet.pl [83.8.214.236])
        by mx.google.com with ESMTPS id 5sm5874727eyh.2.2008.10.27.06.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 06:35:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9RDZXMt015199;
	Mon, 27 Oct 2008 14:35:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9RDZTZG015196;
	Mon, 27 Oct 2008 14:35:29 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99231>

Yann Dirson <ydirson@altern.org> writes:

> This is a first very preliminar patch, mostly so people can comment
> early on the big picture.  It has a number of limitations, many but
> not all already listed as FIXME's in the patch itself.  If anything in
> this patch seems so wrong it is not worth polishing it, it's the
> perfect time to say so :)

What happened to this work? I din't see it mentioned in "what's
cooking..." announcements...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
