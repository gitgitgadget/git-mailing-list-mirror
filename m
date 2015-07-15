From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] gitk: Add a "Copy commit summary" command
Date: Wed, 15 Jul 2015 19:58:01 -0400
Message-ID: <CAPig+cTf3WDHf++Ck-SXgY4LRm7WRLLk2BvewUQZktfdpHL4BA@mail.gmail.com>
References: <1436892150-24267-1-git-send-email-dev+git@drbeat.li>
	<CAGZ79kaB-vrarcCztD_7x5M1_dHWwMy=6vQ5EHHsWTJTWEyhOA@mail.gmail.com>
	<1436999097.12921.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "sbeller@google.com" <sbeller@google.com>,
	"dev+git@drbeat.li" <dev+git@drbeat.li>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"paulus@samba.org" <paulus@samba.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 01:58:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFWYy-0000K3-69
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 01:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbbGOX6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 19:58:03 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36625 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbbGOX6C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 19:58:02 -0400
Received: by ykay190 with SMTP id y190so50870878yka.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 16:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=U2Ibk3jTLfsW1jZcTjPntX6sGcVSYwG2CM0tQmZ1Pz4=;
        b=EtCmYNoWPu3zqYEYygtGBK8sBYc0dR65d15vCFa9gJM7mLJcW504b1JFoBPrXC9d8E
         HT5M4TA5yqYT3tcVumE+lQHLwzCljQrhB7APqt7KGzkgiXEbFx8SQbZBd/woYkWcfekw
         IIbK12HtHeZdSThdKeJW62gzHnPHdZKkl1Bis9Nfs+UZNEApXzUXCbk8PRn7Liogk3Fp
         s9RFQQm3F7bgSJla6UNUfRyKylvdmyTGJFXNrNrxEJTVzaW/z+rLBdN2mVT2z2c0ueRq
         YdYBgKBcntgTJkr6VUO68r5NtLcKW2KazQ99qApu61Lq/GwEF1MPxOlUFetFdpZSA/9T
         ogjg==
X-Received: by 10.13.207.1 with SMTP id r1mr6980747ywd.166.1437004681255; Wed,
 15 Jul 2015 16:58:01 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 15 Jul 2015 16:58:01 -0700 (PDT)
In-Reply-To: <1436999097.12921.2.camel@intel.com>
X-Google-Sender-Auth: Vhx2GXaeX4wAO6HvgtMrCO8aWuA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274002>

On Wed, Jul 15, 2015 at 6:24 PM, Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
> On Tue, 2015-07-14 at 13:34 -0700, Stefan Beller wrote:
>> On Tue, Jul 14, 2015 at 9:42 AM,  <dev+git@drbeat.li> wrote:
>> > From: Beat Bolli <dev+git@drbeat.li>
>> >
>> > When referencing earlier commits in new commit messages or other
>> > text,
>> > one of the established formats is
>> >
>> >     commit <abbrev-sha> ("<summary>", <author-date>)
>>
>> That sounds like I would use it a lot! Thanks :)
>>
>
> Yep, quite useful. Also, the kernel suggests using it as a tag like so
>
> Fixes: <abbrev-sha> ("summary")

Dropping the literal word "commit" would make this use-case more
convenient, as well as the typical use-case when composing commit
messages: "Since <abrrev-sha1> ("blah", <date>), foobar.c has
flabble-nabbered the wonka-doodle..."
