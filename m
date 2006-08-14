From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH 28/28] makes upload_pack void
Date: Tue, 15 Aug 2006 01:03:27 +0200
Message-ID: <dbfc82860608141603y64737257n85cc169a6f58ff7e@mail.gmail.com>
References: <Pine.LNX.4.63.0608141340060.19383@chino.corp.google.com>
	 <dbfc82860608141545s3e75457eo4be1201395e24354@mail.gmail.com>
	 <Pine.LNX.4.63.0608141549150.21515@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 01:03:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClT4-0008Mg-AO
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 01:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWHNXDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWHNXDa
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 19:03:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:37042 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965036AbWHNXD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 19:03:29 -0400
Received: by nf-out-0910.google.com with SMTP id x30so111054nfb
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 16:03:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=T20Gh24N9EmRdRrU5NdZP/0AnIVXQiw1Rnxia50vwiC49ZezjwXqe1kXUGsfVORFcOyRKIfHfacZTg5NU171B7e3BV3gXACZQGnAqG5qYx/cPjrUbgtE3cczz6oVG5Y+s4WRH6SfOL4bbgYx3sgluL5TUccM8vf+zDRayPTCHTs=
Received: by 10.49.29.3 with SMTP id g3mr490971nfj;
        Mon, 14 Aug 2006 16:03:27 -0700 (PDT)
Received: by 10.78.178.17 with HTTP; Mon, 14 Aug 2006 16:03:27 -0700 (PDT)
To: "David Rientjes" <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608141549150.21515@chino.corp.google.com>
Content-Disposition: inline
X-Google-Sender-Auth: ad5bb5326548dd90
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25420>

On 8/15/06, David Rientjes <rientjes@google.com> wrote:
> On Tue, 15 Aug 2006, Nikolai Weibull wrote:
> > I don't know for sure, but I'm guessing the intention was to be able
> > to return a failing code /if/ there ever was a condition where
> > upload_pack() would fail, e.g., if send_ref() would return a status
> > code instead of die():ing if it can't parse the given sha1.  In a
> > future libification, the change of return type may have to be
> > reverted.

> Of course.
>
> If upload_pack were modified to return an error code based on a specific code
> path, I trust the implementer would know how to change void to int.

So do I.  However, I trust that whoever implemented send_ref() knew
about void.  (See how easy it was to do what you did but the other way
around?)

It was just a comment.  I don't have anything against the patch as such.

  nikolai
