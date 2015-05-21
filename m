From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git p4 clone - exclude file types
Date: Thu, 21 May 2015 14:49:14 -0600
Message-ID: <CAFcBi8-SShvWLS7sRy3L=vF=OmQqmroK5NpcuA9N=0J2x4DEXA@mail.gmail.com>
References: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>
	<555A52BD.1030802@diamand.org>
	<CAFcBi89XwW48Goaap=OCVQ_CJrNa_hj5+DWtOHGOsrm6jMs-mw@mail.gmail.com>
	<555C2E5D.70502@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 21 22:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXP6-0006BN-1k
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbbEUUtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:49:16 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:33128 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbbEUUtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:49:15 -0400
Received: by iebgx4 with SMTP id gx4so17559988ieb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z/Vy4Vc+bPSGOYwLi4SpkyexjjNwYugkVsuM4KZ9Uxk=;
        b=R0KsPH4vgNEktTXEeuUrxMHvhGxugtN9CZR6FuSjuJvnM3iTMpMPV23IAYijrYFlbY
         kNMSBkFKwsrz3z63iXOFu1yM+aITSZGe+HDkuGBR7kYUU/De09Dw1UGjcmxR2vOKYB9C
         QYE3G1XuSIoGSYWtAqcfw3d7sSvap47qi3VCkMYC8S3ACw3G8x+Pi68xZ29wLSMDo8CO
         IO98vJ4KtH4orspF8odaXI5MPbnKrhe//BhIBGirbhSQXD3j+RQBE6uM4TBphui1+8AR
         0b0DQ1U7ApH8khT+zRy0hhLmqMDUEh/fuYv8ncWkCGj5hjcba1F/idVxREVtLyvB2Xqp
         GUmQ==
X-Received: by 10.107.137.170 with SMTP id t42mr6099916ioi.16.1432241355041;
 Thu, 21 May 2015 13:49:15 -0700 (PDT)
Received: by 10.50.230.51 with HTTP; Thu, 21 May 2015 13:49:14 -0700 (PDT)
In-Reply-To: <555C2E5D.70502@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269660>

I thought about that, but no. The box I'm running git-p4 on has the
following specs:

CentOS 6.6 64bit
1 CPU
8GB RAM
8GB Swap

It is also on the same physical network as the Perforce server. I
remember seeing someone else complain about this, but I can't find the
article/blog now.


On Wed, May 20, 2015 at 12:49 AM, Luke Diamand <luke@diamand.org> wrote:
> On 19/05/15 08:38, FusionX86 wrote:
>>
>> Thanks Luke, looks like this does work for excluding files when using
>> git p4. Great!
>>
>> Unrelated question...
>>
>> While using git p4 I have noticed that most of the time the clone/sync
>> operations hang and I have to keep retrying. The Perforce depot I'm
>> currently working with is larger than I'd like and has a lot of binary
>> files which might be the cause. The point it gets to in the clone/sync
>> is always random and doesn't ever stop on the same files or file
>> types. Sometimes it'll die soon after starting, but other times it
>> almost completes and then dies. If I keep retrying, it will eventually
>> complete. I haven't been able to narrow down the cause, but I do
>> notice that the git-fast-import stops right as the clone/sync dies.
>> I'm wondering if git is overwhelmed and terminates. Have you ever seen
>> this? Any suggestions?
>
>
> Running out of memory?
>
> Is this on a 32bit or 64bit system? How much virtual memory do you have?
>
> Luke
>
