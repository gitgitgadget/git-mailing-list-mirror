From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: checkout without touching HEAD
Date: Fri, 28 Dec 2007 11:48:57 +1300
Message-ID: <46a038f90712271448p7f069f06pcd52bf90941b71eb@mail.gmail.com>
References: <46a038f90712271422o7a831c09s463735ec41356b59@mail.gmail.com>
	 <7vsl1nix0x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 23:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J81Xh-0003z6-L0
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbXL0WtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752897AbXL0WtA
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:49:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:41606 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbXL0Ws7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:48:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1721647ugc.16
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=g5U7eswvJB+ZajJdR6auMsHYcIa7sfJGBLQ1GTS2TRA=;
        b=BkLj9sy8Kzx77Z16hPqZvbm1r8QaL2GPym49/Sw9Cb5YzAgKWD/jdue/x0ElXPVpzY5NG5wMek6+i8RLx60fTf0xEC3Q0bJtmp+ieWjTNqFRRCvFiLym+WtQGX3wzboiccG50sVthYWZ0+Vr99kulaJyw+vB/YCB33EEneiUaQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wxa29TWu09yRgb11ghumbH8jG5t6pK6GdZI3Z5ysoVSGJT1iN6ezMatxRZdaSBlC+BlR3pMRu5ONRs8A3m/AttRwUeS+/QZ0rUTtzk2YqosiLVfrznVmnsrIEevEkx8A0pCSzjjNPp613hPhBgH1LBXSNZmu3555rtwAqKoLFAE=
Received: by 10.67.115.15 with SMTP id s15mr3156540ugm.63.1198795737440;
        Thu, 27 Dec 2007 14:48:57 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Thu, 27 Dec 2007 14:48:57 -0800 (PST)
In-Reply-To: <7vsl1nix0x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69270>

On Dec 28, 2007 11:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> git read-tree -m -u HEAD $treeish

Thanks! Trying it now...

(I'm combining git with PostgreSQL's PITR snapshot+xlog technique for
an automated, reasonable-disk-footprint "rewind my webapp to any
arbitrary point in time in the last X days" facility, mainly for
edit-heavy web apps like Moodle. So far, it's looking good ;-) --
could be a killer feature for the LAPP platform... )



m
