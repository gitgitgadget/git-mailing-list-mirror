From: David Aguilar <davvid@gmail.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR
	invocation?
Date: Tue, 5 Jan 2010 12:22:00 -0800
Message-ID: <20100105202159.GA2657@gmail.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> <xuu2zl4tfuij.fsf@nowhere.com> <fabb9a1e1001041452q299f1f28hff041eb06fd24b1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 21:22:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSFvC-000652-VI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 21:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0AEUWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461Ab0AEUWX
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 15:22:23 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:51370 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755284Ab0AEUWK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 15:22:10 -0500
Received: by ewy19 with SMTP id 19so8862445ewy.21
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 12:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pM1hemF+Bp6J4cMxZBoqFUd3irBWuhPWv2ROZWpjLoM=;
        b=Ajqe+ctS+X/BaSOzc5qHmGqIDOtRXQ4SMdUyTVwRXXGUMr8NziuZ43grIw46wHMl6E
         AHaD7yXSm+WR/MBK/2Bfms57z2uLk0r/Lc7thDMWpzcYIqzGGNz4KcfRAc0H421ivgis
         OZJKMDAuhgGiwELJOLDucYlY3WuK9ROf1mR9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PqqGuFo8NjtXSBJamPwSBQ7qVmNA/RqNLK/vyrFqftjEiC78g6yFMlIT28XJVK0JJR
         2DgJntN5UbA8DEYKzNndGjZKB4W4tfnJHtRzR2pjFJJcWNLhdabv/yk+IrckBX9PST1k
         GLsyzOHYlFrX5S4eY8F6Jk9aWdu8TTpMLmcQQ=
Received: by 10.216.88.140 with SMTP id a12mr1229640wef.157.1262722929379;
        Tue, 05 Jan 2010 12:22:09 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id t2sm52398616gve.9.2010.01.05.12.22.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 Jan 2010 12:22:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fabb9a1e1001041452q299f1f28hff041eb06fd24b1f@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136207>

On Mon, Jan 04, 2010 at 05:52:42PM -0500, Sverre Rabbelier wrote:
> Heya,
> 
> On Mon, Jan 4, 2010 at 16:08, Adam Megacz <adam@megacz.com> wrote:
> > Perhaps a preference (off by default) demanding that they be set
> > explicitly when "git commit -m" is used?
> 
> Heh, what use would that be? On a different/new box you would have
> neither that setting nor the email set, so that doens't solve the
> problem methinks :P.
> 
> -- 
> Cheers,
> 
> Sverre Rabbelier

Workaround:

If you use "git commit -s" it includes a Signed-off-by line
which includes your name and email.

Seeing "Signed-off-by: root <root@localhost>" would give you a
hint that you should abort the commit, set the vars, and
try again.


-- 
		David
