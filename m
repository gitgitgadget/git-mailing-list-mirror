From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v3 1/5] pretty: add conditional %C?colorname
 placeholders
Date: Sun, 02 May 2010 10:31:52 +0100
Message-ID: <1272792712.4258.20.camel@walleee>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
	 <1272656128-2002-2-git-send-email-wmpalmer@gmail.com>
	 <7vvdb7yp1u.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, raa.lkml@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 11:34:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8VZG-0004JZ-VS
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 11:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab0EBJb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 05:31:57 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:42246 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab0EBJb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 05:31:56 -0400
Received: by wwb34 with SMTP id 34so1061032wwb.19
        for <git@vger.kernel.org>; Sun, 02 May 2010 02:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=udsBqbDgqzByJ3IokzdOKD4k9JX7n0/YN8hVqgFOFoc=;
        b=GATbOSnRFcJNuO+XLGaj/KWrF3jFPjx1zsuQE0MFoH27PnM1V8iSCpLYyEGXqA6Eu8
         aBruoVEUAcOHiKvPM2+vaoZ5jywfI1TOVa8vdVFHjBvwbvczdOFiQTMhKwHpX19NXy2I
         RneAnzkHLNfQaIm7zf0b0Lomv5vFKAvsH6W2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=H5IFuJDEXGCOPW+8p4jGi9QDVyOtX4+l0tSJ2kGT+Ez0N2qffAWi6WkW5glidbPQUe
         JVCpWI7Ug6rCs0WzoSo5VwepKKul9eKlhmisNYzrolwhmKDhGfzO9r90tVWmLKxO3j8U
         GKS18D/jx90E+cvzbri2vc6BilDGNPRQo/Aj0=
Received: by 10.216.91.12 with SMTP id g12mr5330641wef.77.1272792715026;
        Sun, 02 May 2010 02:31:55 -0700 (PDT)
Received: from [192.168.0.4] (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm31668684wbs.4.2010.05.02.02.31.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 02:31:54 -0700 (PDT)
In-Reply-To: <7vvdb7yp1u.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146154>

On Sat, 2010-05-01 at 20:12 -0700, Junio C Hamano wrote:
> Will Palmer <wmpalmer@gmail.com> writes:
> > +# Released into Public Domain by Will Palmer 2010
> > +#
> 
> Hmm...

I saw the note that a copyright notice should be included at the top of
each test. Personally, while I like the GPL for code for example,
claiming copyright protection on a test script seems counter-productive.
If it could cause problems / make it harder to accept other
contributions, though, I'll change it to the standard boilerplate.

-- 
-- Will
