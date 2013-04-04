From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH] git-web--browse: recognize iTerm as a GUI terminal on OS X
Date: Wed, 3 Apr 2013 20:10:10 -0400
Message-ID: <CAEBDL5WEChOgG2XVML=tjWtUgp4_5nQq-KqQv-h79tgaDTx9bA@mail.gmail.com>
References: <CAMxBVSs6dJFnK78E2Da7t4V9ndJFRVDZEd1fR5QuCFz=u2Bnpw@mail.gmail.com>
	<CAMxBVStw-b3J_Fm9x=h3==9ebdLUkpjBSQ9-W4+zJ9N20ojfxg@mail.gmail.com>
	<CAP8UFD2oR5tnYuw7Nbe-CzGx7fw-OpAFW+reN+1Nroh1jXjfsQ@mail.gmail.com>
	<CAMxBVStVXZGGrjHzN7kukVP6_ZGo0miyJaE2FVYPVV4Jb5U82w@mail.gmail.com>
	<CAEBDL5VNodcTGBOvQjyL30qiXhshxhnUH-Vd9xy9=RxZQgH-Yw@mail.gmail.com>
	<CAP8UFD2m8n5RHN-CgyDP1ir_AorpJGnWwNhXuRxDa=DbHfsdiw@mail.gmail.com>
	<20130325101318.GA31409@yoda.local>
	<7vtxnzw3wu.fsf@alter.siamese.dyndns.org>
	<CAEBDL5Vx0vjAKUeFrXgpx7mYxk8B+OQC5yrEii9RMP-5-Sjhsw@mail.gmail.com>
	<7vfvzgrjgz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Timo Sand <timo.j.sand@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 02:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNXlN-0003Dj-IA
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 02:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762909Ab3DDAKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 20:10:13 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:44017 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761228Ab3DDAKM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 20:10:12 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so2199247wgh.10
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=npTU7D6tH9+dvCWiGkmXwxZZY7K/XJryBHwzmmvEi0A=;
        b=zQL8CTthVAhcgzgKdbn3d7pqN8Uwi/17W7gd7avWhSyBbRIgPDAAQCLTOWCNPrnA1k
         1VjuHCBGZNJbiynnWRzqRho3nv6Snk0mdOPdllcdDgb8g0fkR27tuEidfA817jK4iYeX
         zmwBtHSgieARwWLjCEu9LCNlyyAK9esvXk1JoKe5XM/igCIsz0flxlSWq68uy2lJ/ybb
         BH83tH1TVMtF7WgnKzUpY7YYrRNw85kdkk1YHVTxO4/0FW+oC6x003nuthmv4vS5gXkY
         Iyw4XvdUyDF0nikszWCKdJpnpYXsCLqcOTQo2YcxxHkubOeVz0R+0zNrfY6QqY5SZwJj
         84jA==
X-Received: by 10.180.13.233 with SMTP id k9mr1190406wic.6.1365034210843; Wed,
 03 Apr 2013 17:10:10 -0700 (PDT)
Received: by 10.180.79.6 with HTTP; Wed, 3 Apr 2013 17:10:10 -0700 (PDT)
In-Reply-To: <7vfvzgrjgz.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: KGiTjiLe2p5GGSFO5ugh7zXa1Cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219978>

On Wed, Mar 27, 2013 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> If that approach is better than what you originally sent, then yes.
>
> But I do not use OS X, so you may need to pay attention to possible
> complaints and comments from other Mac users on this list for a
> while---there may be people who run the program in question without
> that environment variable.

Sorry it has taken me so long to get back to this.  I searched around
and tried out a few terminal programs that are available, and I think
what you queued--checking that TERM_PROGRAM is non-empty--is the right
fix.

Thanks!

-John
