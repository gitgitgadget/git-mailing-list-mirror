From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cmd_cherry in builtin/log.c?
Date: Wed, 8 Dec 2010 12:09:25 -0600
Message-ID: <20101208180925.GE5687@burratino>
References: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com>
 <20101207173923.GA21483@burratino>
 <AANLkTik7+WAk0mx0G7b565eCihB5SGNBDuYLdfPzq7pr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, rene.scharfe@lsrfire.ath.cx
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 19:09:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQOSV-0008Q6-K9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 19:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755823Ab0LHSJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 13:09:39 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:39631 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab0LHSJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 13:09:38 -0500
Received: by fxm18 with SMTP id 18so1380899fxm.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 10:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nswQzPhLWdXuOaHftNt3r/HMBhqgEZxN/vWAiGe5wKs=;
        b=ZBmeGdCB2f+esOeP5+JHE8aFQEIGpT78sxGjJaWzZHJmpo89wjQEItf6Fb5xD/UZYz
         V9LEkklnTDIrJd0bx20A320y8+WsKk90H1VBq+0LRfhjLPBdFWRTDwni5TKuo2cxNWet
         Zq4P7qFU79VyiX5nK+sGsMOblfOuhO5TptXU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lbZ8LsfFePbaY8ez4NhLkinhk6K1Isceet3nh8JDEteOzviQr6nzkyLP+OK51oipxM
         jRvxwzdQoS0n/g0VhP9mr4Q7sWy0LNNfTgDu43mg51EF81sL+WVOWnSUqIE6ILIPwRL0
         +vZ0AjYZqghnVSqct9iCjjzbuxshxcDismo2I=
Received: by 10.223.122.201 with SMTP id m9mr8998593far.79.1291831777087;
        Wed, 08 Dec 2010 10:09:37 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id f24sm255161fak.24.2010.12.08.10.09.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 10:09:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTik7+WAk0mx0G7b565eCihB5SGNBDuYLdfPzq7pr@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163211>

Thiago Farina wrote:

> Yup, thanks for digging into it. Now makes sense.

Mm, I was hoping for "thanks for teaching me to dig into it". :)
