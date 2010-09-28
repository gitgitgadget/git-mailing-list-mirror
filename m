From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Mon, 27 Sep 2010 19:24:42 -0500
Message-ID: <20100928002442.GA2699@burratino>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org>
 <1285202724-52474-1-git-send-email-kevin@sb.org>
 <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
 <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org>
 <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
 <FFDB2371-6C96-472C-A650-412546636450@sb.org>
 <20100927235355.GG11957@burratino>
 <385B97D7-03F5-4698-A659-15D5D1FA939B@sb.org>
 <20100928000837.GH11957@burratino>
 <7FEED963-13E1-4A77-959A-FFD06669ED13@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 02:28:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0O30-0001mo-Qn
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 02:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab0I1A1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 20:27:45 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45702 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760043Ab0I1A1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 20:27:44 -0400
Received: by qyk36 with SMTP id 36so5881059qyk.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 17:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uXrT94k2ze0TWmXLTgUqJuvYq30kG60T/TP1ueT7YyU=;
        b=gzx8G5h2R/bC1BdZsHnDKnQvsNshXqoJ3SPXmuchvEovLyJt8D7cLyiKJUBrYr5ibB
         E1oM8YgjtEhCniHl3ei1IaDwlkD16hTLuSi10sOdFXwffL+p9XYPFnLqOW/YzjtOj/l4
         zRwKcCKXDgYb6cZCdu3TZvbffXX2eN1powDtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i39+7fWMomqF2sWGrYxVaq2R3pcgMnDmYpMYHdxfSp0PBTQDele+kTNOChsIgM1q7P
         6P1al+TlXdizS9UOpzImOTN/b1b/sn6IpKoiM4s/R5IagvdWBdnQvFKHN5qoqotZOHuj
         UuRh+pIAA99Qp4K3Vm4jjpzsUJBCcsB6sXBOk=
Received: by 10.220.124.196 with SMTP id v4mr903774vcr.183.1285633662929;
        Mon, 27 Sep 2010 17:27:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id w31sm4259221vbs.5.2010.09.27.17.27.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 17:27:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7FEED963-13E1-4A77-959A-FFD06669ED13@sb.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157382>

Kevin Ballard wrote:

> I looked at the existing ones. I am unable to find any tests that
> actually test setting the rename/copy score to anything other than
> the default

Yep, a quick grep shows there is none.  I think the precise meaning
of the scores is subject to change, but a test for 1% should be
reliable enough. :)  (Or 0%, except that that is a magic number
with the current code.)

I can look into it tomorrow if no one else gets around to it before
then.

'night,
Jonathan
