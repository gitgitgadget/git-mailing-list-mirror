From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Tue, 1 Jun 2010 08:58:33 -0700
Message-ID: <20100601155833.GT16470@spearce.org>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com> <AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com> <B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com> <AANLkTin43VO3FA9dEjAx9w6FRwLK7FpqqO5rA6wKFZgn@mail.gmail.com> <3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Foster <jeremiah.foster@pelagicore.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 17:58:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJTrW-0007X1-I7
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 17:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143Ab0FAP6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 11:58:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54100 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118Ab0FAP6h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 11:58:37 -0400
Received: by pvg11 with SMTP id 11so1852027pvg.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 08:58:36 -0700 (PDT)
Received: by 10.141.125.2 with SMTP id c2mr4713315rvn.184.1275407915717;
        Tue, 01 Jun 2010 08:58:35 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id l29sm5347390rvb.16.2010.06.01.08.58.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 08:58:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148132>

Jeremiah Foster <jeremiah.foster@pelagicore.com> wrote:
> Maybe I _have_ to be authenticated since the documentation states:
> "If the client is authenticated, thereceive-pack service is enabled,
> which serves git send-pack clients, which is invoked from git push."

Yes.

A flaw of the smart HTTP transport is the servers are
nearly impossible to configure for anonymous clone and
authenticated push via the same URL.  The servers just
can't seem to be configured to require authentication
for the $GIT_DIR/info/refs?service=git-receive-pack request.

-- 
Shawn.
