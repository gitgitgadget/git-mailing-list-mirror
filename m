From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Thu, 4 Jul 2013 10:00:48 +1000
Message-ID: <CAH5451kq-zmy1kFFqx44ba4iM+H4zCF2J3GMc2ppcmoz5=urXA@mail.gmail.com>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
 <7v38rwlola.fsf@alter.siamese.dyndns.org> <CADL+T9ax0maws3GR24YV77Yge7knqHd5mfuPd_AqE9b4UmvYPg@mail.gmail.com>
 <CALWbr2zJFjbaCdA3d1eaFuP4HGShAwnK=gisRD=KHKWWi-XuTg@mail.gmail.com>
 <CADL+T9bbnGSxCjUBqoL3qm7Ss-j9jxorED0L1A6v1NbeLBpRQg@mail.gmail.com> <7vli5nfquq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Ed Hutchins <eh@demeterr.com>,
	Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 02:01:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuWz4-0002Fb-9c
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 02:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744Ab3GDABK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 20:01:10 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:56109 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab3GDABI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 20:01:08 -0400
Received: by mail-vc0-f172.google.com with SMTP id ib11so522891vcb.17
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jpF5ZfHb3pAoqtxiMHOIGAftol2rJue7Y02EhYGumio=;
        b=hKRY4Q40GpyW+NtbCu/+hO5FXUlMrmJ23LfF+n44RBf9o8qJc7RTVqe9XXAdgXuud2
         Wua/pIgcXXXyOn9ezwr1EJ+P0UmdIY+w/iIGiBgQslw5k4rk68vm+K7KV9wxoVeOOioH
         nCfj5t+rV3E39kIklLZ/hZbebvHvBbNZpLKD2S9DIaAuqTQRHh3YpVk0DxHJfK9wlK3r
         DVjupqc+8tUKDnsv5j5Ms0/wByahyeDB5EHxeqZXKOXV97s8FtHsHY9b/tweTO+9lVGu
         C90ImXjO5z65oOA0eQaDq75PT7lDjgVIpEPag2V3Dh/BtFPiU8T0IA0XHqCjBJ2c8fx1
         Un0g==
X-Received: by 10.52.100.166 with SMTP id ez6mr891610vdb.19.1372896068070;
 Wed, 03 Jul 2013 17:01:08 -0700 (PDT)
Received: by 10.220.14.71 with HTTP; Wed, 3 Jul 2013 17:00:48 -0700 (PDT)
In-Reply-To: <7vli5nfquq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229551>

On 4 July 2013 09:46, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano <gitster <at> pobox.com> writes:
>> It is not just misleading but is actively wrong to recording the
>> name of the original branch in commits and carrying them forward via
>> rebase. If you want a record of what a group of commits were about,
>> the right time to do so is when you merge.
>
> There is even git-resurrect.sh script in 'contrib/' that makes
> use of that practice to find merged-in and deleted branches,
> and resurrect them (among other tools).

How do users who wish to keep a record of branch names find out that
--no-ff will enable this behaviour?

Is this a common enough requirement to make --no-ff the default
behaviour (probably not, and that transition would be painful)?

What are the shortcomings of using --no-ff in the analogue to how
mercurials named branches work?

I think the git-flow and git-list style workflows have done a lot to
promote a set of usage patterns that keep this metadata around, I just
wonder if we can do more to assist users in what seems to be a
relatively common request.

Regards,

Andrew Ardill
