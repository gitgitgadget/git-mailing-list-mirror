From: Jeremiah Foster <jeremiah.foster@pelagicore.com>
Subject: Re: http-smart-backend: can clone, cannot push
Date: Wed, 2 Jun 2010 17:16:24 +0200
Message-ID: <825A1E57-48AE-4BA5-AD5C-431DA8E959DA@pelagicore.com>
References: <E66CC81A-CCED-4D8E-AE7C-C02FB0AF6F6C@pelagicore.com> <AANLkTimqncJ7aqi_0AvjNimyIPsbVN1zSkAQ1LrPhwne@mail.gmail.com> <B61D22CA-45BA-49DA-984B-A7F7090FAE55@pelagicore.com> <AANLkTin43VO3FA9dEjAx9w6FRwLK7FpqqO5rA6wKFZgn@mail.gmail.com> <3A4DAEA3-C7F4-4163-9ABA-37443BB025AB@pelagicore.com> <20100601155833.GT16470@spearce.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 17:16:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpgN-0005U7-Qb
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 17:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597Ab0FBPQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 11:16:32 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:38495 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab0FBPQb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jun 2010 11:16:31 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 998BB37E98; Wed,  2 Jun 2010 17:16:29 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 64ACD37EAD
	for <git@vger.kernel.org>; Wed,  2 Jun 2010 17:16:24 +0200 (CEST)
Received: from [10.8.36.139] (194-237-7-146.customer.telia.com [194.237.7.146])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 52B0E37E52
	for <git@vger.kernel.org>; Wed,  2 Jun 2010 17:16:24 +0200 (CEST)
In-Reply-To: <20100601155833.GT16470@spearce.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148259>


On Jun 1, 2010, at 17:58, Shawn O. Pearce wrote:

Thanks Shawn, and everyone else who commented on this thread - I appreciate the help.

> Jeremiah Foster <jeremiah.foster@pelagicore.com> wrote:
>> Maybe I _have_ to be authenticated since the documentation states:
>> "If the client is authenticated, thereceive-pack service is enabled,
>> which serves git send-pack clients, which is invoked from git push."
> 
> Yes.
> 
> A flaw of the smart HTTP transport is the servers are
> nearly impossible to configure for anonymous clone and
> authenticated push via the same URL.  The servers just
> can't seem to be configured to require authentication
> for the $GIT_DIR/info/refs?service=git-receive-pack request.

I created a system to authenticate and then I could push and pull with the same URL. Thanks again for the help and I'm going to try to write up a short blog post about using this because I think it is a really great way to share git repos.

Jeremiah
