From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Re*: Peculiar behavior of git 1.5.6
Date: Thu, 04 Sep 2008 11:05:37 -0500
Message-ID: <48C00751.3030102@lwfinger.net>
References: <48BF759B.9090309@lwfinger.net> <48BF97B3.5060309@viscovery.net> <7vljy85mwx.fsf@gitster.siamese.dyndns.org> <57518fd10809040211q12d1f0ddk16f2d4273ee7d488@mail.gmail.com> <7v3akg5jul.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 18:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbHLm-0007pl-9w
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 18:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYIDQFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 12:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbYIDQFU
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 12:05:20 -0400
Received: from mtiwmhc11.worldnet.att.net ([204.127.131.115]:33563 "EHLO
	mtiwmhc11.worldnet.att.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751695AbYIDQFT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Sep 2008 12:05:19 -0400
Received: from [192.168.1.111] (cpe-69-76-241-187.kc.res.rr.com[69.76.241.187])
          by worldnet.att.net (mtiwmhc11) with ESMTP
          id <20080904160512111004vc4he>; Thu, 4 Sep 2008 16:05:18 +0000
User-Agent: Thunderbird 2.0.0.12 (X11/20071114)
In-Reply-To: <7v3akg5jul.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94940>

Junio C Hamano wrote:
> 
> But pull to merge codepath in question that Larry originally brought up
> always did, and that is what puzzles me.
> 
> Perhaps some virus scanner or trackerd is running under Larry's working
> tree that contaminates the stat information after we refresh the index?  I
> dunno.

No, neither a virus scanner nor trackerd are running.

I use quilt to handle my local patches. One of the things that I have 
found confusing is that sometimes git complains about the files that 
have been restored, and sometimes not.

I replaced git on the machine in question with the latest git version 
(1.6.0.1.216.g1b23a) so the behavior will be the latest.

Thanks for the answers,

Larry
