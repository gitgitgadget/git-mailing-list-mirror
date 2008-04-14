From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git Wiki improvements
Date: Mon, 14 Apr 2008 03:03:21 +0200
Message-ID: <200804140303.22624.jnareb@gmail.com>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: "Pack, Dylan" <PackD@navcanada.ca>,
	"Pack, Dylan" <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 03:04:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlD7I-0006IX-DC
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 03:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbYDNBDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 21:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbYDNBDc
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 21:03:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:11622 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbYDNBDb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 21:03:31 -0400
Received: by ug-out-1314.google.com with SMTP id z38so368372ugc.16
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=TUJK+ADrG94arCExIIH3sGN8m6EXRVgcl2Sd+d5sLX8=;
        b=ilQeCksh+CoJ2mSsiLZiKu5+e/4rFM0+j3aRIm1DZ4jfbg1G9s1KGIXf1nXdnu2ljUFEKGukNKnJXFrEY06NQlmxf8AbagNwK58/LraPxKUJ/4JYroR3iBD+fQdrGfUeHXaRQKB/dnwO6WesLZ91BTJg+D7g63UJRmLSTjkVpiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oCGm+whtsOvCkNZVUpAeW42wlp0XVaxX5fw3UVhuafLG/NM4+6/HSIDSyIbkehDUZ2I1YlqETHMsOuNhtKfq+roMlnhM3T8MfuTt1cV9LwSyf8+mnAm/cfnVyHYI0+DlaTXQ+fRQYK+3IpCXuV+eDRPSHg217vB9HA7vz795ItQ=
Received: by 10.67.105.12 with SMTP id h12mr3137903ugm.12.1208135009857;
        Sun, 13 Apr 2008 18:03:29 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.221.164])
        by mx.google.com with ESMTPS id e34sm4696819ugd.17.2008.04.13.18.03.27
        (version=SSLv3 cipher=OTHER);
        Sun, 13 Apr 2008 18:03:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79446>

[Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>]

Pack, Dylan wrote:
> Jakub Narebski wrote
>> On Mon, 14 April 2008, Pack, Dylan wrote: 
>>
>>> I've noticed to that the wiki gets mixed up if I use the GUI editor.
>>> Looks like I'm going to have the syntax after all of well.
> 
>> Unfortunately Git Wiki administrator (Petr Baudis, who also maintains 
>> git homepage), doesn't have much time to spend on configuring wiki,
>> and doesn't know well MoinMoin.  The problem seems to lie in the fact
>> that Wikipedia-like (or rather MediaWiki-like) syntax provided by
>> (I guess) media4moin plugin doesn't modify GUI editing.  This affect
>> mosts macros, which in default MoinMoin syntax are written as
>> e.g. [[BR]], while Wikipedia-like syntax uses e.g. {{BR}}.
> 
> Perhaps a move to wikidot.com would work? They have an awesome set up
> for wikis. I've tried them out and they are fast and always improving
> the wiki. We could even add google adsense on the wikidot site for
> money to be put into various git projects decided on by the
> developers. Not sure how much money though a git wiki site would make.

I'm not sure if it is a good idea.  We would loose a bit control, and 
would have git homepage and git wiki in separate domains.  On the other 
hand some of admin stuff would be passed to wiki hosting site.  
Bazaar-NG, Mercurial and Monotone (and also Emacs) have their own self 
hosted wikis.

Git homepage at git.or.cz (or git-scm.org), Git Wiki at 
git.or.cz/gitwiki and free git hosting at repo.or.cz are all provided 
by Petr 'Pasky' Baudis (thanks a lot, again!).

By the way, Git Wiki initially began as a "staging ground" for contents 
which would get incorporated into Git Homepage...

-- 
Jakub Narebski
Poland
