From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 16:23:43 +0200
Message-ID: <CAGK7Mr4g3j80R4P_wpfNip9vxvaDg4q_3Utq9KVvKtbdhVutfQ@mail.gmail.com>
References: <53588f448d817_59ed83d3084e@nysa.notmuch> <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch> <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch> <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch> <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch> <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Apr 25 16:24:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdh39-0003gQ-7w
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 16:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbaDYOYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 10:24:16 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38660 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaDYOYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 10:24:14 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so4341132obc.16
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TEZGtl2mIFvs8ID13M4DzdlSfGw3pnvUpA40ZwOvuCo=;
        b=vB1saUlGITQ4o1reNWorIaJkdgM8FeJjehSnkuLsH2Xn94RFHnkb4/bhTSG1IXCAqN
         AxfsA0m2CPwN9MsroGyY1bdljOfcmnGyu/6viHRagO5L8cUwY7LRIPtBjwWXBNvgZjOE
         UN7Sp9OVEns7Ngq6mi8zjkfYiMzE/IxTXJS+uF0Xx6m/oXEVCWbMJqaqY1YmlhQ2KJyP
         FlWiMYIrKzY+WvvQ9NaZHZ7Uabbsy5PA1UvtWwU+3kduY6jAki1IAxNxATVGyE7/2RT6
         2eogUYr70orrePLkpjk8cSEjD7hy96wZlcZXogcPWI7JmCWKksKptUmBIrVOlIv9H5lI
         aHxA==
X-Received: by 10.182.241.9 with SMTP id we9mr808624obc.81.1398435853759; Fri,
 25 Apr 2014 07:24:13 -0700 (PDT)
Received: by 10.76.85.229 with HTTP; Fri, 25 Apr 2014 07:23:43 -0700 (PDT)
In-Reply-To: <20140425133520.GC11124@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247041>

>> I agree. The "stage area" is a very important concept in git, why not
>> talk git commands that refers to it? Then we could add flags like
>> --new-files or --deleted-files for better granularity than the current
>> --all flag.
>
> One caution: The term "stage/staged" is already a little overloaded.
> We generally use the word "staged" to refer to changes that are in the
> index, but the term "stage" as a noun generally refers to referencing
> the different versions of a file during a merge operation (cf "git
> ls-files --stage").

I agree, but I think it's better than "index" tho. That one is heavily
overloaded and easily confused with other meaning in other softwares.


>> I think starting by documenting the issues is a good idea, maybe on a
>> wiki, and start some draft of a proposed solution that would improve
>> in an iterative process.
>
> And it would be nice if the issues were discussed in a way that
> acknowledged that all changes have tradeoffs, both positive and
> negative, and to clearly articulate whether the concern is just
> someone going "uh, 'index' is a wierd term", but once they learn it,
> it's pretty clear, versus a case where there is continuous confusion
> due to overloaded meanings, or for people for whom English might not
> be the first language.

Yes, of course there should be a list of both positive and negative
tradeoffs. But I think the "overloaded" argument can be easily solved
by renaming one of the overloads.


> And most importantly, to avoid rheteroic.  In fact, given that strong
> use of rhetoric is often used to disguise a weakness of a position
> that can't be defended using logic and data, someone who tries to win
> arguments using the "last post wins" style of discourse, and a heavy
> use of rhetoric, may find that people just simply decide that it's a
> better use of their time not to engage and to just kill the entire
> thread.

Unfortunately yes, I see many people being silly in order to win
arguments, both in the pro-changes and against-changes side of the
discussion. I'd be much simpler to simply gather arguments on some
wiki and eventually do a vote when the list is complete about the
proposed change.

Philippe
