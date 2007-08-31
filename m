From: "Robert Newson" <robert.newson@gmail.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 17:25:57 +0100
Message-ID: <46aeb24f0708310925x62d9f92fsb2e0938f343f7aea@mail.gmail.com>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	 <7vveav21uv.fsf@gitster.siamese.dyndns.org>
	 <20070831152153.GA30745@muzzle>
	 <7vfy1z1y9u.fsf@gitster.siamese.dyndns.org>
	 <46aeb24f0708310918u29fa5d17r9878658e68702fca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:26:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9Ju-0002yI-2X
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbXHaQ0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbXHaQ0A
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:26:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19203 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965335AbXHaQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:25:59 -0400
Received: by ug-out-1314.google.com with SMTP id z38so79158ugc
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 09:25:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LtOArDSVSPwM1X8gXHb9Y4sZucsVndXxedrAhx/VbqFG+b30raci3uMdQvYdA8Rq/sy+RWgmbZ2LQQgBMUyi87xnA+htiaPiAc+uO0DhGIEPOELpkn5W3VGc/Yishfcsb5JSNbagI2MbASeHYcyRzKB7S6seVNl5XkcmsD7JIKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L/PQUqMGEle+z9fJsEahjzbkhiXTtc1TeaylUi3c3GP6A4wDw3WXMfkaa+YLBKVaosVLju25nH7rPSi3Mh/LdQZ6jZPkDtc5iBkJr5cFTPOD2yTMQ4/1Q6tYxVtsRVv7MOj9qiJFHNaZg6LCG+JAGf0P4QwHxaeSzCiphh1ipVw=
Received: by 10.78.123.5 with SMTP id v5mr1423612huc.1188577557751;
        Fri, 31 Aug 2007 09:25:57 -0700 (PDT)
Received: by 10.78.160.20 with HTTP; Fri, 31 Aug 2007 09:25:57 -0700 (PDT)
In-Reply-To: <46aeb24f0708310918u29fa5d17r9878658e68702fca@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57184>

Confirmed, if I switch 'true' to 'auto', the problem goes away. It's a
side-effect but an ugly one.

On 8/31/07, Robert Newson <robert.newson@gmail.com> wrote:
> I have these settings in ~/.gitconfig;
>
> [color]
>         branch = true
>         diff = true
>         pager = true
>         status = true
>
> not a problem in 1.5.2.4.
>
> On 8/31/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <normalperson@yhbt.net> writes:
> >
> > > This could be a sign of a bigger problem.
> > >
> > > Does git-log read .git/config and that could potentially change
> > > its default output format?  A quick scan of the docs say "no".
> >
> > "diff.color = always" could break it I would imagine...
> >
>
