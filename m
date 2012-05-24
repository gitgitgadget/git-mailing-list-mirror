From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] Add persistent-https to contrib
Date: Thu, 24 May 2012 22:42:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1205242238430.4374@tvnag.unkk.fr>
References: <1337792767-18914-1-git-send-email-cranger@google.com> <7v62blxx2m.fsf@alter.siamese.dyndns.org> <CAJo=hJt=q-ZnLrqzcfGrKNcao2MPDSRt3Y_r2OOfu75++N+3zw@mail.gmail.com> <20120524202930.GB18936@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Colby Ranger <cranger@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXesi-0000ak-Hs
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217Ab2EXUnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:43:23 -0400
Received: from giant.haxx.se ([80.67.6.50]:57979 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758841Ab2EXUnU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:43:20 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id q4OKgs6p027541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 May 2012 22:42:54 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id q4OKgrAV027530;
	Thu, 24 May 2012 22:42:53 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20120524202930.GB18936@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198422>

On Thu, 24 May 2012, Jeff King wrote:

> Nice numbers. And as clever as I find this helper-wrapping-a-helper 
> solution, I wonder if the right layer for a fix isn't inside curl. It 
> already keeps an ssl session-id cache in memory; how hard would it be to 
> turn that into an on-disk cache?
>
> I don't think that is grounds for rejecting this patch; obviously it is 
> working for you guys, and it is available right now, and it is only going 
> into contrib/ anyway. But a curl solution seems like a cleaner long-term 
> fix, and would benefit all curl users. It is even mentioned in curl's 
> doc/TODO file. :)

Yes, in the curl project we would certainly not object to being able to 
export/import SSL-session-ids (which then could be used to implement a cache, 
on disk or in memory). However, I don't know how easily done that is to 
implement with the different TLS libraries in use.

-- 

  / daniel.haxx.se
