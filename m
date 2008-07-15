From: "Erez Zilber" <erezzi.list@gmail.com>
Subject: Re: applying and committing patches in a single git command
Date: Tue, 15 Jul 2008 14:03:14 +0300
Message-ID: <ce513bcc0807150403v75233737w127719dd30e48176@mail.gmail.com>
References: <ce513bcc0807150150l783e9ff1kd7780dc59f4b5a3d@mail.gmail.com>
	 <487C659E.60606@panasas.com>
	 <ce513bcc0807150246g790ca009vc0a76bd6ef0aac9b@mail.gmail.com>
	 <487C752E.4090707@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Boaz Harrosh" <bharrosh@panasas.com>, s-beyer@gmx.net,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Jul 15 13:04:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIiKM-0000fL-Ki
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 13:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013AbYGOLDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 07:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbYGOLDP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 07:03:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:30618 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbYGOLDO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 07:03:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so5950497rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2008 04:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=irIrggxixGTaRDIepj0d52yzJhyDhKfL49pIobCwzJo=;
        b=D8TC1jxE8IR82HQmzX9LjNXgW4qKBKCWQtCTJ/4noZSvKTu8s0HXTo7niMUFDhaVmj
         1HfzhuX8XhiFFOnaXP12WtSTD8O6rRxYML2kVpx3V40rOtKpjs44UUTE1pR8KR+jgLS3
         Ys+9PF4Tt/zl3Rr673iD9eo8KC4dkxpXPmEdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nDIxoIz9BGgCMerwT24Grgq9O+xlatJbK+Ljklpb2W2f6dxNQqvyP5IR5qYKW+kOaO
         eE86rjlbXPL8RnYnkShDlql/58LeuHtcsEkZfRLaQ4E4jfT4nGr9h22H31DkxQz6NbY/
         MNlA3ojzW4jaA/ojwKtjJHtvAhVZ0JkmMgN+g=
Received: by 10.141.114.15 with SMTP id r15mr7311661rvm.164.1216119794263;
        Tue, 15 Jul 2008 04:03:14 -0700 (PDT)
Received: by 10.141.195.7 with HTTP; Tue, 15 Jul 2008 04:03:14 -0700 (PDT)
In-Reply-To: <487C752E.4090707@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88550>

On Tue, Jul 15, 2008 at 1:00 PM, Andreas Ericsson <ae@op5.se> wrote:
> Erez Zilber wrote:
>>
>> On Tue, Jul 15, 2008 at 11:53 AM, Boaz Harrosh <bharrosh@panasas.com>
>> wrote:
>>>
>>> Erez Zilber wrote:
>>>>
>>>> Hi,
>>>>
>>>> Someone created a patch with git-format-patch and sent it to me. I
>>>> would like to apply & commit the patch. If I use git-apply, it only
>>>> patches my tree without committing it. Now, I need to copy the commit
>>>> log, run git-commit and paste the commit log there. Is there a more
>>>> intelligent way to do that?
>>>>
>>>> Thanks,
>>>> Erez
>>>>
>>> git-am, can take all bunch of them at once
>>>
>>> Boaz
>>>
>>
>> Thanks. I have 2 more questions:
>> 1. How can I tell git-am to take a patch from an e-mail from a gmail
>> account?
>
> You can't, but you can save your gmail message to disc and pass
> the saved file to "git am" (don't use "git-am" over "git am";
> we're trying to get away from that old format of typing).
>
>> 2. If I have the actual patch on my machine (not in an e-mail
>> message), I guess that I need something else (not git-am). Is there
>> anything like that?
>>
>
> git apply patchfile
> patch (-p1) < patchfile

Thanks.
