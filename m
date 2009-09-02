From: bill lam <cbill.lam@gmail.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Wed, 2 Sep 2009 08:39:40 +0800
Message-ID: <20090902003940.GA23954@debian.b2j>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org>
 <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 02:40:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MidtI-0006QP-MX
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 02:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbZIBAjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 20:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbZIBAjv
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 20:39:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:32704 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZIBAju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 20:39:50 -0400
Received: by wa-out-1112.google.com with SMTP id j5so70927wah.21
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 17:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=jhO2/rOb0q8736ZFfrxjqlJIob5W+MZz7TFj4WniUIQ=;
        b=HEW+i7JYWuVrrmRlgc7XbNeOJaigGms8Tq6KUdHLAI5An7Ah589bHox1t4AQIupRuh
         V91cYl4zZWJKPuTdhucHfh8UoUIq8lncDMHkwTdKuCN5oC9h2a4MbnYHgsB9Ii0f5TmB
         BuOM9YzPdDFN365kRcW54QVMcXxZsM4HOY1rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Hqtwh+wqmGmDDCiTDMtD2yuBjazrXJYBreLXW/7Fl70qc/rF6tcaaMRlwtJwVnnKht
         8Ixh41SKxXsu5KZJq1K+4z1xvAvCKaxb2xgxjWsfwFoHbwNy+hqZR4AkKFB+nrk5sL95
         7HkD8Yc66M8YRzgI+e0rA3eJOiRV3QR1vbN+I=
Received: by 10.114.105.20 with SMTP id d20mr5416437wac.32.1251851991825;
        Tue, 01 Sep 2009 17:39:51 -0700 (PDT)
Received: from localhost (n219078080082.netvigator.com [219.78.80.82])
        by mx.google.com with ESMTPS id 22sm2338280pzk.2.2009.09.01.17.39.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 17:39:50 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127571>

On Tue, 01 Sep 2009, Junio C Hamano wrote:
> Sadly, "keep related things together" and "as close to the bottom as
> possible" are not quite compatible, and we can pick one or the other, but
> not both.
> 
> If I were to pick the middle ground, I would probably move it immediately
> after the call to wt_status_print_changed(), with "keeping related things
> together" as the primary justification.  It would be an incidental benefit
> that it moves the part slightly closer to the bottom and gives it a better
> chance of staying on the screen.

I can only speak of my personal experience that during rebase -i,
there is no (or very few) untracked files in the list so that the
sequence  "modified, unmerged, untracked" is also a good alternative.

(I hope the mail-followup-to is correct this time)

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
