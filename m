From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [OT] How to get the discussion details via notes
Date: Wed, 31 Oct 2012 08:29:33 -0400
Message-ID: <CAM9Z-nnMF47p2aK+c4Nq=hYFfhYBsWqiKogW36Lre5o7vZonyw@mail.gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
	<1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
	<20121031003721.GV15167@elie.Belkin>
	<CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
	<20121031060529.GA30432@elie.Belkin>
	<20121031095327.GB18557@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 13:30:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTXRe-0000u1-He
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 13:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757406Ab2JaM3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 08:29:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50937 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757357Ab2JaM3f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 08:29:35 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so621364bkc.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GE/5G4sNezB+vWum2CHb1iw8S3jRfFvr64u5ZQzQvvI=;
        b=gYU4JkT0kLd5L9qvQp8cDEJQq3DaX324jwpAWo1Es6D42CBm/Tej44dFsbjJxu9G5d
         U5uCk4DYgEnd+27+I5WJ3ASdhhZ3UedMyzJ/RQC2gT4tIbwLEMXCCf7HtzL0+8uBZ6r0
         4H2Rb2br9LpHCc+Eh0wa/tqqqelN43hsHN4+QW8tmOlTO/x3isP87ZcC2rrcJPoiwG48
         FEzr7YMqsj8JXCyajXyoFMdtS0Hvuk/hRduR4VNe4pvTC1P0ZG5mT6qBOy+e0JcWuarj
         LiJkYgUjpKVi4GOjp57T1BUwU08QdO10J6GcnSOagrwhVgKCg0Z2CJEq9Nt6tqPeY1of
         Felw==
Received: by 10.204.131.87 with SMTP id w23mr10900726bks.73.1351686573954;
 Wed, 31 Oct 2012 05:29:33 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Wed, 31 Oct 2012 05:29:33 -0700 (PDT)
In-Reply-To: <20121031095327.GB18557@m62s10.vlinux.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208813>

On Wed, Oct 31, 2012 at 5:53 AM, Peter Baumann <waste.manager@gmx.de> wrote:
> Dropping the Cc list, as this is off topic
>
> On Tue, Oct 30, 2012 at 11:05:29PM -0700, Jonathan Nieder wrote:
>> Sverre Rabbelier wrote:
>>
>> > Thanks for the thorough explanation. Perhaps some of that could make
>> > it's way into the commit message?
>>
>> It's fine with me if it doesn't, since the original commit message
>> covers the basics (current behavior and intent of the change) in its
>> first two paragraphs and anyone wanting more detail can use
>>
>>       GIT_NOTES_REF=refs/remotes/charon/notes/full \
>>       git show --show-notes <commit>
>>
>> to find more details.
>
> I seem to miss something here, but I don't get it how the notes ref
> becomes magically filled with the details of this discussion.
>
> Care to explain?

If I have an email thread I'd like to store alongside a commit I'll
put that into a note, but I usually don't push that kind of thing out
to a remote repo.
Does that help?

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
