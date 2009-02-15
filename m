From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 00:22:11 +0100
Message-ID: <2c6b72b30902151522l5abcb2c6rdf0a43630fb97f5f@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <20090213023120.GA7322@b2j>
	 <2c6b72b30902131557w1bfe9e43l34b28a22d202e881@mail.gmail.com>
	 <20090214033139.GA7563@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 00:23:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYqKz-0004A5-JL
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 00:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZBOXWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbZBOXWP
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 18:22:15 -0500
Received: from mail-fx0-f25.google.com ([209.85.220.25]:60526 "EHLO
	mail-fx0-f25.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbZBOXWO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 18:22:14 -0500
Received: by fxm6 with SMTP id 6so1339590fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=V1ndu306zrJKf2BErg5ODlOvqc59FNE4quQXLmn5v9c=;
        b=R8aY20Q7ZTMFEshk+dsTr6nu80pLpG2LHMe1YmlwCYWrux2Fg0TAPLbhGXnbfH2Wnj
         6keeWSqut/9agCJEPClN1+9Ekq8sEXw/K0zZ1TsQ+uOfnth4OslStDdiVNYSbziXeQZS
         wWT5VxPfAvU4MFxpkH5WKAdtErCbPM5tsfIis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=kvM5Wq7mlpUXgpIHFp4mg9AWZs+XTnusC/RUMFVGqSzRg0FAYoublpAZdTpbPQeK2l
         JpQmADVjw7HAMtcfbu4bEMLpZG14z0RCJwgFxJH1dni7eSgbX4iSaUlik+I/blW4o/Xr
         WQPCRzMRs3GwwsdZF0/X9YTjupMHW7skcXVLw=
Received: by 10.181.58.9 with SMTP id l9mr640239bkk.46.1234740132031; Sun, 15 
	Feb 2009 15:22:12 -0800 (PST)
In-Reply-To: <20090214033139.GA7563@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110085>

2009/2/14 bill lam <cbill.lam@gmail.com>:
> On Sat, 14 Feb 2009, Jonas Fonseca wrote:
>> [About horizontal scrolling]
>
> Thanks.  I tested and found that there might be a bug.  For some lines
> (>100 columns) it stoped scrolling even there are text there, instead
> it displayed a ~ sign at the edge.

This should have been addressed in tig-0.14.1.

> Also, when editing in the command mode, the back-space and left arrow
> keys do not move cursor.  It can only use ctrl-h to delete the last
> character.  Apparently it did not use readline and was impossible to
> recall history using up-arrow key.  It should be perfect if it use
> readline and can also work in vi keybinding mode.

According to the ncurses FAQ, it is not straight forward to use
readline. Of course you could call out, but then views loading in the
background would stop working. I know this part of tig hasn't received
a lot of work, and it has been noted in the TODO. I would be happy to
give you some pointers if you are interested in looking into this
yourself.

-- 
Jonas Fonseca
