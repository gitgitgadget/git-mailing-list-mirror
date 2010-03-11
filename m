From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-rebase -i prunes commits with empty commit-message
Date: Thu, 11 Mar 2010 14:46:15 +0100
Message-ID: <40aa078e1003110546k1bb024d9rbc7ebe24b0112fe2@mail.gmail.com>
References: <40aa078e1003081207u20046916yda5a62d44ce7a401@mail.gmail.com>
	 <4B979AEF.5010201@alum.mit.edu>
	 <40aa078e1003100534j189eef5kd60855f80e9dd626@mail.gmail.com>
	 <40aa078e1003110514n3bdf12ecq6b3a77e0312e742d@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Michal Vitecek <fuf@mageo.cz>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 14:46:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npiie-00064E-3q
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab0CKNqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 08:46:19 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:41949 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757923Ab0CKNqR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:46:17 -0500
Received: by wwb39 with SMTP id 39so26310wwb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=qi+6cp6X/NBx61bY4D4FHxduJ7yevUCQ4ootExZf/O8=;
        b=oc17ld+LGWu5XLLAJqe99bLMmg1ZBLEqBLux5CY/qRcdVe4OwYxMfhOuwTuIq2pOfZ
         Rfbl/tYsBl9xgoXzGQSdNxxDV1QzwHxrlJE/zmrVIIFBZukhBI4br2ncqRrnLkvoLkvE
         phHhnqVQyGnCKtOVsmhMKMODHGUqCj9LCnryw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=te2nhELdLrSHBF3uYq4b/RC6cBhP6ZB4Gc3o4ZBdpvJ7zovK0tBekGQ0/Y9tfZU0TT
         dMrq+P/F603P1cDHYUeSVzFifgJpN4K4sUbt/6SOF2VLcCiL0uyWEnZbH0jPLkVXMILV
         xY1AR/l6uE2x3K1nz1n/cJzmc0uEBQs997vGc=
Received: by 10.216.165.70 with SMTP id d48mr2064149wel.160.1268315175992; 
	Thu, 11 Mar 2010 05:46:15 -0800 (PST)
In-Reply-To: <40aa078e1003110514n3bdf12ecq6b3a77e0312e742d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141979>

On Thu, Mar 11, 2010 at 2:14 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> Anyway, the following patch seems to fix the problem for me, but I'm
> not very confident that it doesn't break whatever Michal was trying to
> address.
>

...or even the test-suite. I should have tested that before posting
this, sorry for the noise. Back to the drawing-board.

-- 
Erik "kusma" Faye-Lund
