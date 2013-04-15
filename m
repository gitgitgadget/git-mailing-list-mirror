From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Tue, 16 Apr 2013 01:49:13 +0200
Message-ID: <CAA787rmJKNGF_4koHJpdzbAVjvLB-sWxT__secVRDBi1ieBYnQ@mail.gmail.com>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<20130415232532.GA7134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 01:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URt9F-0003ut-3D
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036Ab3DOXtR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 19:49:17 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:53055 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab3DOXtQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Apr 2013 19:49:16 -0400
Received: by mail-la0-f44.google.com with SMTP id fr10so4878852lab.3
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BueFxJ90CBcgaeQHuWYcSXwHs17a+U0YnAuAfugAivg=;
        b=Jt31SMmBu+bX9N3TyTTn77nTrHLaCQkzhRdgxjcDBOC+ZtL7EPNjrNffSs8Umt2S88
         3CiymrFIaSGy9Y9OX5Db10nnRt26wqj6uV+aROQ0jkTrulO2R7PviheZiwNfMod0ihEE
         EhCM0tdqFpGwNvZDsj/C3idYkyNu2VtmhUlaKV5+6VCbPaD6PWPxq6XTiO7zzR4ybSBu
         CMe6KBsHxBfjgxW0ah0FAjbmuu6dFnDe1fhZhe+XuibOJGDmZOQgagDsSAJLej7ZdLii
         Gqw1mTnHjEqF8cScDBgShnZVUfFrEv8oDi7OoyScULpxqLHNtnFVoRoA4Ai+fv1PoGUk
         CwWw==
X-Received: by 10.112.59.103 with SMTP id y7mr222676lbq.16.1366069753969; Mon,
 15 Apr 2013 16:49:13 -0700 (PDT)
Received: by 10.112.39.69 with HTTP; Mon, 15 Apr 2013 16:49:13 -0700 (PDT)
In-Reply-To: <20130415232532.GA7134@sigill.intra.peff.net>
X-Google-Sender-Auth: P5AKUjx-sSGKM3iTMk90q4XDWCQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221334>

On 16 April 2013 01:25, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 15, 2013 at 01:28:53PM -0700, Junio C Hamano wrote:
> > [Graduated to "master"]
> > [...]
> > * jk/http-error-messages (2013-04-06) 9 commits
> >   (merged to 'next' on 2013-04-11 at 7a03981)
> > [...]
>
> ...the tip of your current master does not currently pass the test
> suite[1].
> [...]
>
> [1] I know you always test master before pushing it out, but I suspec=
t
>     you do not run the GIT_TEST_HTTPD tests. The failures are in t554=
1
>     and t5551.

Ah, that explains why the test suite passed here, I built a new
version an hour ago from current master (v1.8.2.1-418-gaec3f77,
2013-04-15 12:45:15 -0700), and no errors were found. I build new gits
almost every day for testing purposes (master, and next and maint very
often) on several machines with different setups, and of course also
to have the newest version. I'd like to run as many tests as possible.
Is there any list of environment variables or make directives
available to enable most of them?

Regards,
=C3=98yvind
