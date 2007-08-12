From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: syntax for checking out specific tag on a remote
Date: Sat, 11 Aug 2007 21:50:10 -0400
Message-ID: <9e4733910708111850v6e9669c3i536fba49f63d0f10@mail.gmail.com>
References: <9e4733910708111833r6588557al1876bd6aaae38204@mail.gmail.com>
	 <7v1we9leb9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:50:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2bA-0003m2-6v
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbXHLBuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756691AbXHLBuM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:50:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:22742 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249AbXHLBuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:50:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1383518wah
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 18:50:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ogtSbQ9d06QA1f2lHTS3sVT2P9OnWIguCZngpYz7BCPVTaHLMrW1Ui+nqJ35t4UP8k/gsn64w/7d032MG3HLaaYaZvHnwaDLAKdmxS7nHKDc5VueVompt70kRqcRVuSrLdmKhZGTnncu8EzGstXe0fFTEPowpBxT/2AXgEXloDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GqhymWiHw1In2H6YvHa5+sYak9+QuF4g8D+9BC5m5rebnI4V2VqLN1dqEa2YfHK10IEEDqCEkY7Lqqh6u/Q821WO39AETTCCK9zPkinfY2PjE+cPE3f3JqLzCh0S2HIhi5Aw960TDbjGpHQMrKoQjqdjTaSlE9lFjjceb67Q6Fg=
Received: by 10.114.202.15 with SMTP id z15mr1285667waf.1186883410247;
        Sat, 11 Aug 2007 18:50:10 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Sat, 11 Aug 2007 18:50:10 -0700 (PDT)
In-Reply-To: <7v1we9leb9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55658>

On 8/11/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > What's the syntax for checking out a specific tag on a remote?
>
> This depends on where you stored the tags you obtained from the
> remote.  By default, "git fetch --tags" would store the tags in
> a flat namespace; there is no "remote tag" namespace.

I've been storing unrelated trees in the same git db. It never
occurred to me that there was a single tag name space. So if two of my
remotes both make a tag TEST then last one fetched will win? Are
"remote tag" namespaces planned for the future?


>
> Hence you would say:
>
>         git checkout v2.6.19
>
> to get a detached HEAD at v2.6.19, or if you want to start a
> branch from there,
>
>         git checkout -b my19 v2.6.19
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
