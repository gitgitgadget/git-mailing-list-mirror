From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: allowing aliases to override builtins to support default options
Date: Fri, 6 Mar 2009 23:37:30 +0100
Message-ID: <fabb9a1e0903061437t2df5620bn58c6c087214f994b@mail.gmail.com>
References: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:39:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfih4-0005eQ-GU
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbZCFWhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbZCFWhe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:37:34 -0500
Received: from mail-bw0-f178.google.com ([209.85.218.178]:42655 "EHLO
	mail-bw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbZCFWhd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:37:33 -0500
Received: by bwz26 with SMTP id 26so551387bwz.37
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V+qb3lHoX8WaljzVntUi5av9Wkv79O5ozZNy/MVLkOM=;
        b=HsStFRhdXyNrJs2l5BUG2QhLghogR880516vvYwJnjGoXYUgXGeH/1ax7O5JfZbAVR
         COZDnbUpVp3NnPlqjvbyRYfMdI82O9fBtmuK6NF5l+nYozwyyg7Y2EuXGeJ+79/AWqOC
         aChgNvaZtKVZB9+ZuAUBWpR8baDZegImuT1fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qNR+0uaovHFln3wYoHb4yT+byO43vGA98EBKXsWGqmsey9NkieSy3hpT/e02+wA2Wf
         HnfFPF2INpgHo6C0ylxjX77yoA78A1E7C+/CRHoTVjMkeC/msGea2dk9sAenl/nMLjEP
         WJRtz/yBx9MgR/ewkKO1makSkE4LRkH7ROwnU=
Received: by 10.103.213.10 with SMTP id p10mr1311364muq.17.1236379050639; Fri, 
	06 Mar 2009 14:37:30 -0800 (PST)
In-Reply-To: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112488>

Heya,

On Fri, Mar 6, 2009 at 23:30, Jay Soffian <jaysoffian@gmail.com> wrote:
> Most shells support overriding commands with aliases, and I'm not sure
> why git needs to be more conservative than the shell. (Although, I
> will say, I hate when vendors alias rm to "rm -i", etc...)

Hmmm, maybe we could require marking such an alias somehow, to signify
that you're aware that you're overriding a builtin? Also, what would
we do the alias 'foo' calling 'git foo'? Does it call the original
command, or itself?

-- 
Cheers,

Sverre Rabbelier
