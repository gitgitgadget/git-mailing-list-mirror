From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Mon, 3 Apr 2006 13:15:11 +1200
Message-ID: <46a038f90604021815g453c57c9pf95a0f70a62f2fbc@mail.gmail.com>
References: <1143950852.21233.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 03:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQDf4-0001ai-Sd
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 03:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWDCBPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 21:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWDCBPN
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 21:15:13 -0400
Received: from wproxy.gmail.com ([64.233.184.231]:13494 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964801AbWDCBPL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 2 Apr 2006 21:15:11 -0400
Received: by wproxy.gmail.com with SMTP id i22so1210471wra
        for <git@vger.kernel.org>; Sun, 02 Apr 2006 18:15:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IQVPSDD//NrZvhXunpkytV/t7ptBwTzHvIsxA16JeMML5F54N7Fkbsc+dFxXujvOjKr2OcQ7rEv6nsk1lIon4RtZ+3icN5hDp0nPMfUR+K4mw46ukUdqb97EZ7eEAwBX0CXK1P5VM+GVTMp+roX/luKFo3sJ9315I6nS18zpEw8=
Received: by 10.54.67.6 with SMTP id p6mr594486wra;
        Sun, 02 Apr 2006 18:15:11 -0700 (PDT)
Received: by 10.54.72.1 with HTTP; Sun, 2 Apr 2006 18:15:11 -0700 (PDT)
To: "Sam Vilain" <sam@vilain.net>
In-Reply-To: <1143950852.21233.23.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18301>

On 4/2/06, Sam Vilain <sam@vilain.net> wrote:
> If the plumbing or a porcelain could be smart enough to automatically
> create hydra when patches are not dependent, then many of the benefits
> of patch calculus might come for free, without having to create these
> complicated sounding entities manually.

I'm not too excited about the benefits of patch calculus -- it seems
to break  many general usage scenarios(*) and I haven't seen many
examples of those benefits that aren't a bit contrived.

* - For instance: the common practice of having a patch series where
you create a new function and later add calls to it breaks quite
seriously under patch calculus.

Are there common usage scenarios where patch calculus helps more than
it hurts? Preferrably without involving manual recording of
dependencies or full language parsers that guess them.

cheers,


m
