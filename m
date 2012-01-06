From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Fri, 6 Jan 2012 01:17:16 -0500
Message-ID: <C9D7A58F-853D-4DAB-B27D-78D60B8EE152@silverinsanity.com>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org> <1325692539-26748-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Jan 06 07:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rj37I-0005pu-OI
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 07:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab2AFGRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 01:17:23 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:49786 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab2AFGRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 01:17:22 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E99DC1FFC4F3; Fri,  6 Jan 2012 06:17:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.141] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 28C701FFC446;
	Fri,  6 Jan 2012 06:17:05 +0000 (UTC)
In-Reply-To: <1325692539-26748-1-git-send-email-drizzd@aon.at>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188010>


On Jan 4, 2012, at 10:55 AM, Clemens Buchacher wrote:

> On Tue, Jan 03, 2012 at 11:34:08AM -0800, Junio C Hamano wrote:
>>> +	# kill git-daemon child of git
>>> +	say >&3 "Stopping git daemon ..."
>>> +	pkill -P "$DAEMON_PID"
>> 
>> How portable is this one (I usually do not trust use of pkill anywhere)?
> 
> I read that it is supposed to be more portable than skill or killall.
> But I have no way to research this. I have implemented a workaround
> using only 'ps' and 'kill' in [PATCH 3/6] avoid use of pkill.

As a data point:  pkill and skill do not exist on OS X 10.7, but killall does.

~~ Brian Gernhardt
