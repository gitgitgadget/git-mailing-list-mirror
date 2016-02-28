From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] git-p4: map a P4 user to Git author name and email address
Date: Sun, 28 Feb 2016 18:05:54 +0100
Message-ID: <F97BFD52-C258-4B8C-A380-6F0240FDE7F8@gmail.com>
References: <1456655125-17829-1-git-send-email-larsxschneider@gmail.com> <CAPig+cTCZ_diLH+tge6bis6gjq0Qvk05zD7zqf1PBJxNTJu9bw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Lars Schneider <lars.schneider@autodesk.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 18:06:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa4nD-0007Cw-Mu
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 18:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758860AbcB1RF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 12:05:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34166 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758096AbcB1RF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 12:05:58 -0500
Received: by mail-wm0-f65.google.com with SMTP id p65so6312879wmp.1
        for <git@vger.kernel.org>; Sun, 28 Feb 2016 09:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ebMdzqtOuVwcHOYH19lkwyIoLv3z+0sTy1GFUW1BERo=;
        b=hmwF5IJKblm7993lb0uK2NgNlA6Zq5ISkuBIf9J980VGGFjNg1sO0f6RVoHikJwiuE
         qeeiL2viCJ8aRA7leWye/NQfBtyAP8GsMC4D/1B720szgqb/nkjkonvg2jTjXLWivE0T
         BN3YwhKpmzxF514P8sXFnCkQhP65V0pagJIjLN3Y6r37yuxMNmhNnhKf+cn5kj+vjxUE
         XBlfrsP0DPJSjmwSS3ZdgDJx+bjz+T01yMLs4QzIIRSsWU2USyh+e/NcM4+pGeF7+RAu
         roSwmWOYsfiFyWB4tr/2xXXfz5tmoA0FsqwBOnt8H1bjW9ORdAFzrO+HGULD1ZOq3Oid
         rbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ebMdzqtOuVwcHOYH19lkwyIoLv3z+0sTy1GFUW1BERo=;
        b=L/q/87AR5KNMIO5Q+hyxbar5qAm94NBntQP1peJgEHqWEzv4ZtnBp/YE6Dx2Hm4rBn
         kOr0KHmF/hazTV7/nmVb1C1nXIq0u8/J5aFXfcy/Iq1wDfNYz8uvJ6drCHXKrPHx6Oxt
         qwqIVt2Pb/5m+o0cDKVthP9e+OP9EHXXQc65LrB99KZK0FIm8piwe7n+3Pe3lRG/XyGz
         aeCpwQ5V14QPh3x8Tmfg4t2pGPceDFtmfuaPG5y03pc8eiP3YQ3c+9RxtTk/MspbRvnc
         djEBFBeHgmMo/AvBvNGVQMiMB39u44C9aXZ20SRFZcjptT+FiKQ0rVgfHT1jUdC/pC14
         by9g==
X-Gm-Message-State: AD7BkJIV3dsevpabb427Ku9oGerg3RwJ/sJe/xggxW4B+R6m2jAsK1I1sN0tu8ZSiY2EWw==
X-Received: by 10.28.4.210 with SMTP id 201mr636032wme.51.1456679157535;
        Sun, 28 Feb 2016 09:05:57 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4692.dip0.t-ipconnect.de. [93.219.70.146])
        by smtp.gmail.com with ESMTPSA id g3sm21946525wjw.31.2016.02.28.09.05.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Feb 2016 09:05:56 -0800 (PST)
In-Reply-To: <CAPig+cTCZ_diLH+tge6bis6gjq0Qvk05zD7zqf1PBJxNTJu9bw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287777>


On 28 Feb 2016, at 17:19, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Sun, Feb 28, 2016 at 5:25 AM,  <larsxschneider@gmail.com> wrote:
>> Map a P4 user to a specific name and email address in Git with the
>> "git-p4.mapUser" config. The config value must be a string adhering
>> to the format "p4user -> First Lastname <email@address.com>".
> 
> With the caveat that I'm not a Perforce user, is this arrow "->"
> thingy common in the Perforce world, or was it invented with this
> patch? If it was invented here, then would it make sense to instead
> use a more established format, such as the "authors" mapping file from
> git-svn?
> 
>    p4user = Joe User <user@example.com>
I invented "the arrow" here :-)
I didn't know about the SVN format and I agree it makes sense to reuse
an established format. I will fix this in a reroll.


> 
> More below...
> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> @@ -553,6 +553,17 @@ git-p4.keepEmptyCommits::
>> +git-p4.mapUser::
>> +       Map a P4 user to a name and email address in Git. Use a string
>> +       with the following format to create a mapping:
>> ++
>> +-------------
>> +git config --add git-p4.mapUser "p4user -> First Last <mail@address.com>"
>> +-------------
>> ++
>> +       A mapping will override any user information from P4. Mappings for
>> +       multiple P4 user can be defined.
> 
> Does this format correctly with Asciidoc, or does the pargraph need to
> be left-justified? (I haven't tested it myself.)
I am not exactly sure what you mean. The last paragraph is already left
justified, no? Do you know a good tutorial for Asciidoc? How can I/should
I check these things?


> 
>> diff --git a/t/t9828-git-p4-map-user.sh b/t/t9828-git-p4-map-user.sh
>> @@ -0,0 +1,61 @@
>> +#!/bin/sh
>> +
>> +test_description='Clone repositories and map users'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_expect_success 'start p4d' '
>> +       start_p4d
>> +'
>> +
>> +test_expect_success 'Create a repo with different users' '
>> +       client_view "//depot/... //client/..." &&
>> +       (
>> +               cd "$cli" &&
>> +
>> +               >author.txt &&
>> +               p4 add author.txt &&
>> +               p4 submit -d "Add file author\\n"
> 
> Broken &&-chain.
Oh. You're right. Will fix!

Thanks for the review,
Lars
