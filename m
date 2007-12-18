From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: RE: git with custom diff for commits
Date: Tue, 18 Dec 2007 12:48:37 -0800
Message-ID: <000101c841b7$5f1d1060$762a14ac@na.acco.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com><Pine.LNX.4.64.0712172300510.9446@racer.site><vpq1w9kaphg.fsf@bauges.imag.fr><Pine.LNX.4.64.0712172310090.9446@racer.site><7vbq8o6gxw.fsf@gitster.siamese.dyndns.org><vpqk5ncz8fn.fsf@bauges.imag.fr><7vodco1him.fsf@gitster.siamese.dyndns.org><000001c841b5$89fcef00$762a14ac@na.acco.com> <7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Matthieu Moy'" <Matthieu.Moy@imag.fr>,
	"'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jLy-00045U-TF
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbXLRUr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbXLRUr0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:47:26 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:31438 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbXLRUrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:47:25 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2392918rvb.1
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        bh=rikiZg7h0ebmdWNz2lGFwDORAndl9g466H/GxTQHLHQ=;
        b=RqXEaB4MIwGTNhXG/O59oc0Uc1YdgRp3DkHij4sweT6UtTfLpRivUl/8xvX8DDqISne0ucGwzAOqQlctLz/YySdgtnHicET0+0OGRY8FUH0HFu3D9mhIDJfSRleD2Ln6S/PYBK982l54FQFp4w32uBt7aNbfEGh5b+U2/4bQoyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:thread-index:x-mimeole;
        b=XfNXKiOgV0IqhdU7V8UKOVSLGv46jrHSHb6ZnDCCS3org3UfZ7Tjkff4NiUF//9ckpMPWa8jB7nJfSY5qds2T29V66d8PD26fLA+WsWW1JWXCiTY9GBKNcZ0TaSt5o1rJqVHWHrEmWqJYY6wEBL4Qw5axn3/A0lQ6nwNLDjKhbk=
Received: by 10.140.125.4 with SMTP id x4mr5281010rvc.229.1198010844625;
        Tue, 18 Dec 2007 12:47:24 -0800 (PST)
Received: from BURGXGUTIERNB ( [63.87.154.251])
        by mx.google.com with ESMTPS id f57sm39134835pyh.2007.12.18.12.47.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 18 Dec 2007 12:47:24 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
Thread-Index: AchBtjzNKv39sW7LQ5uxIH+AdxhcUAAALjCA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68810>


Yes, but wouldn't it be slick to actually teach git's internal diff to do
things like GNU diff can, like the ignore option -I, case insensitivity,
etc. I thought that's what the external diff capability is for, but it is
not so.

Gerald.

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Sent: Tuesday, December 18, 2007 12:40 PM
> To: Gerald Gutierrez
> Cc: 'Junio C Hamano'; 'Matthieu Moy'; 'Johannes Schindelin'; 
> git@vger.kernel.org
> Subject: Re: git with custom diff for commits
> 
> "Gerald Gutierrez" <ggmlfs@gmail.com> writes:
> 
> > I ended up doing the following, which sounds similar to the above. 
> > Instead of doing mysqldump into data.sql, it goes into data.sql.2 
> > which I compare with the checked in data.sql using "diff -I 
> <timestamp 
> > RE>". If there are no differences, I delete data.sql.2. If 
> there are 
> > differences, I move
> > data.sql.2 into data.sql and check in. Perhaps not as elegant but 
> > certainly works.
> 
> Heh, that's essentially how automated html/man branches are 
> managed ;-)
