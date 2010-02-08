From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Die if there are parsing errors in config file
Date: Mon, 8 Feb 2010 09:48:26 +0100
Message-ID: <201002080948.27094.jnareb@gmail.com>
References: <20100207093744.29846.6468.stgit@localhost.localdomain> <4B6E9BBB.4000904@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 09:48:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NePIT-0006n5-Im
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 09:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602Ab0BHIsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 03:48:40 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:64346 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0BHIsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 03:48:39 -0500
Received: by bwz23 with SMTP id 23so892533bwz.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 00:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xLBr7T21lz84m1KDC8BpJEzDJjtlGvujNb1cdanJZAM=;
        b=MZKZ5puO2wURrVaFgDlmZltbvtHL1jYysFJAxWLONwtXn2eyx2VUbhqAuvbFLoee2e
         pQRt+wdhhlHYi6fvNR6ofCHOq2n5jje2PPzq8+HL7bvWnGffVgMhpr8Tb+HYnuzJIXBJ
         YobP0qGotirE56lNE5dWZpAGx6fFn1mIG40g0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=igHW0W2olc0ylUnXcHTtGMPlEdFelVXPs7LdhNtD9huk2S9hJYBpbdARE3BigGQtdi
         ikDYF3ahF7St3NfJG58UlzYkP9myZkIWsUil+fPCTysZFR/a1QUabMQgqYzQ5VwRo0os
         DbLOaye76jU4M45BGNoVgpZRPHwC/DIKM8wfU=
Received: by 10.204.5.91 with SMTP id 27mr2132391bku.14.1265618918123;
        Mon, 08 Feb 2010 00:48:38 -0800 (PST)
Received: from ?192.168.1.13? (abuz156.neoplus.adsl.tpnet.pl [83.8.197.156])
        by mx.google.com with ESMTPS id 15sm1752419bwz.0.2010.02.08.00.48.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 00:48:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B6E9BBB.4000904@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139282>

On Sun, 7 Feb 2010, J.H. wrote:

> I'd sign-off that, I've probably run into it a couple of times myself.
> 
> - John 'Warthog9' Hawley

I think you meant ACK, not sign-off...
 
> On 02/07/2010 01:40 AM, Jakub Narebski wrote:
> > Otherwise the errors can propagate, and show in damnest places, and
> > you would spend your time chasing ghosts instead of debugging real
> > problem (yes, it is from personal experience).
> > 
> > This follows (parts of) advice in `perldoc -f do` documentation.
> > 
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > This is fallout from my work on [split] "Gitweb output caching" series.
> > Before I used `die $@ if $@;' in t/t9503/test_cache_interface.pl, tests
> > failed for no discernable reason...
> > 
> > So I think the same should be done for the gitweb config file.
[...]

-- 
Jakub Narebski
Poland
