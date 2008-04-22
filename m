From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/7] git-submodule: Extract absolute_url & move absolute url logic to module_clone
Date: Tue, 22 Apr 2008 17:09:10 +0800
Message-ID: <46dff0320804220209n590a0684x876270c7b1c0c2d@mail.gmail.com>
References: <1208355577-8734-1-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-2-git-send-email-pkufranky@gmail.com>
	 <1208355577-8734-3-git-send-email-pkufranky@gmail.com>
	 <7v3ape5sip.fsf@gitster.siamese.dyndns.org>
	 <46dff0320804212350t647492b2o649ddc40cfe43d6@mail.gmail.com>
	 <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:10:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoEVl-0005xt-Ag
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001AbYDVJJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 05:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757064AbYDVJJN
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:09:13 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:19198 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762367AbYDVJJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:09:11 -0400
Received: by an-out-0708.google.com with SMTP id d31so579359and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 02:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=AWrkv8+aj11hEpOjRO3bsOdpyK19uTitHhTD7I2NHMM=;
        b=BGS/mHUKLtCvBZVCxDdRB1pn1Q28mQzqfagTnNdHV+f9rTd+OBb+UiMc5MGWegSauYr8C/C8kXJ1WmmJqs4tWfTMUJEahHu2+QgQvhiGHt8fZx4tey/CUxgLkFWxyscJGIRmPZo5ha0NBjhJrSqdrhCNQYDJCHXkIp/SvIVw8mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JHqncY2ejkso7fiBSTBF4OhtF+w56B6txdMoJhIcfFakt5+5tjp+/jwhZsnyKy/EXPxE4bHcNoFpt9CyO6pXDw+y41zUQc+mc+oo5H6iVazTXqdHdku1fWIk92/TQTESKdEM4AZhkL4wMTH0e2d7ZOTxoNavu1+pgol/QiEArUI=
Received: by 10.100.251.13 with SMTP id y13mr14229966anh.131.1208855350985;
        Tue, 22 Apr 2008 02:09:10 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 02:09:10 -0700 (PDT)
In-Reply-To: <7v3ape2ufs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80084>

On Tue, Apr 22, 2008 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>
> > I just want to unify the behaviour of handling relative url.
>  >
>  > 'git submodule add'  treats './foo' and 'foo' as different urls. The
>  > 1st one is relative to remote.origin.url, while the 2nd one is
>  > relative the current directory. I think this kind of behaviour is
>  > better for submodules, so i unify the handling of relative urls as
>  > this.
>  >
>  > With this kind of behaviour, i can set 'submodule.foo.url=./foo' in
>  > .gitmodules or $GIT_DIR/config. And when remote.origin.url changes, i
>  > have not to change submodule.foo.url if the super project and
>  > submodule foo are always located on the same central host.
>
>  Please have that kind of justification in the proposed commit log message.
>  When these changes are made into history, people cannot ask you questions
>  like I did and expect the history to produce such answer on demand ;-)
>

OK, i'll resend this patch tonight.

-- 
Ping Yin
