From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: add documentation for mailinfo.scissors and
	'--no-scissors'
Date: Fri, 11 Sep 2009 15:41:12 +0200
Message-ID: <20090911134112.GA18684@vidovic>
References: <33445216edc4c4e1976cdd81521922042955e6eb.1252626034.git.nicolas.s.dev@gmx.fr> <f63e8402656c02fc2ecdcce8a37cc1d60a61aa1d.1252628643.git.nicolas.s.dev@gmx.fr> <7veiqe0x05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 15:41:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm6NT-0006ly-SC
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 15:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZIKNlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 09:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbZIKNlR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 09:41:17 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54196 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbZIKNlR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 09:41:17 -0400
Received: by fxm17 with SMTP id 17so795861fxm.37
        for <git@vger.kernel.org>; Fri, 11 Sep 2009 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=RTnRGaMpnig3eEnKRg68zDL9jFxGJ7CZe0yjSojCq5s=;
        b=XT/I175zECBQURIkNBbBiMo4BxvE4ZslcvDElP0qehIlyoklmhB35K5dJNIbRVBlNx
         YtGwQBYIu2AKBa6DHOmQNHZBukcYyPu5MW33ap3bgz+zmpbHRPRRROVOxlqm04e3eO5Y
         qwfmCcvn0Ommgf62KrprRwXX0I0nVlqVn1PmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sZPn/G8+LgVsXyyasOB4iSRcXIce/6jCt8UBgRNYyzJkSTDZssdlPsN5QqKTOAVsL5
         sCaayLeMexqkjZ6eTn+K80ViJRXKv5hBwbjVvR92Ot/acbaiugJ0vnPMEoD39Tzn92Nj
         5KXzeeVMJJh8yk2yiInsAFzlGZPDcHH0eRzsM=
Received: by 10.86.16.9 with SMTP id 9mr2291107fgp.8.1252676479160;
        Fri, 11 Sep 2009 06:41:19 -0700 (PDT)
Received: from @ (91-164-133-105.rev.libertysurf.net [91.164.133.105])
        by mx.google.com with ESMTPS id 4sm1385853fgg.2.2009.09.11.06.41.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Sep 2009 06:41:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7veiqe0x05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128192>

[ Thank you for this review. ]

The 11/09/09, Junio C Hamano wrote:
> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> 
> > diff --git a/git-am.sh b/git-am.sh
> > index 26ffe70..f242d1a 100755
> > --- a/git-am.sh
> > +++ b/git-am.sh
> > @@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
> >  u,utf8          recode into utf8 (default)
> >  k,keep          pass -k flag to git-mailinfo
> >  c,scissors      strip everything before a scissors line
> > +no-scissors     don't obey to a scissors line (default)
> >  whitespace=     pass it through git-apply
> >  ignore-space-change pass it through git-apply
> >  ignore-whitespace pass it through git-apply
> 
> Do we want it to allow --no-no-scissors?  I do not think this hunk is
> necessary at all.

I don't understand your point here. This hunk doesn't allow
--no-no-scissors but add --no-scissors to usage of 'git am', no?

Do I miss something around $OPTIONS_SPEC?

-- 
Nicolas Sebrecht
