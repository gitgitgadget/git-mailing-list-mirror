From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 0/4] git-p4 test cleanup, commit time change
Date: Sun, 31 Jul 2011 10:49:41 +0100
Message-ID: <4E352535.4060804@diamand.org>
References: <20110731003557.GA4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 11:54:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnSj9-0006Vf-SI
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 11:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156Ab1GaJtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 05:49:47 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57318 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab1GaJtq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 05:49:46 -0400
Received: by wwg11 with SMTP id 11so804613wwg.1
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 02:49:44 -0700 (PDT)
Received: by 10.227.27.137 with SMTP id i9mr3883112wbc.28.1312105784690;
        Sun, 31 Jul 2011 02:49:44 -0700 (PDT)
Received: from [86.30.143.167] (cpc4-cmbg14-2-0-cust166.5-4.cable.virginmedia.com [86.30.143.167])
        by mx.google.com with ESMTPS id k84sm2563578weq.46.2011.07.31.02.49.42
        (version=SSLv3 cipher=OTHER);
        Sun, 31 Jul 2011 02:49:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110402 Iceowl/1.0b2 Icedove/3.1.9
In-Reply-To: <20110731003557.GA4867@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178232>

On 31/07/11 01:35, Pete Wyckoff wrote:
> Here's a small patch series to clean up the git-p4 tests a bit,
> make them work on a 2-user eval p4d, and to fix a problem with
> the timestamp on the import commit.
>
> Luke, if you can take a look and ack these, I'd appreciate
> the review since I had to adjust your --preserveUser tests.
> And if you're looking at that one, might as well look at them
> all.  :)
>
> I'd welcome review from anyone with interest, and will plan
> to submit these to Junio in a week or so.

Just looking at them now.

One thing though - are you sure the p4d demo license only allows 2 
users? I've only ever used the demo p4d for testing and it seems to work 
fine (just tried again with version P4D/LINUX26X86_64/2010.2/322263).

The web page says this:

"The free Perforce Server supports two users and five client workspaces, 
or unlimited users and up to 1,000 files. Request a 45-day evaluation 
license to support any number of users and unlimited files."

Which I assume means the test harness couldn't have more than 1000 files 
and some unspecified number of client workspaces?

I've just created 4 users by hand with no obvious problems. I'm pretty 
sure I'm not accidentally using the corporate server!

Confuzzled!
