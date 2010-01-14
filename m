From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in 
	summary
Date: Thu, 14 Jan 2010 21:04:16 +0200
Message-ID: <94a0d4531001141104w74dbaf35jb5fded9e266bc04b@mail.gmail.com>
References: <20100113173408.GA16652@coredump.intra.peff.net>
	 <20100113184510.GA22849@coredump.intra.peff.net>
	 <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
	 <201001141602.22244.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wincent Colaiuta <win@wincent.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVUzX-0001mP-IW
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294Ab0ANTET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 14:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283Ab0ANTES
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:04:18 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:57277 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223Ab0ANTES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 14:04:18 -0500
Received: by iwn32 with SMTP id 32so685101iwn.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 11:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=hvnjrIU2ystzOn7ThodzwDx7RPCro3ec7ud0Pj71T/8=;
        b=VuH3QYU0e9y16GiZVVUvmj2h27UsZxEgr5qU/6fT5wXIOv3H4yphx+Kdf8LGSVp4l4
         Vpq0HcLUAkvEBDT4QfH91IOW5Zir6+AH0EIsqUBlf0GPCxxJhLduZa2l6ekSkeEBCh8n
         fD9nAmMPAuBlR79MFsHQkORMCDfGq2AQwX51c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UIagin9AErYFX/nELZzwY8mBT7JjwEX33iERJFqXeILhIbvXqU9ObtNN1OpXHVw2Qn
         Ip+efpadisDFlyx2aFflcYHAIGz0FyvrHsBL9obWltQ8o5mwln4xP+CcTLW59jWShVNB
         oLp0wG9MqSpWGmanqIhm01aSQfsH/fdiHFywM=
Received: by 10.231.146.79 with SMTP id g15mr1209644ibv.49.1263495856975; Thu, 
	14 Jan 2010 11:04:16 -0800 (PST)
In-Reply-To: <201001141602.22244.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137011>

On Thu, Jan 14, 2010 at 5:02 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Wincent Colaiuta wrote:
>>
>> Fair enough, but I'm sighing here at the thought of people jumping in
>> and using git commands without even having looked at _any_ of the
>> zillions of "your first 10 minutes with Git" tutorials out there,
>> which pretty much _all_ start with how to set up your user.name and
>> user.email...
>
> If you really are shocked by that thought, try hanging out on #git for
> six hours on any given day...

Which is precisely why I was pushing for this:
http://thread.gmane.org/gmane.comp.version-control.git/131150

-- 
Felipe Contreras
