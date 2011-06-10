From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for /etc/gitweb.conf (WIP)
Date: Fri, 10 Jun 2011 19:16:47 +0200
Message-ID: <201106101916.48373.jnareb@gmail.com>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com> <20110606221236.GD30588@elie> <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Jun 10 19:17:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV5KT-0004CQ-HO
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 19:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699Ab1FJRRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 13:17:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59110 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889Ab1FJRQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 13:16:57 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so1734939fxm.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=vCuB3OmrwQi0Bqo+4AxHDIbEGyjPGix+6Mg8pYbVYFw=;
        b=Evgi6WhNeLwPKwHttN3Tx574soUm/QogOKB/XwB7dmDsLNsJwdcGRtRNGf9J5oIjg2
         mpq3f2cRC5DbKu/htyvtHHnUotB06S8CVSqmZW77yN9HgzB/WlCkFl8pcsxhXF17cPTG
         fLOy1+kF4ipFa90FyCRVNWMhnQr3YOPCgLCZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ws3tK3brm0CaRvBZq5D67B1+oxCIW5LyV3PFm3BfPMTZKZVU8Jx1B7n9pM00PfDG8M
         ifLBSOa1jDH6xoViiRDh+N12QYJLsXPE1vsNeqZk9/GQSFT5/vtKXn7Vg6rIIKORJyVJ
         XaS3h6ML92SRScbCmhoc1KMt297rxubIbKfSw=
Received: by 10.223.2.205 with SMTP id 13mr1357214fak.138.1307726216819;
        Fri, 10 Jun 2011 10:16:56 -0700 (PDT)
Received: from [192.168.1.15] (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id l26sm1138110fah.14.2011.06.10.10.16.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 10:16:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175612>

On Tue, 7 Jun 2011, Drew Northup wrote:
> On Mon, 2011-06-06 at 17:12 -0500, Jonathan Nieder wrote:
> > Jakub Narebski wrote:
> 
> 
> > > +SYNOPSIS
> > > +--------
> > > +[verse]
> > > +'/etc/gitweb.conf'
> > > +'$GITWEBDIR/gitweb_config.perl'
> > 
> > Micronit: a single line like
> > 
> > 	SYNOPSIS
> > 	--------
> > 	$GITWEBDIR/gitweb_config.perl, /etc/gitweb.conf
> > 
> > might fit better with the pattern established by gitattributes(5) and
> > its kin.
> 
> I thought that's how I had originally put it.

I am very sorry.  The fault is all mine, not Drew.  This is my (wrong)
change.

When working on gitweb.txt manpage, and actually moving contents from
gitweb's README and INSTALL, I have also changed this patch to also
remove duplicated contents.  And I couldn't resist the temptation
to bring further changes... though I should have probably left those
for a separate commit, if still claiming this as of Drew's authorship.


[...]

> > Stopping here.  Will resume later but since having something is better
> > than nothing, I am tempted to say this should be applied e.g. to
> > "next" so people can start using it right away and finding/fixing
> > documentation bugs.
> 
> And so am I [stopping], I suppose. I have had work to do for the past
> few weeks that really caused me to NEED my weekends for things other
> than writing code and flossing documentation. Unless I am needed for
> something I'm going to just let this live or die on it's own for now, as
> I cannot keep up with this pace of patching right now. (That was in
> large part the whole point of my flagging this as WIP.)

Should I keep working on it then?

-- 
Jakub Narebski
Poland
