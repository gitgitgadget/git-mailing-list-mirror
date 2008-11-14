From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 00/11] gitweb: display remote heads
Date: Fri, 14 Nov 2008 19:37:36 +0100
Message-ID: <cb7bb73a0811141037o26532f34k6a3e0193cd06e79a@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811141533.15427.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 19:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L13ZH-0003Gb-Mr
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 19:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbYKNShk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 13:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbYKNShk
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 13:37:40 -0500
Received: from qb-out-0506.google.com ([72.14.204.227]:47748 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYKNShj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 13:37:39 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1536238qba.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gZaYtZtG57tuf8IFpDkyL274WDPpzr7B0Lad3ckoIxo=;
        b=FEwqYujMZgtGtx/JCvdYOSBc+1BV2EWVB0A7wE6V6va6PK7xDEmGhIcXL3kxmHch9Q
         394exNuyqSZY9fTyNum7OtwTL7XqOEew0QcH33pLtMBNlG8uNeUA3ZdN5XyfoNtzvCU9
         dqzOMl4wITHtJBCNwncQZkpiuxErCx/5p9G9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QRM0iQLvH2X3CFtcRisZPFlhgPEKEx/yfduaHXL06v4yEUgnVM6HNhox88iNbdGLDh
         Hq3JradFVt/JsT0ZS3vqUQEnrKKJYuwhZiBRgF0ofJoOj0ODl+NhrmgRZTHX3B6N9vvw
         WP8Ztth4wv+vtk8IhAf8RJ6v23Zd2XUhkksmg=
Received: by 10.210.16.16 with SMTP id 16mr1381433ebp.81.1226687856448;
        Fri, 14 Nov 2008 10:37:36 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Fri, 14 Nov 2008 10:37:36 -0800 (PST)
In-Reply-To: <200811141533.15427.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100999>

On Fri, Nov 14, 2008 at 3:33 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 13 Nov 2008, Giuseppe Bilotta wrote:
>
>> This is a patchset I presented about a year ago or so, but after a lively
>> discussion it dropped into silence. I'm now presenting it again, with minor
>> cleanups and adjustements.
>
> That is very nice of you to resend this series. If you could provide
> link to earlier discussion of this series...

There was no actual discussion after I sent the series, although there
was some while I was preparing it. Plus, gmane is quite unresponsive
for me at the moment, but the whereabous of the past discussions are
these http://kerneltrap.org/mailarchive/git/2007/8/30/256411/thread

>> Giuseppe Bilotta (11):
>>   gitweb: introduce remote_heads feature
>>   gitweb: git_get_heads_list accepts an optional list of refs.
>>   gitweb: separate heads and remotes list in summary view
>>   gitweb: optional custom name for refs in git_heads_body
>>   gitweb: git_split_heads_body function.
>>   gitweb: use CSS to style split head lists.
>>   gitweb: add 'remotes' action
>>   gitweb: display HEAD in heads list when detached
>>   gitweb: git_is_head_detached() function
>>   gitweb: add HEAD to list of shortlog refs if detached
>>   gitweb: CSS style and refs mark for detached HEAD
>
> I'll try to review individual patches, but I haven't examined them
> yet, so perhaps there is a reason why there are so many patches in
> this series?

And I actually squashed some! The original patchset was 14 patches.
Now it's about 10, of which the first 6 as the actual remote heads
stuff, and the last 4 are the detached HEAD stuff.

> Note that on GMane NNTP (news) interface I can see only two last
> patches. Could anyone not CC-ed confirm or deny if this is VGER
> anti-SPAM filter at work, or some GMane archive hiccup?

Seems to be a gmane problem, I can see it too.

-- 
Giuseppe "Oblomov" Bilotta
