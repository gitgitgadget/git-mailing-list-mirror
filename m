From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Large pack causes git clone failures ... what to do?
Date: Wed, 1 Sep 2010 07:38:19 -0700
Message-ID: <20100901143819.GI32601@spearce.org>
References: <AANLkTi=1iLx=-9gxkGzuhrbpA005VPSp0itkAkOG4D4z@mail.gmail.com> <20100831180247.GF32601@spearce.org> <AANLkTi=O5SbLRttzR0YwrHVEMz5gxtdTo9Z5C6V1yE1e@mail.gmail.com> <AANLkTik2Ms6qjQAaa_H8GGwmTG1fsk+8GR2y7ZmLviY-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 16:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqoSL-0006tF-DS
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 16:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab0IAOiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 10:38:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46615 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab0IAOiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 10:38:23 -0400
Received: by iwn5 with SMTP id 5so6875245iwn.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 07:38:22 -0700 (PDT)
Received: by 10.231.161.68 with SMTP id q4mr8778691ibx.79.1283351902766;
        Wed, 01 Sep 2010 07:38:22 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id g31sm10141780ibh.22.2010.09.01.07.38.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 07:38:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik2Ms6qjQAaa_H8GGwmTG1fsk+8GR2y7ZmLviY-@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155046>

Geoff Russell <geoffrey.russell@gmail.com> wrote:
> 
> I'm still interested in whether clone from a client take note of the
> pack.packSizeLimit if I set it
> on the server? Or does it use the client value?

Neither.

A clone doesn't split its pack.  It stores the entire project
as a single pack file.  If your filesystem cannot do that, the
clone fails.

-- 
Shawn.
