From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Corruption in the repository
Date: Tue, 14 Dec 2010 03:46:01 -0600
Message-ID: <20101214094601.GA21755@burratino>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
 <AANLkTimD6+CHofhbKvBPjHpcNUNusHOCHSQe+-J1ZA4F@mail.gmail.com>
 <1292258845.25237.27680.camel@korcula.inria.fr>
 <AANLkTimgLhQMUGmC=W5wpcAvb07faw4HOzPgWXpFA4u1@mail.gmail.com>
 <1292263868.25237.27772.camel@korcula.inria.fr>
 <AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvestre Ledru <sylvestre.ledru@scilab.org>, git@vger.kernel.org,
	Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 10:46:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSRSi-0005l0-Hs
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 10:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758494Ab0LNJqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 04:46:16 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51279 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758335Ab0LNJqP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 04:46:15 -0500
Received: by ywl5 with SMTP id 5so207689ywl.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 01:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Yu6uCujJkXcbCW2UfvCuHYDUGXnIREWWSfx16P2wzq8=;
        b=mA9IE5uxBjWtOROBEd0vY8zQkdpjKDG/wfKjqpIb30IGlN+zuOuhIdo2PWnszLfYw2
         qkDd/fvVc6RWayKXhfEuY3ZX69yncP5UghKvUJML/in4EBnSgNEePbf4Fv/B7iFROXyB
         NcEJHEco6ndjqYuytiSQm1S6rUPzxCLj+qkkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=C/8Jtk+Kiyj5eADWsrkUKUDMu2TJ8/znGTmUry/UqSq/QIzYNQxjjnap9JsrpA034A
         CZu26Tp+OUxE6agvCxIbajyUJHnF0ej0Jx3e4eKRR9ssHrfuAhwomWaR1UJe76EhUFUf
         WVgZNU+kYyyXUfPnCs8b0jX0rXN24HfMl0u6U=
Received: by 10.151.107.10 with SMTP id j10mr7376509ybm.355.1292319973209;
        Tue, 14 Dec 2010 01:46:13 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id r6sm3114250yba.11.2010.12.14.01.46.10
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 01:46:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikP3CTNX_S=fAWTBVbt0OwQMLr+mq8f72OFd0j6@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163640>

Christian Couder wrote:

> When I try "git grep corrupted" on the git and gerrit sources I don't
> find anything relevant.

The error message was changed by b6c4cec (read_sha1_file(): report
correct name of packfile with a corrupt object, 2010-10-28) and
especially v1.7.3-rc0~73^2 (sha1_file: Show the the type and path to
corrupt objects, 2010-06-10).

Random guess: maybe a corrupt but redundant packed object was removed
in the course of investigation?  Sylvestre, are you still able to get
errors from the repository?  If you still have a copy of the original
corrupt version of the repository, I would be interested (to learn
something about how it got damaged in the first place).
