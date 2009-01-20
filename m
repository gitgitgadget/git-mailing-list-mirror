From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: how to track multiple upstreams in one repository
Date: Tue, 20 Jan 2009 09:29:13 +0200
Message-ID: <8e04b5820901192329pf44431coce4423e6a8d43198@mail.gmail.com>
References: <alpine.DEB.1.10.0901181855400.20741@asgard.lang.hm>
	 <20090119021426.GA21999@shion.is.fushizen.net>
	 <alpine.DEB.1.10.0901181957070.20741@asgard.lang.hm>
	 <8e04b5820901182352n29b3885cj850e6ddae6ca237f@mail.gmail.com>
	 <20090120033402.GC8754@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: david@lang.hm, "Bryan Donlan" <bdonlan@fushizen.net>,
	git@vger.kernel.org
To: "Greg KH" <greg@kroah.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:30:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPB4M-0002JK-1U
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZATH3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 02:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbZATH3Q
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 02:29:16 -0500
Received: from mail-ew0-f20.google.com ([209.85.219.20]:36039 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbZATH3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 02:29:16 -0500
Received: by ewy13 with SMTP id 13so773774ewy.13
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 23:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WyZ+sWd7bheJyxS4bhbrOLPzLfftVhCRXImiTHYHlyE=;
        b=Am3wctW8BGpXroMtQXbGAiLZFbhOw9kde8fsOQRqTFDw2QQNYhYv0xuXABnq8Gggws
         RuRA2aWoteYJlAw2XLxkfiJLfHrYHRKLekJ3Wkr8GK8RC6bwfD0sLVXjG59pEszO6o6T
         b0eBT7g+QOvPjTq2zJvhX9cJpnDf01ySYzbJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GtvTEGYY1pctl56rwenQa4QfFFpNlrcwNknyA7t7Txow9cPoSOgJmSO/1p335WQTfZ
         bGzJjMQTLjagE9AxM6noWMamUieORIcn3kegJKvYC4FJJOco9Feu9GxFh742JyGCXrqx
         dmqriENvTNmRojrxkX4KyZhfaSI6h/Nd1yPxM=
Received: by 10.210.12.18 with SMTP id 18mr8221033ebl.130.1232436553531;
        Mon, 19 Jan 2009 23:29:13 -0800 (PST)
Received: by 10.210.129.8 with HTTP; Mon, 19 Jan 2009 23:29:13 -0800 (PST)
In-Reply-To: <20090120033402.GC8754@kroah.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106452>

On Tue, Jan 20, 2009 at 5:34 AM, Greg KH <greg@kroah.com> wrote:
> On Mon, Jan 19, 2009 at 09:52:16AM +0200, Ciprian Dorin, Craciun wrote:
>>     I use something even simpler, please see the attached .git/config
>> file that I use. It also uses remote branches, and rewrites the refs
>> to something like: stable/v2.6.25/master or torvalds/v2.6/master. Also
>> in order to fetch them I use git fetch stable/v2.6.25
>
> You all do know that all of the -stable trees are automatically kept in
> one repo on kernel.org, so you don't have to jump through all of these
> hoops, right?
>
> confused,
>
> greg k-h

    :) This is something that escaped me... Could you give me the
exact git url for this repository? (on kernel.org I'm not able to find
it, just the current one...)

    Thanks,
    Ciprian Craciun.
