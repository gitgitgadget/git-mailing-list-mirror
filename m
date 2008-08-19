From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 17:45:02 -0700
Message-ID: <905315640808181745n7186aa1bu62f6d454255fd805@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	 <alpine.LNX.1.00.0808182027240.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:46:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVFMO-0003Q7-KS
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbYHSApF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYHSApF
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:45:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:29233 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYHSApD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:45:03 -0400
Received: by wx-out-0506.google.com with SMTP id h29so2555071wxd.4
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 17:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=+gaDF8SBQstOuZEkNAOX/eePZ2UV87M2m9CXNi4N3AE=;
        b=xEUlOSx3VmJlZ+m6hhkeD3h592/MlptqnikO0jlj0VkdFZ5RGWow3IyO3LqHitXfHR
         lTP39jMi3VvBfDiXZrpZ1Mi1wj6bv+XlZkhY8/hPAj5F0peTJXczpe4aQrhp4/rW7FF7
         aonTMhM0Di9/hq3XIn6WONGYo0v2f6Lkv+fvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=rs7p85h46zF/vseE8acQLFTOwDCQazptphDqKwgO5JvK8uYINW1Bo33bS2qFNyZ5vQ
         bsu6IOXM3fHdzsxsMKngTp5dcIzIBWts7ieMNwP0kg99Qg76O+1nNl5Q9WGlteubfXwl
         sKYOWv1HXJ0vsHLAODnchZF5Th0w33ynIjOE0=
Received: by 10.70.73.12 with SMTP id v12mr8566805wxa.57.1219106702336;
        Mon, 18 Aug 2008 17:45:02 -0700 (PDT)
Received: by 10.70.62.15 with HTTP; Mon, 18 Aug 2008 17:45:02 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0808182027240.19665@iabervon.org>
Content-Disposition: inline
X-Google-Sender-Auth: 9da5a6507fcbc3a5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92797>

On Mon, Aug 18, 2008 at 5:32 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Mon, 18 Aug 2008, Tarmigan wrote:
>
>> On Mon, Aug 18, 2008 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > (2) Some concepts in git are different from what they are used to, without
>> >    any good reason.  IOW, the concepts have room for improvement, and our
>> >    UI is based on these faulty concepts.
>> >
>> > (3) Some concepts in git may be exactly the same with other systems, yet
>> >    our UI may operate differently from them without any good reason.
>>
>> One confusing part of the porcelain may be the way that git's revert
>> is different from other systems' revert.  What would people think
>> about something like this somewhere in git-revert(1)?
>>
>> +DISCUSSION
>> +----------
>> +If you are more familiar with another SCM, 'git revert' may not do what you
>> +expect.  Specifically, if you want to throw away all changes in your working
>> +directory, you should read the man page for 'git reset', particulary the
>> +'--hard' option.  If you want to extract specific files as they were in a
>> +previous commit, you should read the man page for 'git checkout -- <filename>'.
>
> "as they were in a particular commit"; it works for the current commit as
> well as older ones. And skip the first sentence; even people who aren't
> familiar with another SCM are reasonably likely to be attracted by the
> name "revert" as being descriptive of what they want to do.

Good points, thanks.

> I think this is a good idea, although clever placement is necessary to
> neither distract people who really do want "revert" nor get missed by
> people who are looking in the wrong place.

Yes, I actually didn't include any context because I wasn't sure where
to put it and was hoping for feedback on that front as well.
git-revert(1) is very short as it is, so I would be inclined to put
the DISCUSSION fairly early, like between the DESCRIPTION and the
OPTIONS so it is very easy to find.  But it seems incorrect to put it
before the options.  Perhaps that text should just be a note in the
DESCRIPTION?

Thanks,
Tarmigan
