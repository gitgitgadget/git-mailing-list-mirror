From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: Fwd: vcs-svn and friends
Date: Fri, 23 Sep 2011 19:29:20 +0600
Message-ID: <CA+gfSn_OVBB16pvyWtARzp_9=WPu+Q0WPM=h=4zEePH_WnW4pA@mail.gmail.com>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
	<20110915100106.GB2328@elie>
	<CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
	<CA+gfSn8UeqiLu3trecPzzqSLsUr3eNT0yVN=-991sL6oJHar2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 15:29:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75ok-0007XM-QH
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 15:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab1IWN3W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 09:29:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42761 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab1IWN3V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 09:29:21 -0400
Received: by gwb15 with SMTP id 15so3695476gwb.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GqJC47Gz7qHSYNTUtPFoSJhhRkdjIrFbMe6muW1eQvs=;
        b=KqPaEgmbDEY9YPjfoPa2oJfmD7dtdzVUr3p5WaBD8WfzIkjURHTqt2kd37cv/0rcJ8
         H2s5jJ6g76N76DwbOGgniB1hPDdhOBRpTgZsVAsJ2q44bfHjkxf1NThSottVURjPja6a
         /tefwzjrQtDENujJ74w7Bq1FB7QrmFJ8iVKmA=
Received: by 10.229.26.148 with SMTP id e20mr1097924qcc.54.1316784561131; Fri,
 23 Sep 2011 06:29:21 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Fri, 23 Sep 2011 06:29:20 -0700 (PDT)
In-Reply-To: <CA+gfSn8UeqiLu3trecPzzqSLsUr3eNT0yVN=-991sL6oJHar2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181964>

On Fri, Sep 23, 2011 at 7:27 PM, Dmitry Ivankov <divanorama@gmail.com> =
wrote:
> On Thu, Sep 15, 2011 at 7:00 PM, Dmitry Ivankov <divanorama@gmail.com=
> wrote:
>>> =A0- 3bba32e9 ("fast-import: allow top directory as an argument for=
 some
>>> =A0 commands"): I'm not sure what the motivation is --- is this jus=
t
>>> =A0 about the principle of least surprise, or did it come up in pra=
ctice
>>> =A0 somewhere?
>> (to ease one's reading, commands are ls, copy and move top directory=
)
>>
>> Haven't seen them in practice. It seemed possible with svn import: i=
f there were
>> no branches at start, and then someone did svn mv . trunk. But it
>> turns out that my
>> svn client doesn't allow such move. So more like a least surprise pu=
rpose.
> I think now that this commit should go separately if at all.
> Especially considering
> my other activity on fast-import (and thus possible merge conflicts) =
that isn't
> strictly necessary for vcs-svn and friends.
And the same for 3bba32e9^ "fast-import: be saner with temporary trees"=
, which
is only needed for 3bba32e9.
