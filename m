From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: STG, problem with pop/push of alternative versions of a patch
Date: Sat, 15 Sep 2007 23:44:03 +0100
Message-ID: <b0943d9e0709151544p1f40508cqad2663416187e15@mail.gmail.com>
References: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
	 <b0943d9e0709150107o27571446v9bef8e31517777e1@mail.gmail.com>
	 <9e4733910709150725k73bec66bw753c4b3c01244cff@mail.gmail.com>
	 <b0943d9e0709151031m70b9d03bw4068805e697e97f5@mail.gmail.com>
	 <9e4733910709151042p7c681e25o386be2ca2719daa9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 00:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWgN0-000616-BM
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 00:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXIOWoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 18:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbXIOWoF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 18:44:05 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:13553 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbXIOWoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 18:44:04 -0400
Received: by rv-out-0910.google.com with SMTP id k20so986150rvb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Q+4fgtjS6j03uzSUp1PNxeY20jA99fdz+8Zk2gi9JJY=;
        b=AKJnvTClS9SZhPdgKTZndnn6R85bOLEHdOy1eH2Ak8l7p7E0QROeY29m+nPhalh653pvmrZqEzFz39b9nVATcVagg6kA1sxjUfbRHlBYgDnnseXrh/m4LEI8WundLxUQ13742Q5LP4oddBqSP5rfupCyz/DAw5k9xOnAvfECxjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a8feF/IOiUI0wZypELMLfr0dUvtyzYspoeZ+llKoPOLcvRPrjMzJJy3EksbswrVVmi/5+2zvufRjTcDMiIN8Cd4/veayLwBfeQ13Isqtn7HlaDwU+tksr8WsBik/D6JJGRy1O+rH3T5l67ZEooXLoJ5S1IQ1/62myK3+Ffhihvc=
Received: by 10.141.195.18 with SMTP id x18mr420624rvp.1189896243391;
        Sat, 15 Sep 2007 15:44:03 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sat, 15 Sep 2007 15:44:03 -0700 (PDT)
In-Reply-To: <9e4733910709151042p7c681e25o386be2ca2719daa9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58275>

On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> I was not happy when my patch disappeared. Luckily I had exported it a
> little while earlier.

Otherwise, the patch log should be present and it shows each commit id
of the patch.

Since we are at this, I think we need a config option to automatically
back up (export) the patches. Since StGIT detects whether the patch
applied cleanly or it was modified (with a diff3 merge), it only needs
to export in a few cases and not affect the performance (diff3 takes
significantly longer anyway).

Thanks for reporting this issue.

-- 
Catalin
