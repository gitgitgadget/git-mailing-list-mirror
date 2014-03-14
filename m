From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: Committing a change from one branch another branch
Date: Fri, 14 Mar 2014 15:04:25 +0530
Message-ID: <CAD6G_RT5mBWUKz18ZkSQkKiMnz8WXRK7scb+_xAscYQX4zR9xw@mail.gmail.com>
References: <CAD6G_RRQVDxQj==-2vAT3WCiYMC=BmZhi__JWi4yy86Uaoa-og@mail.gmail.com>
	<CANUGeEZc8BoV0MxUGRRGc8SK=-xB2YXoEkRkBTyGZ8FxSjnVTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Brandon McCaig <bamccaig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 10:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOOVf-0001FX-QF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 10:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbaCNJe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 05:34:28 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:50928 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907AbaCNJe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 05:34:26 -0400
Received: by mail-yk0-f171.google.com with SMTP id q9so6005242ykb.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L0+EMQZOVYNo1TIQX7rh5UJi/D0fVAuYQWQmpmzYs2c=;
        b=i3W2gLOVajxd3B4+49aMtbMqgy/sVFRNke3ucK8EzSgZY6W9vF4H0H5nUTCiTmmqy6
         ghmCRzaxGqvvqRDd/TW8Arau/SwBRZBqffGdHTB1HodchT2FHRcMwdpmtjY7ygBIcNGF
         z+0UQna53rKLfTqTZDBMqtisTpnredHZUToVBtmTzpPsvtdhrgpOCki2nlKMPtwsI/qs
         LfgFQLW1xOEhaMJBWybTZR2xNHQwRAxf65L5GylUufCIEoEXvSe8slQ0+DGUYc25TpJp
         SZrNk0eB3Td76zy6CjUdOE7RD7KGnnUDcM6jtPpxpTdzdMs8bG2mc+NN32yq2uxCBcWV
         GUhQ==
X-Received: by 10.236.39.51 with SMTP id c39mr462505yhb.128.1394789665903;
 Fri, 14 Mar 2014 02:34:25 -0700 (PDT)
Received: by 10.170.34.215 with HTTP; Fri, 14 Mar 2014 02:34:25 -0700 (PDT)
In-Reply-To: <CANUGeEZc8BoV0MxUGRRGc8SK=-xB2YXoEkRkBTyGZ8FxSjnVTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244084>

Hi Brandon McCaig,

On Thu, Mar 13, 2014 at 9:06 PM, Brandon McCaig <bamccaig@gmail.com> wrote:
> Jagan:
>
> On Thu, Mar 13, 2014 at 4:56 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
>> Hi,
>
> Hello,
>
>> I have two branches.
>> - master-b1
>> - master-b2
>>
>> Suppose I'm in master-b1 then did a change
>> on master-b1
>> $ git add test/init.c
>> $ git commit -s -m "init.c Changed!"
>> $ git log
>> Author: Jagan Teki <jagannadh.teki@gmail.com>
>> Date:   Thu Mar 13 00:48:44 2014 -0700
>>
>> init.c Changed!
>>
>> $ git checkout master-b2
>> $ git log
>> Author: Jagan Teki <jagannadh.teki@gmail.com>
>> Date:   Thu Mar 13 00:48:44 2014 -0700
>>
>> init.c Changed!
>>
>> How can we do this, any idea?
>
> What you're asking is ambiguous and vague. The example output that you
> give doesn't even really make sense. You need to give more details
> about what you have and what you want to do to get proper help.
>
> Or join #git on irc.freenode.net for real-time help if you aren't sure
> how to explain it.

I tried #git irc channel, looks like I'm facing some firewall issue on my end.!
OK - Let me explain my query again.

I've a git repository with 2 branches.
- master-b1
- master-b2

I have to work both these branches since I need two different deliveries.

master-b1 have a contents of
joo_v1/test.txt
joo_v2/test.txt

master-b2
joo/test.txt

Here, joo_v2 on master-b1 is same as joo on master-b2 means the latest updates
on master-b1 with <DIR_NAME>_<VERSION> becomes <DIR> on master-b2

Suppose, if user is change the contents on joo_v2 on master-b1 will change
the contents on joo on master-b2 (files contains particular directories are same
name with same contents - joo_v2/test.txt and joo/text.txt)

The moment user commit the change on master-b1 will create a commit on master-b2

Please let me know if you still need any more information.
I will come to IRC soon, for more discussion.

thanks!
-- 
Jagan.
