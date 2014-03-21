From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2] branch.c: simplify chain of if statements
Date: Thu, 20 Mar 2014 20:44:09 -0400
Message-ID: <CAPig+cS2rQSAPVEN6bzSNnjFoEzf9fyBA7X7P9+cmBFOsfA1xg@mail.gmail.com>
References: <1395071493-31435-1-git-send-email-dragos.foianu@gmail.com>
	<CAPig+cS9QApn1T3-R8n+W+1ee9FbNftsmhrr90SJKs+gqzvC5A@mail.gmail.com>
	<CAPig+cQKHQFNBob18g9UmZuE_mOpF3UMCBPfSKJYEYQpk1Z_tw@mail.gmail.com>
	<loom.20140320T001131-702@post.gmane.org>
	<CAPig+cQpO+0hfqVKCzi1DwbosQ=smK=JiTPcYM8iP4r7VnSKjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 01:44:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQnZh-00005S-Qq
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 01:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966583AbaCUAog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 20:44:36 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:54347 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965786AbaCUAoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 20:44:10 -0400
Received: by mail-yh0-f48.google.com with SMTP id z6so1706301yhz.21
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 17:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6P9Hn62Hn4ltOeBgM0RQIppvcxmluY4OsgcmfOF6oi8=;
        b=Bpt3Tvk8UaQjP+aByQfv6ifgFpfzwvBj4jqWUC/rdDff34bABm/cci1+dbgQWS9SaI
         MFECpaQuFDZLaONzfdsnLQ2RWJREH37AujGhZ6eNjsKaoBhufA1kqTnaL3JX5gcgIr1e
         JZbTNEFUGjuYZKlFLNCBN3U1cjFyM43f7GAfTejILpHyvJE+DP4sqLIXKfpYQ45gf7fH
         Q2gb6U2/rxIWTR6M9gH3Q2y87AEpRE1QmvRdWGFlv74XmHacfTxdJP60dVgCtUFgZ5Q9
         DEt9D3LiEvZLzG+43G/eSkTXmNI/a9WIuQ1Z0HCQF6i6lDvrUIu0RyczHpqB8TRXFTvm
         4U/w==
X-Received: by 10.236.113.194 with SMTP id a42mr22065301yhh.116.1395362649385;
 Thu, 20 Mar 2014 17:44:09 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 20 Mar 2014 17:44:09 -0700 (PDT)
In-Reply-To: <CAPig+cQpO+0hfqVKCzi1DwbosQ=smK=JiTPcYM8iP4r7VnSKjQ@mail.gmail.com>
X-Google-Sender-Auth: 5NJh5o8KyJqxO7OctPVP__pvmFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244624>

On Thu, Mar 20, 2014 at 8:40 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Mar 19, 2014 at 7:12 PM, Dragos Foianu <dragos.foianu@gmail.com> wrote:
>> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>>> On Tue, Mar 18, 2014 at 6:31 PM, Eric Sunshine <sunshine <at>
>> sunshineco.com> wrote:
>>>
>>> One other observation: You have a one-off error in your out-of-bounds
>>> check. It should be 'index >= sizeof...'
>>
>> Well this is embarrassing.
>
> It's a good illustration of the value of the review process. It's easy
> to overlook omissions and problems in our one's work because one reads
> it with the bias of knowing what it's _supposed_ to say. Reviewers
> (hopefully) don't have such bias: they read the code afresh.

And, this is a perfect example. I knew that I wanted to say "problems
in one's own work", and even though I proof-read, I still missed that
I wrote "problems in our one's work".
