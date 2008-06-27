From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 10:49:47 -0700
Message-ID: <9af502e50806271049m4015b0b7nbb1c4c94a4e1a2f4@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
	 <alpine.DEB.1.00.0806271844230.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:50:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCI5u-0004Ee-QR
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239AbYF0Rtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYF0Rtu
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:49:50 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:14519 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbYF0Rtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:49:49 -0400
Received: by fk-out-0910.google.com with SMTP id 18so536385fkq.5
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=srlAg18QhKgMBaMS6byH0KRjw2WNJU84+A6oj3WGIhk=;
        b=oVds45J3QwpTCRvJPBAS1SyPtPz7Hs0R2G2ykTDIguBsqkxzgAhsgQQBNbB0LOU2px
         I3iVSMy7///RHoPmBUBeJja3OZiEKVtoCVpBRNJ5QOM3NPeUffZfmFVO/Zv3PqsqKto+
         GVoEK+HP3N6eTklxoZHq/kGAWYhAwQT78VFDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=G28dTqEuSEHmwHsaXJ4WwbTCCNNCWGtIUxA6jGB6WhN+GI+8Bz5heOOfUYGe8jUb5J
         oTFcJX+JzyaecS9bcjlsEs+jGt/NG6BMN9hKhSmqFA3etCyX4e/XzcUqFumYPvpU4hYc
         umfMqX6XAVSe6XKF0UFmQ1ZIo75qsj3tCA4jQ=
Received: by 10.82.111.8 with SMTP id j8mr71804buc.29.1214588987969;
        Fri, 27 Jun 2008 10:49:47 -0700 (PDT)
Received: by 10.82.178.10 with HTTP; Fri, 27 Jun 2008 10:49:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806271844230.9925@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86612>

On Fri, Jun 27, 2008 at 10:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 27 Jun 2008, Robert Anderson wrote:
>
>> On Fri, Jun 27, 2008 at 6:33 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Thu, 26 Jun 2008, Robert Anderson wrote:
>> >
>> >> Seems to me the concept of the "index" is a half-baked version of
>> >> what I really want, which is the ability to factor a working tree's
>> >> changes into its constituent parts in preparation for committing
>> >> them.
>> >
>> > Half-baked is probably too strong a word.
>>
>> It is too subtle.  That the index state - which becomes the next
>> committed state - is not available for building or testing before
>> committing is a deep flaw.
>>
>> > Now, this is not necessarily what everybody wants, which is why many
>> > people are fine with the index.
>>
>> But it is something they should want, and should have, if they care
>> about the quality of their commits.
>
> This is too narrow-minded a view for me.
>
> No longer interested,
> Dscho
>

Here's a patch to match the local culture:  "It is incredible how
stupid the idea of the index is."

Clearly you should now be interested.

Thanks,
Bob
