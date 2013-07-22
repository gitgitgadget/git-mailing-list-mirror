From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: git subtree push-all and pull-all
Date: Mon, 22 Jul 2013 20:35:47 +0100
Message-ID: <CALeLG_=x30qR1LFiKzz+NZu6vAf3GAL2tTCsbCz0Zm6J+udAcg@mail.gmail.com>
References: <CALemSr4Z+p7v_wQn7EOFTVHjtMYgxqGSBZf3zU5pn-eW_SEG5A@mail.gmail.com>
	<20130707125430.GA23197@paksenarrion.iveqy.com>
	<CALemSr4Q_En+9eAbu2oRO-=EYt78sCB4nQjSO67W_m=nxu6KiQ@mail.gmail.com>
	<51DBD636.7070601@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gareth Collins <gareth.o.collins@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Mon Jul 22 21:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1Ltg-0001oB-KE
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 21:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932966Ab3GVTfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jul 2013 15:35:48 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:62097 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820Ab3GVTfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jul 2013 15:35:47 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so8702102obb.14
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 12:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=DDP7n/rmEG0p7VTimOru35OjAylKhzkTEW2QcsmK7VM=;
        b=DeoPwIP5vOjPKoRzp3o3k7DlA+V5ElKsI2sLFfU7lukF9S02Nj8JrCk4u1t0tP4Vd5
         +n0XOA2fncrjsl0cxWfrIoaJ8RtDAmhhsE1vPcqmeBKLwfpMWryTNkvUg3oEUIIB2MKd
         x0+uDt8JDmT3FHBw58BXtNSycgv7lBkWIozUju8R6pIRoNO2Dl6U/N33goKPiqbuHsIU
         JX9LyXzgn/aOKSuS7kMu3LbM8oVJif/D2qnSBSD8yiVe0Faxb2+HvJNKavZuErYn87K3
         uwdPjQqM8I0Ect3SQFgagu7/A4w/DuvLOlRsJJxryyWgwWBTqVXq5wu72pXw0PSeOVMv
         U6YA==
X-Received: by 10.182.215.193 with SMTP id ok1mr21815581obc.78.1374521747348;
 Mon, 22 Jul 2013 12:35:47 -0700 (PDT)
Received: by 10.76.9.2 with HTTP; Mon, 22 Jul 2013 12:35:47 -0700 (PDT)
X-Originating-IP: [2.102.87.146]
In-Reply-To: <51DBD636.7070601@initfour.nl>
X-Gm-Message-State: ALoCoQnZr3p1DBAMc3mSbkMXPz292orGzMbdKDWAai749vweySuM+4qKia+NLVuCdFDov4MFV+qV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230988>

Hi,

Sorry for the delay. Not been monitoring the list lately.

I'm afraid work stopped for two reasons. Lack of interest from the
list was the main one. I understand subtree isn't used much and
subsequently there wasn't much interest in reviewing the patches I was
putting out. As a result I lost interest.



On Tue, Jul 9, 2013 at 10:21 AM, Herman van Rink <rink@initfour.nl> wro=
te:
> On 08-07-13 17:20, Gareth Collins wrote:
>>
>> Hello Fredrik,
>>
>> Thanks for the suggestion! Adding in Paul Campbell and Herman Van Ri=
nk
>> who worked on this before.
>
>
> Paul Campbell has been working hard on multiple branches in
> https://github.com/kemitix/git
> But work appears to have stopped. :(
>
> There is also a recent blogpost:
> http://ruleant.blogspot.nl/2013/06/git-subtree-module-with-gittrees-c=
onfig.html
>
> Thanks for your interest, I'd love to see this get integrated....
>
>
>>
>> thanks again,
>> Gareth
>>
>> On Sun, Jul 7, 2013 at 8:54 AM, Fredrik Gustafsson <iveqy@iveqy.com>
>> wrote:
>>>
>>> On Wed, Jul 03, 2013 at 03:56:36PM -0400, Gareth Collins wrote:
>>>>
>>>> Hello,
>>>>
>>>> I see over the last year (on the web and in this mailing list) the=
re
>>>> was some activity to extend subtree with a .gittrees file and
>>>> push-all/pull-all commands.
>>>>
>>>> Perhaps I missed it, but looking through the latest git code on th=
e
>>>> github mirror I can't find any reference to the .gittrees file or
>>>> these commands.
>>>>
>>>> Does anyone know the status of this feature? Was it decided that t=
his
>>>> was a bad idea and the feature has been rejected? Or is this a fea=
ture
>>>> still "cooking"...which will likely make it into git mainline at s=
ome
>>>> point?
>>>>
>>>> I ask because I would like to use something like this to be able t=
o
>>>> keep a combined repository and separate project repositories in sy=
nc.
>>>> Of course, if it was decided that this feature is fundamentally a =
bad
>>>> idea then I will do something different.
>>>>
>>>> Any pointers would be a big help.
>>>>
>>>> thanks in advance,
>>>> Gareth Collins
>>>
>>> Still no answer to this? I suggest that you CC the persons discussi=
ng
>>> this the last time.
>>>
>>> --
>>> Med v=E4nliga h=E4lsningar
>>> Fredrik Gustafsson
>>>
>>> tel: 0733-608274
>>> e-post: iveqy@iveqy.com
>
>
>
> --
>
> Met vriendelijke groet / Regards,
>
> Herman van Rink
> Initfour websolutions
>



--=20
Paul [W] Campbell
