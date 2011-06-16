From: Ilya Basin <basinilya@gmail.com>
Subject: Re[2]: rewrite history
Date: Fri, 17 Jun 2011 01:55:09 +0400
Message-ID: <7310048292.20110617015509@gmail.com>
References: <362053118.20110616231758@gmail.com> <20110616192644.GB13466@sigill.intra.peff.net> <7vhb7ph8aj.fsf@alter.siamese.dyndns.org> <20110616194911.GA14355@sigill.intra.peff.net> <17721660.20110617000644@gmail.com> <20110616201300.GA14674@sigill.intra.peff.net>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 23:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXKX7-00076k-6b
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 23:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933119Ab1FPVzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 17:55:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55069 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933087Ab1FPVzT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 17:55:19 -0400
Received: by bwz15 with SMTP id 15so321199bwz.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-mailer:reply-to:x-priority
         :message-id:to:cc:subject:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=hcjo7svMWXoO9LzDmHm8i9ZPfrnFTbGIrIvYBPQPGAE=;
        b=uEUFS69yr3JcBwGPdcrwqkgq0KM0KkZRH2zezUo5htxd98/5ox88ARFU70eZNbggoX
         EStNaRiaxZSrF05biQqnNwXR3J8r/CVazUq3JOf1AF/c1cKysxiCqzk9daCcaJntBBZ7
         5GMZ2Jv0q70GPWiZBs8Qpp/JmePMwy23iogQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:cc:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        b=JQz/g0RFqevCAjGKscUJhw+2NZq59CG1WK8luK3TJIGAzr0Id4kAq4WROgM/oG6Vyn
         ZiVohL2tKIqhwVzde+YtoEBKffAgM9eENhs60shqaLCXQAsTLESTct4+9qKPrFyPgPQg
         4gQnLqLWfXNxvNrZ30I95lilFdxJ4WgPuds8I=
Received: by 10.204.36.206 with SMTP id u14mr1036983bkd.4.1308261317357;
        Thu, 16 Jun 2011 14:55:17 -0700 (PDT)
Received: from MAR2.localnet (pppoe.95-55-137-3.dynamic.avangarddsl.ru [95.55.137.3])
        by mx.google.com with ESMTPS id af13sm1506782bkc.7.2011.06.16.14.55.15
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 14:55:16 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20110616201300.GA14674@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175935>

>> sorry,
>> git diff X X' is empty

JK> Oh, then ignore everything I said. :)

JK> I think you want to graft and filter-branch as Junio mentioned.

JK> -Peff

I'm puzzled. How to undo an unfortunate attempt of filter-branch?
git log origin/master returns irrelevant info, although I didn't push
it to origin and I also tried git branch -D master, -rD master and git
fetch -f


-- 
