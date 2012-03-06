From: Jerome Yanga <jerome.yanga@gmail.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 6 Mar 2012 15:07:18 -0800
Message-ID: <CAC0z1F87ORZQmrZeMGo2suV1fAt-5mAwwpkkV3ZTx0US3AjM8Q@mail.gmail.com>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
	<4F567DC6.4070903@gmail.com>
	<4F567FEF.5000105@gmail.com>
	<CAC0z1F_eyMo4D8E2j15dOFhp-6tZ_ixacB6XcKfNpJategcsXQ@mail.gmail.com>
	<CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S53Ta-00055d-G6
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 00:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031471Ab2CFXHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 18:07:21 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58072 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031456Ab2CFXHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 18:07:20 -0500
Received: by vcqp1 with SMTP id p1so4917390vcq.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 15:07:19 -0800 (PST)
Received-SPF: pass (google.com: domain of jerome.yanga@gmail.com designates 10.52.35.99 as permitted sender) client-ip=10.52.35.99;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jerome.yanga@gmail.com designates 10.52.35.99 as permitted sender) smtp.mail=jerome.yanga@gmail.com; dkim=pass header.i=jerome.yanga@gmail.com
Received: from mr.google.com ([10.52.35.99])
        by 10.52.35.99 with SMTP id g3mr22480459vdj.65.1331075239206 (num_hops = 1);
        Tue, 06 Mar 2012 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=rRWXX8sCp60yFhNY7pYLExs6RKd/1JjE1Mo/Ar39Xeg=;
        b=njACesLwpZ7ti9nbHtMAvCLVzZndJjEMNecmuItaUgeuHjwC80xZ+MQCLV8awVmXCk
         Jd9hRlFlk8a/uyNLfawnCyd4obOwl/b+xVaD+EZP3RkVQMLgaJuyCoGe16SOROT1EuFV
         79KdTz4B1CeQNzJGJ9vDSKAAnX97DMzWP+PRRB6CFjlr00EeMywtIloFADuPHib8YTKt
         oV2dUtrSRFdEepvWIK9LFoOSyBCwbcu38+CWVLR63YyB/Lu5AlhlWfnfO6mAuBYB6lGx
         I3HMmMdXZOtcau2Sk6YqKZV7s7P12hmroTl/+3aMogOOtMb9U/OWXs+1VcORV3JHfBNa
         qtGw==
Received: by 10.52.35.99 with SMTP id g3mr19345566vdj.65.1331075239034; Tue,
 06 Mar 2012 15:07:19 -0800 (PST)
Received: by 10.220.5.210 with HTTP; Tue, 6 Mar 2012 15:07:18 -0800 (PST)
In-Reply-To: <CAC0z1F_LYRkReO1qqcjkWy6Vb3E0_oNo-0kSf15nGfQFAtXpdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192413>

Is there a way to make git write to the working directory of the
central public server?

Please be nice to the newbee. =A0I am merely learning Git.

Regards,
j

On Tue, Mar 6, 2012 at 3:05 PM, Jerome Yanga <jerome.yanga@gmail.com> w=
rote:
> Please be nice to the newbee. =A0I am merely learning Git.
>
> Regards,
> j
>
> On Tue, Mar 6, 2012 at 3:02 PM, Jerome Yanga <jerome.yanga@gmail.com>=
 wrote:
>> Is there a way to make git write to the working directory of the
>> central public server?
>>
>> Regards,
>> j
>>
>> On Tue, Mar 6, 2012 at 1:21 PM, Neal Kreitzinger <nkreitzinger@gmail=
=2Ecom> wrote:
>>> On 3/6/2012 3:12 PM, Neal Kreitzinger wrote:
>>>>
>>>> On 3/6/2012 10:52 AM, Jerome Yanga wrote:
>>>>>
>>>>>
>>>>> However, when I log into the central public Git server and look a=
t
>>>>> the files in the project, none of them have change. I can only se=
e
>>>>> the changes from the client via Gitweb.
>>>>>
>>>> Gitweb and gitk know how to look at .git (bare) repo and display t=
he
>>>> contents. (I use gitk to verify that a push did what I wanted.) Th=
ere is
>>>> no work-tree for a .git repo to do linux "ls" on. If you really wa=
nt to
>>>> use commandline you would have to use git commands like git-show,
>>>> git-ls-files, git-cat-file, git-log, etc., to display and interrog=
ate
>>>> the contents of git objects (tags, commits, trees, blobs) in a .gi=
t repo.
>>>
>>>
>>> scratch git-ls-files from that list. =A0Its not much use for bare r=
epos,
>>> either.
>>>
>>> v/r,
>>> neal
