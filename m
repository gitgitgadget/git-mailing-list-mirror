From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: PATCH/RFC] gitweb.js: Workaround for IE8 bug
Date: Tue, 08 Dec 2009 13:56:22 -0800
Message-ID: <1260309382.5658.41.camel@swboyd-laptop>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
	 <1260147860.1579.47.camel@swboyd-laptop>
	 <1260148741.1579.50.camel@swboyd-laptop>
	 <200912081729.11890.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 22:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI83L-00039y-25
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 22:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966519AbZLHV4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966382AbZLHV4T
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 16:56:19 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41590 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966516AbZLHV4R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 16:56:17 -0500
Received: by mail-pz0-f171.google.com with SMTP id 1so2467070pzk.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=7dZ3wQi1gAtu0PUmK/8iNciEQFrcutyO0afVDomfcBk=;
        b=gLwoP7aY7Sa9tilQCmnP9VJeAD916K9xw+sDJxKcmA2M+53QrxZY0jjXfixtoXpHSp
         a6ns7MeoU1xl4Gv7dE7z+Iuiu6rVnolZlBH+QBiADxs0nUfla8upE1lHQHNNumryr8RM
         BEbI8QpzM6HnsFow/rMltZru6/mOT7PvjYW6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=K3FjpOjIfh1vlTg+KpZX4k3ntsIXiW+dS3xgkCudWNL12UGfC/Sg3sjzoQCgFrh6lR
         08TSgouqQp+1EMBnK8A86KK8MZKJOY2pMN3sFBYDIEol10755SXD4QOJBZ8DTVF1J2SA
         tzeYZcjRtYUMGNgdqfVYmKHFdDgCHuPJTRDgE=
Received: by 10.115.113.14 with SMTP id q14mr16382534wam.178.1260309384605;
        Tue, 08 Dec 2009 13:56:24 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 22sm6304366pzk.14.2009.12.08.13.56.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 13:56:23 -0800 (PST)
In-Reply-To: <200912081729.11890.jnareb@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134914>

On Tue, 2009-12-08 at 17:29 +0100, Jakub Narebski wrote: 
> 
> Does the following fixes the issue for IE8 for you (it works for me)?
> 

Yes, there is no longer an error but IE8 still locks up and takes about
30 seconds. It doesn't seem to be any more responsive. Isn't putting the
error in a try-catch just papering over the issue?
