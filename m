From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 12:37:32 +0300
Message-ID: <94a0d4530904060237u6d1cafb6x49999000526ead00@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <200904052358.53028.markus.heidelberg@web.de>
	 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
	 <200904060117.24810.markus.heidelberg@web.de>
	 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
	 <alpine.DEB.1.00.0904060141190.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, markus.heidelberg@web.de,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 11:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqlIL-0004Fq-Hp
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 11:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbZDFJhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 05:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZDFJhh
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 05:37:37 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49778 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081AbZDFJhg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 05:37:36 -0400
Received: by fxm2 with SMTP id 2so1786376fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 02:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RUF6mypgHm/P2bnZy3XuzVTmlw5YdC7QBBNVGHRos3w=;
        b=cBbo9Dv7R74MglB8sDkxoe1Vph1eHW4ZISbQvevBSH0JZ0FWKgBWlEeO+8Cut9sxdX
         oqMjFhKoPN8B5oG/rd60TufQN3TW40JXypkckjX0JXfgj7BElvMub8sJX2dd/S5u1tW2
         eLJLbl4xEaNw6ikiwHy9+wtTYe7j/JbxpSL38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d0sRB9RtiVUP4vMCHwo4DyiAjoXD12tcN+VIXyGwAvTSlAN4qw+H2kpXvU2I8dDaTr
         BWI7NWLCIUEviUL33oRF8DBa7sRPiskAxON6yKYyXPfH6T1QyCvosiEuL+bLnjLIJOHa
         0H2mOq91BG8nng2ArVr4YkyBeSRf5BsPda/jw=
Received: by 10.86.91.3 with SMTP id o3mr2929743fgb.17.1239010653042; Mon, 06 
	Apr 2009 02:37:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904060141190.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115801>

On Mon, Apr 6, 2009 at 2:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 6 Apr 2009, Sverre Rabbelier wrote:
>
>> On Mon, Apr 6, 2009 at 01:17, Markus Heidelberg
>> <markus.heidelberg@web.de> wrote:
>> > Felipe Contreras, 06.04.2009:
>> >> But actually, "git diff --cached" is a different action; you can't do
>> >> "git diff --cached HEAD^.." for example.
>> >
>> > And I neither could I do "git stage diff HEAD^.."
>>
>> I rest my case ;). That's the whole point Felipe is trying to make here.
>> $ git diff --cached
>> $ git diff HEAD^..
>>
>> [...]
>
> Could you post at some stage what the current state of this discussion is,
> so that people who do not have time to read all those mails, let alone
> fire off 10+ mails per hour, can comment about their view of things?
>
> So far, it seems that the view of only a handful is represented in that
> thread.

So far it seems nobody likes the idea. Junio has explained why things
are the way they are, but he hasn't answered my arguments, including
the fact that this doesn't change anything, it merely adds options to
an already existing command.

This is the mail that hasn't been answered yet:
http://article.gmane.org/gmane.comp.version-control.git/115705

-- 
Felipe Contreras
