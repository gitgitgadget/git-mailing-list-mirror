From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 12:45:27 -0500
Message-ID: <535a9f375e196_3984aa530c46@nysa.notmuch>
References: <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <20140424195559.GA1336@luc-arch>
 <CALZVapn0gEHc7t2fjk7YGd2o0yfpGLu0JCgUtdREvROC8_mqXg@mail.gmail.com>
 <5359c9d612298_771c15f72f02a@nysa.notmuch>
 <CAGK7Mr6dss7BF-srQ3SqeZe2hAe9nS07fGe--ka1rvC5hXvbSA@mail.gmail.com>
 <20140425133520.GC11124@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Javier Domingo Cansino <javierdo1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 19:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdkM3-0002nM-R0
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 19:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbaDYR4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 13:56:00 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49107 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaDYRz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 13:55:59 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so4609916obc.15
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=kEb2kToOiaMVzB3ot3bjcbhuOUfIOPW6J2hSUywvTFk=;
        b=fPzMTl/lC7UZtelhbuXJIyicj+dHgJylqyIfHFEQO7s/1TKWtazCW6UkkNwh1Rqvbl
         VQAgEvMgJwlxYUd3W/Qiunxr74aqlBAtGhvJdtwaoyKT5TIv1XXDgv2U+U/2yRH21YdI
         8UPb69ouCvbLMSEgrDMzJCCTilU2e8DbExQsuikdjeJ1h3iY8/EVDbBjn7vtKj3fZ+6G
         rBljhCKSy+XJ658VsL4erPUpjwQ9d49sjW7BAxT7CPAtINIGgrowiA8DgXH1o+cwrLjm
         GR4jo3y4tL6rbRk4eARkTqk59I3EMsiRCewMHACrMv59LEJFMYeVTY2/grMuNTqQQKR6
         J8LA==
X-Received: by 10.183.3.102 with SMTP id bv6mr8187713obd.18.1398448558408;
        Fri, 25 Apr 2014 10:55:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id d9sm34467769oen.3.2014.04.25.10.55.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 10:55:56 -0700 (PDT)
In-Reply-To: <20140425133520.GC11124@thunk.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247072>

Theodore Ts'o wrote:
> On Fri, Apr 25, 2014 at 09:48:53AM +0200, Philippe Vaucher wrote:
> > 
> > I agree. The "stage area" is a very important concept in git, why not
> > talk git commands that refers to it? Then we could add flags like
> > --new-files or --deleted-files for better granularity than the current
> > --all flag.
> 
> One caution: The term "stage/staged" is already a little overloaded.
> We generally use the word "staged" to refer to changes that are in the
> index, but the term "stage" as a noun generally refers to referencing
> the different versions of a file during a merge operation (cf "git
> ls-files --stage").
> 
> > I think starting by documenting the issues is a good idea, maybe on a
> > wiki, and start some draft of a proposed solution that would improve
> > in an iterative process.
> 
> And it would be nice if the issues were discussed in a way that acknowledged
> that all changes have tradeoffs, both positive and negative,

They have been discussed at length:

http://thread.gmane.org/gmane.comp.version-control.git/197111
http://thread.gmane.org/gmane.comp.version-control.git/166675
http://thread.gmane.org/gmane.comp.version-control.git/115666
http://thread.gmane.org/gmane.comp.version-control.git/236127

When I say literally everbody agreed to move away from the name "index" (except
Junio and another guy) I mean it. I even composed a list:

http://article.gmane.org/gmane.comp.version-control.git/233469

Jeff King, Jonathan Nieder, Matthieu Moy, they all agreed.

> or for people for whom English might not be the first language.

People whom English is not their first language also agreed "index" is a
terrible term.

-- 
Felipe Contreras
