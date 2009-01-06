From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git documentation
Date: Mon, 05 Jan 2009 17:07:09 -0800 (PST)
Message-ID: <m33afxb5tw.fsf@localhost.localdomain>
References: <alpine.DEB.1.10.0901051745280.28514@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Alexey Mahotkin" <squadette@gmail.com>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Tue Jan 06 02:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK0RJ-0007r7-V0
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 02:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZAFBHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 20:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbZAFBHQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 20:07:16 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:63099 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbZAFBHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 20:07:14 -0500
Received: by ey-out-2122.google.com with SMTP id 22so892238eye.37
        for <git@vger.kernel.org>; Mon, 05 Jan 2009 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=lKlIVxBHGr8ofvFlq9As0X38ZjFD64dQ8rE9RlOFxKU=;
        b=YLWbO7QByRNRQD2iBApDy7i/rtd+301XaUX8zboFI33cBWlYOCqqZFt/pCEplg5JjJ
         lKPmAqZbNosiSZG2qKc7AZNfl8ottG6ZtGo0jEl5unmA7HcMgAbaCMT4YCEP8a3vRo7c
         2lHdHcKF2sGn86dQlIR1BXQmOvWFkaNgp/qn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=QQOY6bVodS3lOFa9hhXa0aLmDGAzEL3fb0f+HxoRCNSYA1DzrILbuS4XmN8ndN1i+4
         KBLGcv2h2GyeXKPI1SvReKLfQ7WbRNKvMkH9gvtKnotZEO3Lgd7576fMBTRiHwwmdRgy
         CJiTq4w8LEewxyhlXjQbz7/wExZaadPC4ZJd0=
Received: by 10.210.127.10 with SMTP id z10mr1832966ebc.85.1231204031105;
        Mon, 05 Jan 2009 17:07:11 -0800 (PST)
Received: from localhost.localdomain (abvs145.neoplus.adsl.tpnet.pl [83.8.216.145])
        by mx.google.com with ESMTPS id 10sm69100eyd.16.2009.01.05.17.07.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Jan 2009 17:07:09 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n061790f008833;
	Tue, 6 Jan 2009 02:07:10 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n06177Ls008830;
	Tue, 6 Jan 2009 02:07:07 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.10.0901051745280.28514@asgard.lang.hm>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104613>

David Lang <david@lang.hm> writes:

> On lwn there is a comment (under the GNOME survey topic)
> http://lwn.net/Articles/313435/
> 
> The Shlomi Fish "Better SCM" site for example is very clear that Git
> won't do a merge across a rename. It even has a citation for this
> claim. But as a Git user who has actually done a merge across a rename
> I know it works just fine, and anyone familiar with Git's internals
> will guess immediately why. Yet probably there is no line of
> documentation on the Git site or elsewhere that I can quote to justify
> adding a "Yes" to the comparison.

I have tried to add info about Git to Better SCM quite a long time
ago; it was finally added by (IIRC) Alexey Mahotkin for
http://versioncontrolblog.com and sent for inclusion in Better SCM to
Shlomi Fish.

Unfortunately it contains some factual errors. I have sent corrections
to Alexey, but didn't finish it:
  "Git at Better SCM Initiative comparison of VCS (long)"
  http://article.gmane.org/gmane.comp.version-control.git/97253
(see also other posts in this thread, and other posts with the same,
or similar, subject on git mailing list).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
