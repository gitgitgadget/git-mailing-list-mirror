From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: clone --bare vs push
Date: Mon, 3 Jan 2011 22:58:39 -0600
Message-ID: <20110104045839.GA8225@burratino>
References: <AANLkTi=+cRqD_CDFyaYj8uWOxUA1+5Dgr_pv1guaaT40@mail.gmail.com>
 <AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com>
 <ifu8d2$t61$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neal Kreitzinger <neal@rsss.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Levend Sayar <levendsayar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 05:59:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZyzD-0006bM-44
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 05:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1ADE6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 23:58:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50902 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1ADE6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 23:58:53 -0500
Received: by yxt3 with SMTP id 3so5502722yxt.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 20:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=LA4mhsJFIuU3KWICPSYdutKELy5+um5n6TE8gGNUgys=;
        b=BdaDjR+kuYncoDt/72/SyJhNTOqzp5zCoPICmep+/uzo/JKKCbkZcfi5cKd+yKroNc
         6SioX/xVies022qG8S+Q91P2V8UsTuLui1vhIx6p/7QA3w8QCTSNOAq9OTCnddM+zpxC
         ezZS3GYwqJdgZLsBHNtBEJvbSSkx+2e/ddmiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iISoA44lirk0k8b+rtUBBSyQgLkTlyzuy0UmOepA+HY4bNPSOAcMI6bCFzRDRztBBX
         N9kJvfNkdwaXi4JlDo4zW6OnDTalcTnpszv6Ddzi/ZjNrkgE9crOyTjT9qMM/QdKT77/
         iXTp1iGcHO0QkGM1vakWf4CwQmjQ0oq0abZnc=
Received: by 10.100.163.3 with SMTP id l3mr12848446ane.9.1294117132710;
        Mon, 03 Jan 2011 20:58:52 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id b19sm19556009ana.7.2011.01.03.20.58.50
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 20:58:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ifu8d2$t61$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164474>

Neal Kreitzinger wrote:

> you can also use the file:// url format to create a complete copy and not 
> use hardlinks.  see git-clone manpage.
> 
> e.g. git clone --bare file:///fullpathto/X y.git

Thanks, that's useful; cc-ing Levend.

[Side note: I wrote in the past:

| In traditional newsgroups it seems to be most common to just reply to
| the author by mail or follow-up to the group, so I wouldn't feel too
| bad.

but probably that was unclear of me.  The convention on _this_ list[1] is
to reply to all participants in a thread, so new participants do not
need to subscribe if they don't want to.  Thunderbird (e.g.) seems to
be good at doing that for what it's worth.]

[1] at least as I perceive it; please feel free to correct me if I
have misunderstood
