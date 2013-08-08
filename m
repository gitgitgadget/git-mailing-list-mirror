From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Thu, 8 Aug 2013 22:56:45 +0100
Organization: OPDS
Message-ID: <7571F7ED549C4BC68F3DE176FBF81F0F@PhilipOakley>
References: <1375983492-32282-1-git-send-email-stephen@exigencecorp.com><1375983492-32282-2-git-send-email-stephen@exigencecorp.com><alpine.DEB.1.00.1308082314320.24252@s15462909.onlinehome-server.info> <20130808163539.0b59b20a@sh9>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <avarab@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Stephen Haberman" <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 23:56:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7YCB-0001tM-Le
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 23:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112Ab3HHV4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 17:56:31 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:24165 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758094Ab3HHV4b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Aug 2013 17:56:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlgMAMATBFJOl3GZ/2dsb2JhbABbgwY1iSK1cgQEAYEZF3SCHwUBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGIAwi4UASQG4MhdAOIc4YOmi+BNoFjOw
X-IPAS-Result: AlgMAMATBFJOl3GZ/2dsb2JhbABbgwY1iSK1cgQEAYEZF3SCHwUBAQUIAQEuHgEBIQsCAwUCAQMVDCUUAQQaBgcXBhMIAgECAwGIAwi4UASQG4MhdAOIc4YOmi+BNoFjOw
X-IronPort-AV: E=Sophos;i="4.89,842,1367967600"; 
   d="scan'208";a="81541061"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with SMTP; 08 Aug 2013 22:56:21 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231941>

From: "Stephen Haberman" <stephen@exigencecorp.com>
> Hi Johannes,
>
>> This should probably be added to config.txt and
>> Documentation/git-pull.txt, too, right?
>
> Yep, I meant to note that I'd do that after getting an initial
> confirmation that the pull.preserve-merges was the preferred approach.
>
> (I was being lazy and didn't want to write up docs only to switch to
> overloading pull.rebase or what not.)
>
> But I'll go ahead and do that.
>
>> https://github.com/msysgit/git/commit/b733454b
>
> Interesting!
>
>> Feel free to play with it if you want!
>
> I'll poke around out of curiosity, but no promises, as, yes, this is a
> tricky bit of functionality that can quickly lead to a lot of lost
> sleep. :-)
>
> - Stephen
>
>
Johannes also kindly explained his merging-rebase script to me on the 
msysgit list a few days ago 
https://groups.google.com/forum/?hl=en_US?hl%3Den#!topic/msysgit/LiPa2T_K4C4 
which shows how msysgit and git both keep parallel lines of development 
with fast forwarding and rebasing at the same time.

The technique should also help those case for keeping 
private/independent lines of development that are discussed often.

Philip
