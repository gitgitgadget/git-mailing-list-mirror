From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Mon, 12 May 2008 12:19:25 +0200
Message-ID: <bd6139dc0805120319s5ad37867k392eff88616b689e@mail.gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	 <bd6139dc0805120238n1f990b4dwcd0e133ff146ed1d@mail.gmail.com>
	 <m3d4nr4ykr.fsf@localhost.localdomain>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 12:20:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvV8h-0001sQ-Tm
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722AbYELKT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbYELKT0
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:19:26 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:33584 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757801AbYELKTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:19:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2251094wfd.4
        for <git@vger.kernel.org>; Mon, 12 May 2008 03:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=24NakTqSJJTxUAFQCBkqY+iaPauxhkF4sylvnKJ+XB4=;
        b=a9KvD10G3ZKfxgIIDMfRjbBnzp20G0e5k4ZoFq3epQwXyNzhqKsi9Uu8JdSZGAD+G7L76Vh2JZURHEyNo12U6Q4uToMo+DBE/nTQfVi1t7UTPOkg7Jyd6Z3ShXtbcRbiLuEiIi7JzIx1ONHdNE6I7+x3W4lHfQeqp2z+mDf1Rnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VOEYUDCUQGDYq3LB+sEHqIXKhZZlmDdbKOPn4EXcz4Nj7nb3ZnxzVnWWHewOOGHVraBkaUD6uqtuykK9HpgH9D0tNyJeb8wJG4GNzaapZKAtsANZQXyR8bNk2wiz0z2v+npiZRNHm2komazHYNZ1rMgjq75PbY/zLJvRmxh1cvw=
Received: by 10.142.214.5 with SMTP id m5mr3190731wfg.322.1210587565153;
        Mon, 12 May 2008 03:19:25 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 12 May 2008 03:19:25 -0700 (PDT)
In-Reply-To: <m3d4nr4ykr.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81851>

On Mon, May 12, 2008 at 12:16 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> One comment: did you take a look at 'owners.sh' script posted some
> time ago by (IIRC) spearce to check who "owns" egit/jgit and relevant
> git code?  This is one interesting, and useful, statistics.

Ah, yes, I did see it, and something similar to that I intend to
include. I reckon his script would fall under the "Finding a
Contributor that is active in a specific bit of content" use case.

-- 
Cheers,

Sverre Rabbelier
