From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Local git repository url
Date: Thu, 19 Nov 2015 14:26:53 -0800
Message-ID: <CA+P7+xpq+ebnYqUaszBEuWz90rbuBCoBx=fC6sPiM6kcZXggOA@mail.gmail.com>
References: <7EF33D3D8E1EA14DB720C3BF1B7A24A80F36F32D@PLYEXM02.customer.edfenergy.net>
 <7EF33D3D8E1EA14DB720C3BF1B7A24A80F36F357@PLYEXM02.customer.edfenergy.net> <20151119140645.7f6c856efc66bd88160fd0c1@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Vambara, JayaPrakash (Infosys)" <JayaPrakash.Vambara@edfenergy.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:27:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzXfk-0000jg-9A
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 23:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934628AbbKSW1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 17:27:14 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32908 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934604AbbKSW1N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 17:27:13 -0500
Received: by igvi2 with SMTP id i2so21584123igv.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zl2WTAWKMAthTdh9wfSJXWNst32MPWGf90PZMl5k94c=;
        b=xt1GSZIpPC3FOa13xx9vUR6l8NiXkyySIksZS0a9ypsqDlFwgaXx4jfWNC/Rlk38a6
         s0F9MGrDnHHqoRH07xBp3bU215Vi6PaABi1QzCH6L/0GKQWLxbkOX2tNJvhx+n+v8OJH
         ++mCnX/O2ZllxxhNFadan0pyfRhA/gn1YPSQcNaYHJhD7wSR7lY2PlL4ny7J2mKi2/yB
         336u9IYoBGRUusvZ01ofsmcGWpO2DUqI7FAgg1LFqBrOc3JcNpIYe/pj+alBW3DPG2dl
         mx0r1ora4Xbu/SUp5Pt6unua6kI0H1L1KuQRAcTMhr6dLC8FHFr1VCRr5e61wqAO+35n
         a9ig==
X-Received: by 10.50.79.135 with SMTP id j7mr152231igx.73.1447972033207; Thu,
 19 Nov 2015 14:27:13 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Thu, 19 Nov 2015 14:26:53 -0800 (PST)
In-Reply-To: <20151119140645.7f6c856efc66bd88160fd0c1@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281493>

On Thu, Nov 19, 2015 at 3:06 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> On Thu, 19 Nov 2015 10:48:51 +0000
> "Vambara, JayaPrakash (Infosys)" <JayaPrakash.Vambara@edfenergy.com>
> wrote:
>
>> I am trying to setup a local git repository and manage it from local
>> Jenkins set-up. So, both Jenkins and git are on my local desktop.
>>
>> However, I am trying to give the Repository URL but with no luck.
>>
>> My repository is in D drive in location D:\Git-Try
>>
>> I tried to configure this Repository URL as --- file:///d/Git-Try
>>  also file:///D:\Git-Try , but was not successful.
>>
>> Can you please let me know what should be the Repository URL.
>>
>> I have created the db in above location, pushed few files and
>> commited them as well.
>
> Try D:/Git-test first.
>
> Otherwise it might heavily depend on how Jenkins interprets those URLs
> and whether it even uses stock Git to access the repository (and not
> something else like JGit).
>

Jenkins Git plugin uses Git-for-Windows CLI by default. You should be
safe using any URL which works for git CLI locally. If not, I suggest
filing a bug against the Jenkins git plugin to help ensure it gets
fixed :)

Regards,
Jake
