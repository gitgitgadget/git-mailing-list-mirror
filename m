From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 08:48:13 -0800
Message-ID: <CAJo=hJs-SaDEmbdWO_NqWQNQBVDszPYx6b50ARytCNwVDZaRwg@mail.gmail.com>
References: <20140225154158.GA9038@sigill.intra.peff.net> <CACsJy8Bw7JqokgGt46T7Xivk08F-DS4Dj-j1PWxoStu=cVzo5w@mail.gmail.com>
 <CAFFjANRqKqq_f9SCR4vP3YKUpfk1J2RQdB9G4gnY2OcZivzhXQ@mail.gmail.com> <20140226113028.GB3599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 17:48:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIhf0-0000xe-VE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 17:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995AbaBZQsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 11:48:38 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:65509 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaBZQsh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 11:48:37 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm4so6145231wib.14
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hkS1b9GcQLs2r6Y/V8gJX8xxO2/i9yY7GVaDIr/PY+g=;
        b=WobOCsLVDZ2BtbzuLbk9gQo1Xxz3bgpRzgEIxznhuyilJiBgqeQJS4GarMZ1ivXNTk
         7h86q+WBEPDc4u6gVO+4Tp7wyiy1zJ06QpWIhP3DlZmxbWUSJZbfffVLDrRoMKnzp0pn
         hWMbdZRlq0qqZtosDggvQho45ohm9R0R0Ci3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hkS1b9GcQLs2r6Y/V8gJX8xxO2/i9yY7GVaDIr/PY+g=;
        b=IoqUpdDgcp5nA3eaRybyNQavUfm8X4Qv5XhDSpJ94iJ3wOSf7xW1CpKppHa5nHddE0
         2Ze/R9fUTLIpp/UMpa+qjWWZvbKb+7aJBT4xwiXXsX1AOK5WPe3m4+CNAtrctJfKJ6w6
         792BAVqZd8cLe51tJVdt0lOpVvkAwGNKl8TXYoYlE9U+EpOm+bB5R7xSGpcCK8K6BWUw
         CLAnfk/FBEfoYWzBwCGUEYl13wcb+UgHKveWLIYJOSXNYollRu+ltJsfRCbcv3Gn5CWp
         XaJsXcn5w6hmIbRYJsEsXtAl6SsmGAWxK3Mgq4goGpx0TjcK3yls9Q4AFtYOj4rJpBR5
         XfZg==
X-Gm-Message-State: ALoCoQlCXXgehNvDJDLmzagTRpjImFH5aA1zDV7aA7nrlVt+DFaqKQ+WHLpQGjNmTNSj+TnAOJ0v
X-Received: by 10.194.90.177 with SMTP id bx17mr773635wjb.91.1393433313587;
 Wed, 26 Feb 2014 08:48:33 -0800 (PST)
Received: by 10.227.7.132 with HTTP; Wed, 26 Feb 2014 08:48:13 -0800 (PST)
In-Reply-To: <20140226113028.GB3599@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242737>

On Wed, Feb 26, 2014 at 3:30 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 26, 2014 at 12:24:13PM +0100, Vicent Mart=ED wrote:
>
>> > One thing I noticed after tg/index-v4-format is both libgit2 and j=
git
>> > do not seem to support index v4. So we could add "index v4 support=
 on
>> > libgit2" to the idea page. It's a relatively small task though onc=
e
>> > you get a hang on index format.
>>
>> That sounds like a nice task for the Summer of Code too, specially
>> with the current effort to make Index v4 more visible in Core Git.
>
> Yeah, I'd agree. Want to write it up?
>
>> I wonder if anybody from JGit would also be interested on mentoring
>> for the equivalent task (index v4 on JGit). I've CC'ed Shawn Pearce.
>
> A project that added to both libgit2 and JGit would be cool, but I do=
n't
> know if that is asking too much of the student (multiple languages an=
d
> projects is going to increase the time spent on non-code friction).

I agree, its too much to ask from a single student to add it to both pr=
ojects.


As far as JGit supporting index v4, I am holding my breath and waiting
for index v5. We keep spinning through dircache versions with
relatively little gain for each one, but a lot of complexity. As it
was a prior version was sort of a disaster with the fixed length
portion of records being either 62 or 64 bytes depending on a bit set
per record. Yuck. I haven't been reading every message in the v4 topic
but nothing impressed me as being worth my time to implement in JGit,
other than to be compatible with a version of git-core that won't land
in Debian stable for at least 2 more years.
