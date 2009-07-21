From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: What does this mean
Date: Tue, 21 Jul 2009 18:42:28 +0200
Message-ID: <20090721184228.78968f15@gmail.com>
References: <24590563.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: wkcochran123 <wkcochran@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 18:42:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTIQN-0000ur-OB
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 18:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbZGUQme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 12:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbZGUQmd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 12:42:33 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:33966 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbZGUQmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 12:42:33 -0400
Received: by ewy26 with SMTP id 26so3203328ewy.37
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=MOvkvDkaG0zfd7vBYbeRGDneyFcD9bfjRpsLITe/Va0=;
        b=SyagD+eyXF9BQvpfTE1uhK5nOpA++Fxi2UGxi1oVl8RfsOHMzDHPQYkAbI3KkGQdX0
         x4vkV9VopJuPygwl7Kzofk4BmKEPfObxQuvVicbW1rA6SfhUWakavDEf+AGiLj+0lSMT
         0Fca0B1zQLDUvCTcBzJJt15YBBhK/xOigAW0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=oQbeWw/esniyL2JLUWgYm4byjSJ4fjs1eV535CpbKz7YcuE3kz1iDgF1hXys4SmVRP
         eEnbNM+ohOFuoi7lCAK3ZQrmdg5ep3+pX43C3QNxi3lcTdQzH0s+ru7PrqITc1IIuY3O
         Bw+ffubUkA/HJMS+EY9BK+MQd7nR5rcr71gmw=
Received: by 10.210.52.15 with SMTP id z15mr6893377ebz.39.1248194552233;
        Tue, 21 Jul 2009 09:42:32 -0700 (PDT)
Received: from localhost (87-205-57-103.adsl.inetia.pl [87.205.57.103])
        by mx.google.com with ESMTPS id 7sm2375841eyg.54.2009.07.21.09.42.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 09:42:32 -0700 (PDT)
In-Reply-To: <24590563.post@talk.nabble.com>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123676>

wkcochran123 <wkcochran@gmail.com> wrote:

> 
> runge:~/repository/papers wkcochra$ git checkout
> D       medial axis/medial axis.tcp
> 
> A search of ^D through user-manual.txt yields nothing.
> 

'git checkout' command switches to another branch (actually, because
nothing was specified on command line, it doesn't switch at all) and
prints a summary of modified files.

For description of 'D', look for '--name-status' option in man git-diff.
Maybe this what you are looking for.

http://www.kernel.org/pub/software/scm/git/docs/git-diff.html
