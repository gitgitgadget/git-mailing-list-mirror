From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Error message: unable to open object pack directory:
 .git/objects/pack: Too many open files
Date: Wed, 13 Nov 2013 14:04:11 +1100
Message-ID: <CAGyf7-GO1x5xCN-W_K+mvYU2-HdF1Gxu15wwZW7uiGWfdZfybw@mail.gmail.com>
References: <CAJc7LbpSgRLxj62YRb3+n9Ty=LphoGv+Ox=R-nMS+458rrjw-w@mail.gmail.com>
	<CACsJy8BiBmeYuZ3VVyvocB969sYpdFNCOJ8GYSA2his5Vebg=g@mail.gmail.com>
	<CAJc7Lbqaas0Czdvcfn8+iceoyxaVSHOaV9jCJsy4mWH+AbV41Q@mail.gmail.com>
	<CACsJy8AHjAgSFzZ2R2Nup=GcuQJdaedbGXhRpcCT6HuaaLUtaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 04:11:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgQry-0001m9-Pm
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 04:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758128Ab3KMDLl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Nov 2013 22:11:41 -0500
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:46536 "HELO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758127Ab3KMDLO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 22:11:14 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Nov 2013 22:11:14 EST
Received: from mail-ob0-f180.google.com ([209.85.214.180]) (using TLSv1) by na3sys009aob123.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUoLt0aFMx00Yz+mdag12edfX+4tZ561C@postini.com; Tue, 12 Nov 2013 19:11:14 PST
Received: by mail-ob0-f180.google.com with SMTP id vb8so4064404obc.39
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 19:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iPm3V3FFKCb4Z1Ctc/CqyGeh/FSqO2JMd8abTVSQNdE=;
        b=BcV/dmx0A+wMdWYtIUN10lHRZ5FN0SwzvqVx2eVdoDzbF5f0Q6rtMNYVamlEDP3LVL
         DXBzK/lCfTNwVs3CxRswGvQJ2dv7kBB1JyGerzq+PKe8U6tLcjadP3G47Z+PqxstXqP6
         QRUj7AbcP3afWthQR2/oQ8SmA+eusrOXifixxAlVXdQpORTfcDFSrhwibwsdszh9oUSG
         2qadyDGw1lAZQmzq4yHe5f6KFDm28WNI20r5K8eSN5PbPVbHd47RWquxICiKP+6QLWOm
         v3IMwzZOCOKM8pLfNhxU6s4XePHpOAkyITSjOv2vCQUgIk9Cawmp/6lZ8LGjBxqSI0hS
         CvoA==
X-Received: by 10.182.22.18 with SMTP id z18mr26624552obe.42.1384311851832;
        Tue, 12 Nov 2013 19:04:11 -0800 (PST)
X-Gm-Message-State: ALoCoQkhDMAwM7uQA/rju1j1jd+wNt6EpRvk4gCV3Zk5WfrAcM/LyuRSC8fdf1UAPyXQX7E99Dk+QoI4NIIA6koVhsNZRYTkp0qX0qYwm5TKjNmWfVrJmbD6fyUu5H81aLfjSLyj/l6SI9zOLboclCV3VdncLTZ07g==
X-Received: by 10.182.22.18 with SMTP id z18mr26624544obe.42.1384311851747;
 Tue, 12 Nov 2013 19:04:11 -0800 (PST)
Received: by 10.182.92.114 with HTTP; Tue, 12 Nov 2013 19:04:11 -0800 (PST)
In-Reply-To: <CACsJy8AHjAgSFzZ2R2Nup=GcuQJdaedbGXhRpcCT6HuaaLUtaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237771>

On 13 November 2013 13:48, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Nov 12, 2013 at 9:38 PM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=
=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
>> I use linux.
>>
>> I can't publish repo - it's proprietary, it weights ~300M unpacked,
>> and it uses references ~3Gb.
>> Error message doesn't contain "remote:" prefix.
>> The majority of opened files have name like:
>> objects/pack/pack-<hash>.[ pack | idx ]
>> They all are from referenced repo.
>
> There's a fix related to too many open packs, 88d0db5 (sha1_file:
> introduce close_one_pack() to close packs on fd pressure - 2013-08-01=
)
> but it's only available in v1.5.0-rc0 or rc1. Could you try that
> version?

I believe you mean 1.8.5-rc0 or 1.8.5-rc1, is that correct?

>
>>
>> I have disabled gc in the referenced repo - to prevent all local rep=
os
>> from breaking. May this be the cause of problem?
>>
>> On 12 November 2013 18:19, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Tue, Nov 12, 2013 at 3:02 PM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=
=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
>>>> I get this error message every time I want to do a `git push`.
>>>> git version: 1.8.4.2
>>>>
>>>> Is it a known issue? Do you need additional info to investigate it=
?
>>>
>>> What OS do you use? If the repository can be published, please do.
>>> Compress the whole .git directory, don't push or anything. Does the
>>> error message begin with "remote: "? If not you could try strace an=
d
>>> at least identify what files are opened.
>>> --
>>> Duy
>
>
>
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
