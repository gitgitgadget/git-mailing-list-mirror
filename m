From: Christian Couder <christian.couder@gmail.com>
Subject: Re: gitk won't show notes?
Date: Tue, 14 Apr 2015 14:17:38 +0200
Message-ID: <CAP8UFD1GRhjgcEomKN4mjxd-+wG0RabbTO=RTk1okCkU2u0FVg@mail.gmail.com>
References: <551D99B9.7040200@ubuntu.com>
	<5523DE66.8060904@drmicha.warpmail.net>
	<5523E479.2010701@ubuntu.com>
	<5523E5FF.8060101@drmicha.warpmail.net>
	<55240F0A.80902@ubuntu.com>
	<5525164C.6000309@drmicha.warpmail.net>
	<20150411103156.GA5781@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Phillip Susi <psusi@ubuntu.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 14:17:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhzmn-0007IP-ST
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 14:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbbDNMRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 08:17:46 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36684 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbbDNMRj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 08:17:39 -0400
Received: by igblo3 with SMTP id lo3so71917178igb.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c8o1eO0IJIw9MlaEGdwRXi35jjrSSgXLgQVPR+34kuM=;
        b=u1tE8C8K3w9N3h2X3GgabIQeFr8A5f+C3DXRmG0f3HHq+kzLpc3KdbdFdmwM+xQYzy
         /nemiLcyrTfjlHWTkN9EzZxqYPfH6NC0Waq2ABIGMVDvWifGJQOslWbbk/ZGY0AWKhW3
         ejIwDaK/3J4aEvyjzbBLXMJyaGRdlCx0S48N+vxUsA7/W1SdkWijrh6IEWuYORw7eMYm
         3qh21cS6Mefv13leGHMF/0DMYIlKPfQmdodXWi79iDSTehUt6hSrPZWZKWh6ZmGPGa49
         +YgYP+vTm0IFAblS6HgYTZ2mWH8wEYhjesxrn/pGR1TB1ffezbm4W3tJChHkZoihNzTU
         oCTQ==
X-Received: by 10.107.130.165 with SMTP id m37mr27175393ioi.62.1429013858901;
 Tue, 14 Apr 2015 05:17:38 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Tue, 14 Apr 2015 05:17:38 -0700 (PDT)
In-Reply-To: <20150411103156.GA5781@iris.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267138>

On Sat, Apr 11, 2015 at 12:31 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Wed, Apr 08, 2015 at 01:51:40PM +0200, Michael J Gruber wrote:
>> Phillip Susi venit, vidit, dixit 07.04.2015 19:08:
>> > On 4/7/2015 10:13 AM, Michael J Gruber wrote:
>> >> Seriously: gitk knows F5 and Shift-F5 for refresh, and I think the
>> >> latter is the thorougher refreshment.
>> >
>> > Neither one makes newly added notes show up.  The only way seems to be
>> > to close and restart gitk.  Looks like a bug.
>> >
>> >
>>
>> Apparently, gitk rereads the refs but not commits it has read already -
>> and the commit reading includes the notes lookup.
>>
>> Unfortunately, my wish-fu is lacking. But I'll cc the master.
>>
>> Paulus: None of updatecommits, reloadcommits and rereadrefs seem to
>> reread the notes of a commit that has been displayed already if the
>> notes have changed (but the other refs have not).
>
> As far as shift-F5/reloadcommits is concerned, it looks like I should
> be unsetting commitinfo in reloadcommits.
>
> However, I agree gitk should refresh the notes in updatecommits as
> well, but that will take more work.  Is git notes list the best way to
> find out all the current notes?

It looks like it is from the documentation.
Anyway let's add some people in Cc in case they could help.
