From: eschvoca <eschvoca@gmail.com>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 20:27:13 -0400
Message-ID: <2b05065b0910261727g75e4330fn23ed6c633114e689@mail.gmail.com>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
	 <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com>
	 <2b05065b0910261108g4a8448c8x295606a8d33612f5@mail.gmail.com>
	 <alpine.DEB.1.00.0910262210480.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ZuF-0000kH-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 01:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbZJ0A1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 20:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbZJ0A1K
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 20:27:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62865 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310AbZJ0A1J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 20:27:09 -0400
Received: by fxm18 with SMTP id 18so12568647fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 17:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JILu0KFwsK+jPJm9k5w6PZEUnrLtWuAppNe9k7poM68=;
        b=EmQQOOFGO5uZg3HdQV8ZfLL4uWJyrjoFycUTzKrTirlaIr0n+oU0mq5ZSYjWQyxw8l
         F3onFbV44jIAO944QhVzmLhsoY+H1bOGaEzMvzk8H5aUQR649ItxKJlukiueaKgnbAQt
         Cylndgls62v8IvtPF+yjBuCoyND9QiD6y+o4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LxgRGspSTQy0H/d8kMWPd0LvXU1UCs6++0dl98e9L2ynvzB/leK8yWXwdk4Q/15kBt
         3HYJzEaFgSZTqIe5qBf+Sn3FcHDf5zpdnPt16Qn6DKNBSnZxbseDOA5lDyrmAFZot4Tg
         FCJ7MaF/QT2jtwoZGML4HkuQ13eDLuzoElDKQ=
Received: by 10.103.48.28 with SMTP id a28mr6205605muk.128.1256603233132; Mon, 
	26 Oct 2009 17:27:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910262210480.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131293>

Hi,

On Mon, Oct 26, 2009 at 5:11 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 26 Oct 2009, eschvoca wrote:
>
>> On Mon, Oct 26, 2009 at 1:25 PM, Erik Faye-Lund
>> <kusmabite@googlemail.com> wrote:
>> > On Mon, Oct 26, 2009 at 6:14 PM, eschvoca <eschvoca@gmail.com> wro=
te:
>> >> Hi,
>> >>
>> >> Is there a way to rewrite history, including the first commit. =A0=
It
>> >> seems that the first commit can not be modified with a rebase.
>> >
>> > This question is answered in the FAQ:
>> > http://git.or.cz/gitwiki/GitFaq#HowdoIedittherootcommit.3F
>>
>> Thanks Eric. =A0Hopefully someone will enhance rebase to handle the =
root
>> commit.
>
> If you cannot do it yourself, you can always offer to bribe^Wpay some=
body
> to do it for you.
>
> Ciao,
> Dscho
>

I can do the workaround myself but not the production ready patch.
Right now the only bribe I can offer is that it might be less work
writing the patch than supporting this corner case with answering
questions and writing a FAQ entry about it.  It also would make the
awesome rebase -i even awesomer :)  I know, a disappointing bribe but
from a thankful user.

Thanks
