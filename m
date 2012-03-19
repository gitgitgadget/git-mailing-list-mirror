From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: A better git diff --word-diff (--word-diff-regex) ?
Date: Mon, 19 Mar 2012 18:06:49 +0100
Message-ID: <CAA01Cso5z9oT_MyFmGCJ0aV7EXb11k8zK4bJ9XBBLT3Yx_zpdw@mail.gmail.com>
References: <CAA01CsrJ12LmNYe6ujnDsZecJcGc8mFaB=1GC8-RZzvMYbYuUw@mail.gmail.com>
	<87ipi0vs0q.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 19 18:06:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9g2p-00052t-1i
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 18:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417Ab2CSRGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Mar 2012 13:06:51 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43815 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758422Ab2CSRGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 13:06:50 -0400
Received: by yhmm54 with SMTP id m54so5681279yhm.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Id/GGb/IJ948zyh0zcS31APfbym8HmsvO9qNgrVEguM=;
        b=Ng6lJIKBS1P6/Kg0xJfUWhO96p/34MdewkGNeWFfS+l9GagNL4SP0XUnZ1JbUjjBmd
         3eUBEkhoXn4yj8mlyMcCUhwN1j6sXKHyqY0aHGvttT76sRG4Xt6BCDzTbTh4XuAX1FZ4
         6RchsALpoblm8I+Mb1sxf+4Qm+O0lw5dheyHPk1ELjnOevnkjxtUvfv1v3o0C5wcFln6
         eoWjEEqh2ypIXdMTPA7V+HKijqSfry82PCA9OO84m0iJbK4CHso3G+/MAlA69hxDihnU
         bee0rtfC9J80IEw6AqFIXutaWAlm6mmGOwsgz6Z4AJwRv6rCMJT8WEiXUXrMnq9qZ5M5
         hpPA==
Received: by 10.50.170.104 with SMTP id al8mr6745006igc.9.1332176809364; Mon,
 19 Mar 2012 10:06:49 -0700 (PDT)
Received: by 10.50.170.40 with HTTP; Mon, 19 Mar 2012 10:06:49 -0700 (PDT)
In-Reply-To: <87ipi0vs0q.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193443>

On Mon, Mar 19, 2012 at 10:50 AM, Thomas Rast <trast@student.ethz.ch> w=
rote:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> is there a way to configure --word-diff to be a more programming
>> language friendly? For example if I add one parameter to a function
>> declaration, I'd like to see only the addition of the parameter as t=
he
>> change. But currently it shows much more.
>
> Umm, what's wrong with
>
> =A0echo '*.cpp diff=3Dcpp' >>.git/info/attributes
>
> Ok, the funcname patterns aren't so good, but the word regex is desig=
ned
> to "tokenize" as far as that is feasible.

Thanks, that's very good! I've missed it reading the git-diff man page.

--=20
Piotr Krukowiecki
