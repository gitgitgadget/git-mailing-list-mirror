From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC] Documentation: --options in man-pages synopsys
Date: Wed, 9 Oct 2013 23:35:19 +0100
Organization: OPDS
Message-ID: <AB54BA13FC634F47B15CFE796CECADC4@PhilipOakley>
References: <CA+gfSn-o7cH3a-KWx_iggNc4-rYzQysbTj7OGdaggutLu-X-BA@mail.gmail.com> <FCEE4469EE8B234199968ECA9B0661E230EC61C0@STNEEX10MB01.stone.ne.gov>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Loyall, David" <david.loyall@nebraska.gov>,
	"Dmitry Ivankov" <divanorama@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 10 00:35:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VU2La-0006js-NX
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 00:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab3JIWfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 18:35:08 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:48580 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab3JIWfG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Oct 2013 18:35:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApUGAPjYVVJOl3GZ/2dsb2JhbABagwc4iTi4FEAKgR4XdIIgBQEBBAEIAQEuFggBASwBAQMFAgEDEQQBAQoeBxQBBBgCBgcGCQgGAQcLCAIBAgMBDASHXwoIuRiPUoMZgQQDiQKGE4odkFKDJTs
X-IPAS-Result: ApUGAPjYVVJOl3GZ/2dsb2JhbABagwc4iTi4FEAKgR4XdIIgBQEBBAEIAQEuFggBASwBAQMFAgEDEQQBAQoeBxQBBBgCBgcGCQgGAQcLCAIBAgMBDASHXwoIuRiPUoMZgQQDiQKGE4odkFKDJTs
X-IronPort-AV: E=Sophos;i="4.90,1067,1371078000"; 
   d="scan'208";a="590635836"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip06ir2.opaltelecom.net with SMTP; 09 Oct 2013 23:35:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235845>

From: "Loyall, David" <david.loyall@nebraska.gov>
Sent: Tuesday, October 08, 2013 3:03 PM
> As a unix user I'd expect the SYNOPSIS section at the top of the man 
> page to include all options that the command accepts.  Mutually 
> exclusive options are expected to be in the form [-q | --progress 
> | --all-progress], such is already done.
>
> I believe that you'd be safe in following 
> http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html 
> unless the git-* family of commands and documentation deviate from it 
> in a way that I am not aware of.


For an example of a command with a long list of options try `git 
rev-parse --help`.

SYNOPSIS
    git rev-parse [ --option ] <args>.

Philip

>
> Hope this helps,
> --Dave
>
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Dmitry Ivankov
>> Sent: Tuesday, October 08, 2013 7:07 AM
>> To: Git List
>> Subject: [RFC] Documentation: --options in man-pages synopsys
>>
>> Hi,
>>
>> I've noticed that man git-pack-objects describes cmdline as following
>>
>> SYNOPSYS
>> 'git pack-objects' [-q | --progress | --all-progress] 
>> [--all-progress-implied] [--
>> no-reuse-delta] [--delta-base-offset] [--non-empty] [--local] 
>> [--incremental]
>> [--window=<n>] [--depth=<n>] [--revs [--unpacked | --all]] [--stdout 
>> | base-
>> name] [--keep-true-parents] < object-list
>>
>> while OPTIONS sections has even more options, --no-reuse-objects for
>> instance.
>>
>> Should it be dealt with and how?
>> - add smth like ... at the tail of options in synopsys to indicate 
>> that there are
>> more options
>> - add all the [--options] to synopsys
>> - drop all the [--options] as they all are optional
>> - pick only the most common/important ones like -q --progress, per
>> command or per command classes (hard to maintain and/or verify?)
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in the 
>> body of a
>> message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
