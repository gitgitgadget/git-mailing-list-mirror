From: Chris B <chris.blaszczynski@gmail.com>
Subject: Re: git push --quiet option does not seem to work
Date: Sun, 15 May 2016 16:34:08 -0400
Message-ID: <CADKp0pwrKzHG7KVSMH+6OHuv9sKXTcKSsdKMEZ_fFdjWT+kW6g@mail.gmail.com>
References: <CADKp0pwHKvfSDG_-4p5tUn0_QiUGKzmRj5RwphfA8sZ_7CVHqw@mail.gmail.com>
 <20160513223336.GA18287@sigill.intra.peff.net> <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 15 22:35:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b22kc-0003pM-2F
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 22:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbcEOUet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 16:34:49 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35764 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbcEOUet (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 16:34:49 -0400
Received: by mail-io0-f172.google.com with SMTP id d62so189192655iof.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ee0yss7UlzafeMexhdehDlcODT/w0+ZMJhAhXNfSld8=;
        b=O5GCGin0MCWhW6wVGF1E6VUct2DK/QrOjDrjZpzi1bbnyouruLG/37rs+u8OdLIhvI
         mDw1Y8DuNY2+PLrGkZIXael427BeEaaS1WQ9U0Xsz56hjdWI9+R8znQP3/y3eRlviPdM
         4gCKdfhjauybIk9ilf9GovGxXUVDmCKK8150LutqcCuDk2IIckO0bUPKK40WqPwFzG/+
         Ikkr2FGC93yIpWeNUSVrCq4q04+GVfLRa4TL3yIxJKrngB5KBWVyoQ2OsnzQ5XyAaSi3
         xjfnMkQI56h7vLfOUsGBigjgJicDHmM/CML1CbTMGtl6L5XYx6YID/bPkPkrZB5PlLqR
         qK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ee0yss7UlzafeMexhdehDlcODT/w0+ZMJhAhXNfSld8=;
        b=PhbRw8IuuKk12aGF/qxxQM+qnUZ7oGPTpSsHgSEgwWzt8A+iHmh+eKpwiGcAeA2H4S
         2oc5bUahcHmam0YXOTwM5horXNrZH2c+of/9NWhIJhPH+xFmny3qCXc/rRD7D7PTfwnT
         H9iQjzGbdljmMJtOF+XrCk9ReLEwRScaGH/MYdc3HldZhQM5gaJeaTVQm6DFl0ir40E4
         qV0HREKvdvNoTat9GReQNNoO7kDN90TLx7QDLE2Gzj0XA5kZikWSBlNJBSd2udLaa8vL
         LOSbIAtjhRDJamSHdtmOwlqyt8JL3eX9+WNcYroeotk7HPTEFFuqZmumRNik3gZU23Jj
         PQeg==
X-Gm-Message-State: AOPr4FVFfecAZF6mw0OxQ9Wos+vz0RyOlH57RcJ8zGrhczUeD4VhUqy6VZ9zi9vcHnhjHP4L77EZCYdZGZjHnA==
X-Received: by 10.107.38.79 with SMTP id m76mr20090014iom.7.1463344488164;
 Sun, 15 May 2016 13:34:48 -0700 (PDT)
Received: by 10.107.20.88 with HTTP; Sun, 15 May 2016 13:34:08 -0700 (PDT)
In-Reply-To: <CADKp0pw5FFDVvPz0CcjOTYteQ9jFn2jBZwaX6_n8r3UQRGcGdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294683>

By the way, I also notice by your prompt you seem to be testing this
in Linux. I did indicate I'm using the Windows version. That might
make a difference.


On Sun, May 15, 2016 at 4:29 PM, Chris B <chris.blaszczynski@gmail.com> wrote:
> Try it by making some changes to files and committing them, and then push.
> It works fine for me when there is nothing to actually push, but not
> so when there are commits to push.
>
> It always outputs the progress to STDERR even when I add --quiet.
>
>
>
> On Fri, May 13, 2016 at 6:33 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, May 13, 2016 at 05:21:30PM -0400, Chris B wrote:
>>
>>> Hi I am using 2.8.2.windows.1 and writing Powershell scripts doing
>>> some Git stuff.
>>>
>>> I have to use the --quiet option for git because it constantly outputs
>>> progress to stderr.
>>>
>>> However, it seems that --quiet does not actually work in git push. The
>>> output still goes to stderr.
>>> When there are changes committed to push it always outputs something
>>> to stderr. If there is nothing to push, then it actually is silent.
>>
>> Can you be more specific? It seems to work for me:
>>
>>   $ rm -rf dst.git &&
>>     git init --bare -q dst.git &&
>>     git push dst.git
>>   Counting objects: 6, done.
>>   Delta compression using up to 8 threads.
>>   Compressing objects: 100% (3/3), done.
>>   Writing objects: 100% (6/6), 441 bytes | 0 bytes/s, done.
>>   Total 6 (delta 0), reused 0 (delta 0)
>>   To dst.git
>>    * [new branch]      master -> master
>>
>>   $ rm -rf dst.git &&
>>     git init --bare -q dst.git &&
>>     git push -q dst.git
>>   [no output]
>>
>> Are you seeing progress reporting, the status table, or something else?
>> Are you using a particular protocol that might invoke a git-remote-*
>> helper that doesn't respect the quiet flag?
>>
>> -Peff
