From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Wed, 3 Nov 2010 08:22:02 -0400
Message-ID: <AANLkTin2hC8fk-5tAwVTjT=6AivQU2k+YcHczS6WgpZu@mail.gmail.com>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
	<201011030424.33093.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	trast@student.ethz.ch
To: Christian Couder <chriscool@tuxfamily.org>,
	Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Wed Nov 03 13:22:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDcLz-0005VD-N4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 13:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab0KCMWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 08:22:05 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64852 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab0KCMWE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 08:22:04 -0400
Received: by vws13 with SMTP id 13so1108315vws.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Psa1ezLlyO8I6IhJ3LDsy9MNe2sGVGjfJIMZlOvJczk=;
        b=HCbW2jwcjZxMPuzVbRqzxpG1GrJyt1h0mQx9QKD2Iz67wl8zlWkdloDobnx/2V8QUL
         /FqpB1bb7OCCl0yrRq0C9gEDLjK2T0+/SFHr/LG0nvp+tmsvnssk6JXpHa4E1d9kvL+8
         k+QEdys/+buN/ElSNfY+lMe2m8Erh/MJoIeuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SxNykcOq+f4inUpxL73U6px2WeJQDOwKTltnRNK7pZecnI2Bkm35Vyhw1SutYa7QnC
         PvAgs5dkndOFWV43b6DWNV3aPjwMQ+gvlvr1PN9YNdt5SU7UB5QSXzzAGS/UIBY8gPy+
         DUHnWgoI8SZKNdu4Le6rucMtzEqkHv+M4bDXk=
Received: by 10.224.69.200 with SMTP id a8mr1578750qaj.190.1288786922614; Wed,
 03 Nov 2010 05:22:02 -0700 (PDT)
Received: by 10.224.20.82 with HTTP; Wed, 3 Nov 2010 05:22:02 -0700 (PDT)
In-Reply-To: <201011030424.33093.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160596>

Perfect! I liked Johannes's proposal and started working on it
yesterday. It's looking good so far.

/Martin
