From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: git-rebase and reflog
Date: Thu, 1 May 2008 01:38:53 +0800
Message-ID: <46dff0320804301038l283544b9t8c9e0649fbced65e@mail.gmail.com>
References: <46dff0320804300904i3402b5e7wf827f6759bc52901@mail.gmail.com>
	 <m3d4o7nvt2.fsf@localhost.localdomain>
	 <46dff0320804300956x7e4f34efle39f6cad2e98a2de@mail.gmail.com>
	 <4818A6CA.5000409@nrlssc.navy.mil>
	 <46dff0320804301013o17da30cg1fd847beca94ff58@mail.gmail.com>
	 <7v7ief1c27.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:39:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrGHQ-0001AH-P9
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759512AbYD3Ri4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758708AbYD3Ri4
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:38:56 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:3597 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbYD3Riy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:38:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so128719and.103
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=VoyZBYPkKhqumhDNdGZWGSysQxjPBNf1OXQ6g9dLt+U=;
        b=s0oOqnHtvjA+mMsCcauLSY+gYA2iv1LIkpwvBM3w+ROh0kVm/VCamNmes6V9N603/h3VFe5Ka/Okmg9ViEZT7laIgkq56aDdB5fYLIKaTztxy4uR3b9XcT2AAlYadsizIaVhfdTBJLIzMVMkYZ+8VCLkVQ69b0mFTjTWJQIhy/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ds2Pkwa+TjewVrsn1R1ikwKSMvF2YkKcXNlWZcMlYpYIMZuM76UiRuMDZnoppiTFkjJzn0Tl/wrMEPycbvRbQZDRSJm55qKUbCsQLv4qGqfIMe/t/PTqXPxtUiYOkzxpTWkVwnfCu3ZsIZRlxO0d5xOcdrs0BJC6Tq01hpjfRDY=
Received: by 10.100.33.11 with SMTP id g11mr1706469ang.51.1209577133584;
        Wed, 30 Apr 2008 10:38:53 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 30 Apr 2008 10:38:53 -0700 (PDT)
In-Reply-To: <7v7ief1c27.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80859>

On Thu, May 1, 2008 at 1:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>
> > However, i still think the intemediate commits of git-rebase needn't
>  > go into HEAD's reflog because it's totally useless.
>
>  Actually I use it from time to time when I need to compare intermediate
>  steps of _previous_ run of the same rebase while rebasing, if the current
>  run needs to resolve conflicts (may be the same conflict, may be a
>  different conflict, depending on what bases are used for the current run
>  and the previous run).

OK, i'm wrong, it is a useful case.



-- 
Ping Yin
