From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git help -t <topic>: list the help of the commands in a given topic
Date: Tue, 11 Dec 2007 10:04:35 +0100
Message-ID: <8aa486160712110104v6d12985dq45739ff2fc4cc39@mail.gmail.com>
References: <1197299021-28463-1-git-send-email-sbejar@gmail.com>
	 <7v7ijmjayl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 10:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J212z-0003ld-U3
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 10:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXLKJEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 04:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXLKJEj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 04:04:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:57123 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXLKJEh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 04:04:37 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1633956wra
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jYqEpV9nhyt+Wfaaj4wqNSt8JH4PRRrfb1mMVqSuSYY=;
        b=EOTKmmyXL38mdYOfgSRX65B/Z8+PDIZUfacLExqUXqmvBmCswn9C9s3rT1G715ZeDiGTIwhHQz0WnqX3w9qU+vTgGjwz+t9rXCD4c9gXs3TvlBqXbo+iDSbQo9I8s+GDvXSOs/XOByLTvesmYaUhS/VT/9kvd1Ln+grOSg66PMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B2EVFYMlRve0mMxgHObOm7jZKTalzVbhTYdBc8S4WwqeMJG4/a+jsrymzVih4ZvDBMPtNpSrYjmthAkB+4/Oq13hyCfF0p2OZwn7w0PUqwK/YaZ9EMyxg2eHMq326niLDw7Re5E996cxwmbI/aEGbnuQ6oMSkKA7yImbLK42vkw=
Received: by 10.150.91.20 with SMTP id o20mr1663069ybb.1197363875049;
        Tue, 11 Dec 2007 01:04:35 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Tue, 11 Dec 2007 01:04:35 -0800 (PST)
In-Reply-To: <7v7ijmjayl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67827>

On Dec 11, 2007 2:07 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > With 'git help -t' lists the available topics.
> >
> > Show a hint to get a longer list when listing the common commands.
>
> I like the idea of making the categorized command list in git(7)
> available, and agree with you that renaming common_cmds[] to cmd_list=
[]
> and place everything in there would be the way to go.
>
> However, I doubt about your presentation.  Who are the intended
> audience and what is the expected way this is used?

The main reason for this was to be able to show a longer list in git
help. But at the end I did this topic thing. The intented audience was
the newbies looking at the "git help" output, for them to have a
longer list. Then the topic part was intended for intermidiate user
looking for even more powerfull commands.

>
> I highly suspect that it would be much easier to use if you add a mod=
e
> to "git help" that runs the pager over the categoized command list pa=
rt
> of git(7) manual page, without taking "show me list of topics" nor "s=
how
> commands only in this topic" parameters.  It is highly unlikely that =
a
> user knows which category an obscure command whose name he wants to
> recall is in, or can guess which category it would be classified in
> after seeing the "category list".  It would be much more likely that =
he
> finds it easier to scan (perhaps with "/<string>") the command list w=
ith
> one line description in the pager.

OK, this makes sense. But I still think that having a longer list in
"git help -l?" with the main porcelain commands makes sense. I'll try
to do it.

Best regards,

Santi
>
