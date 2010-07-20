From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 14:14:31 -0400
Message-ID: <20100720181431.GA12857@localhost.localdomain>
References: <20100720163822.GA8492@localhost.localdomain>
 <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
 <7veieym3sh.fsf@alter.siamese.dyndns.org>
 <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 20 20:14:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHL3-0005PX-1d
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237Ab0GTSOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:14:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57978 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113Ab0GTSOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:14:38 -0400
Received: by eya25 with SMTP id 25so1391006eya.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AxGY5Qzy3tzz1fInvGkI1sm8v5+1WqW12htya+tnWwg=;
        b=Tu1vTACmAWhkziubIlVUFGYHhvnTlxEdaJ6hiDKBJAP0zwsRKOlvHnKoIk74Be2b4U
         whweuYm4HDrnp2nypRCz2uxLagWNBtTNd2UpYCirv9Zin1M+hNKD61kpxv8xRWCVHe2z
         M0tOHL4Mb3qDpGIFkby18roIFVAcgWYYPmmoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jeTUqmgdhMRkUs6zS3xmDNHT9GrOa8ifFKIzOgyGu+U47sdKTtEM4rV7ZmsZWouIro
         81BDWogCbxjtfhE9aaG0GVq0ROFjqKQit2C6U990KxSnz9aGJdzXP7cjpageYLufY8NY
         LaV+X/7iT2MIl7+38UkzwirEdP5YPfcMbe0m8=
Received: by 10.213.15.197 with SMTP id l5mr6433824eba.78.1279649677355;
        Tue, 20 Jul 2010 11:14:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-75-186-1-50.cinci.res.rr.com [75.186.1.50])
        by mx.google.com with ESMTPS id h41sm28296872qcz.13.2010.07.20.11.14.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 11:14:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinLOLzmA9XSDYKsKwxV1Byvp-hd82JbjuSTNWb3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151341>

I've written a patch that converted most (all?) of the "! git" to
"test_must_fail git". I'll send it as soon as I make sure I didn't
somehow break the testsuite with it.
