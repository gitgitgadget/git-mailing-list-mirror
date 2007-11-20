From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: [PATCH v2] git-send-email: show all headers when sending mail
Date: Mon, 19 Nov 2007 17:53:57 -0800
Message-ID: <9B3C2B93-5C6D-42B9-9063-3DF911DF7D8F@develooper.com>
References: <327906.50991.qm@web52410.mail.re2.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: ddkilzer@kilzer.net
X-From: git-owner@vger.kernel.org Tue Nov 20 02:55:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuIKD-0006js-3v
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 02:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231AbXKTByJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 20:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759222AbXKTByG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 20:54:06 -0500
Received: from x8.develooper.com ([216.52.237.208]:49295 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810AbXKTBx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 20:53:58 -0500
Received: (qmail 15583 invoked from network); 20 Nov 2007 01:53:57 -0000
Received: from dsl081-039-130.lax1.dsl.speakeasy.net (HELO embla.bur.sol) (ask@mail.dev@64.81.39.130)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 20 Nov 2007 01:53:57 -0000
In-Reply-To: <327906.50991.qm@web52410.mail.re2.yahoo.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65522>


On Nov 19, 2007, at 10:50, David D. Kilzer wrote:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Thanks.  Looks nice and obviously correct.
>>
>> One thing that has been bugging me for a long time now stands
>> out like a sore thumb much more: empty Cc: is shown.
>
> I can't seem to reproduce this.  Could you send me (off-list)
> 0001-branch-contains.txt and any relevant config bits?

You need to make git-send-email not have an implicit Cc (from signed- 
off-by or some such), then it'll appear.

I sent a patch yesterday for it,

Subject: [PATCH] Don't print an empty Cc header in SMTP mode when  
there's no cc recipient defined
Message-Id: <1195469295-5774-1-git-send-email-ask@develooper.com>



  - ask

-- 
http://develooper.com/ - http://askask.com/
