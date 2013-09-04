From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Wed, 4 Sep 2013 09:36:19 -0400
Message-ID: <CAM9Z-nnGV4hMG1bAY9u+U+qU5vwi95RWFLj2-75AQUZc5mQDtw@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
	<CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
	<CAA01CsqNKMqExq1PYanotzQ-wTcf=7c5BQ_49xGu4QasXSCoeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 15:36:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHDFw-0006NY-D2
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 15:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762595Ab3IDNgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 09:36:20 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59919 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762587Ab3IDNgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 09:36:19 -0400
Received: by mail-ie0-f175.google.com with SMTP id u16so564327iet.6
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BhmODe66QysdXDWdAGh/mKZj7O+pAziCTNbO1e/DSDI=;
        b=RJEK1Qo7kNa4hTTK1MGR4kBgNIrJBkRovgeRAXfAZmzRb/C7sswF0pBberohJ8Bptx
         aYu2YfWL/uKHPqgZuI0UT/TxdoFQLb95NeiUq76qxojIcX//J5mNlB4g+0YKS0Uafou8
         x/mWaxcBWlP+ZFIyZE6ecL3I8hILbuKxRnkwW/PG1NF2EH+TAfi3QCdaxjyktK08puaY
         PQNq5QLt3XaPF3Sqz0Kul2BQ1X0gUE0tYZEuvRfyn1+m0mJ9QGsJyr7kBRP81YcvWMAS
         5xCK40bC9xMHUt9avgmOrl1ibDwhQtCslKzxjUMiloVylIT5ayVKs0C+Qf88eyXaMPxO
         +shw==
X-Received: by 10.43.125.4 with SMTP id gq4mr1788385icc.1.1378301779333; Wed,
 04 Sep 2013 06:36:19 -0700 (PDT)
Received: by 10.43.111.72 with HTTP; Wed, 4 Sep 2013 06:36:19 -0700 (PDT)
In-Reply-To: <CAA01CsqNKMqExq1PYanotzQ-wTcf=7c5BQ_49xGu4QasXSCoeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233836>

On Wed, Sep 4, 2013 at 3:13 AM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Just wanted to point to a Dr. Dobb's article from Monday:
> http://www.drdobbs.com/tools/getting-started-with-git-the-fundamental/240160261?pgno=2
>
> The author does not use the use the word "index" at all. Instead he
> writes in following way:
>
> ---------------------------------------------------------------------------------------
<DR DOBBS QUOTE>
> ---------------------------------------------------------------------------------------
>
>
> Sorry for not responding to your comments Drew, no time at the moment.

NP. What he writes [in that quote at least] is entirely reasonable. In
fact, oddly enough (as I presume you meant it as a refutation), it can
be seen to support my argument: don't mess with the core code much (if
at all) but fix the documentation. That's all that I've been arguing
since day one. We don't need to make big huge changes in every part of
the Git metaphor set to better explain what is going on to newbies and
casual users. (Aside from the fact that there's a huge body of
existing documentation, tools, and usage patterns that depends on the
currently predominant model.)

I still argue that for a not insignificant group of users--people who
are happy with the current paradigm and therefore aren't making a lot
of noise--the current core metaphor is actually useful despite the
name being more than just a tad bit unfortunate. Alas, for dealing
with some of the advanced usage explanations it can be argued that the
"staging area" metaphor (it implies _completed_ bundles ready to
package into commits and ship--I envision shipping trailers being
filled with _immutable_ boxes and attached to trucks) is actually
harmful, but we can talk about that if there's a need.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
