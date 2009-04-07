From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH RFC 6/6] send-email: Remove horrible mix of tabs and 
	spaces
Date: Tue, 7 Apr 2009 23:57:22 +0200
Message-ID: <9b18b3110904071457gaad543bs2f621fa42fabb1b5@mail.gmail.com>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-5-git-send-email-mfwitten@gmail.com>
	 <1239139522-24118-6-git-send-email-mfwitten@gmail.com>
	 <9b18b3110904071435p320e5d1dh16061d04a3a8ab57@mail.gmail.com>
	 <b4087cc50904071442ka298564x52112c1eac9ac284@mail.gmail.com>
	 <9b18b3110904071444g2a8c4b66l9c22bd5ffabe3d6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJJu-0004UU-1A
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 23:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbZDGV50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760703AbZDGV50
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 17:57:26 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:62361 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760737AbZDGV5Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 17:57:24 -0400
Received: by qyk16 with SMTP id 16so5331951qyk.33
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NOP5RMWwgFBJTPn+t3SuZNlq/2axtCrJVUPg561Kpqc=;
        b=GVna5VfBTXS1kZPIqDXRwAS05f0S/zWgjN0JTLoAolQHLR90G/j0kEDiPZkzSi/rtA
         6s16pF9EGt3/6I3P+pSp1xxAeK3HqagKEilid7Q4cSbH/+0XYSR5W6bbFY7HtwjNAEzA
         ugTrvO9w+MhMDfV4Emf+y1STeKpaWKGsxjKbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gHA2AtjuYkHAwAZr9r+FMIRlHgT4dW59lZSymTAGCW7iuw8l8Wia0zYVqOXkVPZuA1
         aiISPTaNr36oBRNfZuEiiRA/UeRXt33klkJ/NEEC3NxVd4RqTvogMpEfg1Agpye5s4p/
         iS+Hcof1LIf7RX3vLzoWVIGQkz6/ukEP5Npl0=
Received: by 10.231.14.141 with SMTP id g13mr201250iba.56.1239141442963; Tue, 
	07 Apr 2009 14:57:22 -0700 (PDT)
In-Reply-To: <9b18b3110904071444g2a8c4b66l9c22bd5ffabe3d6a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116000>

2009/4/7 demerphq <demerphq@gmail.com>:
> 2009/4/7 Michael Witten <mfwitten@gmail.com>:
>> On Tue, Apr 7, 2009 at 16:35, demerphq <demerphq@gmail.com> wrote:
>>> 2009/4/7 Michael Witten <mfwitten@gmail.com>:
>>>> +## WARNING! ACHTUNG! ATTENTION! ADVERTENCIA!
>>>> +## =A0 Currently, this file uses tabs (like the rest of git sourc=
e) to
>>>> +## =A0 delineate code structure. Do NOT under any circumstances m=
ix tabs
>>>> +## =A0 and spaces across lines that share a relationship in terms=
 of layout.
>>>> +## =A0 In fact, it would currently be best to use only tabs, so p=
lease set
>>>> +## =A0 your editor(s) accordingly. This code is already trashy en=
ough. Please
>>>> +## =A0 don't make it worse.
>>>
>>> Perltidy the file?
>>>
>>> Yves
>>
>> Oooh, that's sexy!
>>
>> I'll have to give that a try. However, I've been entertaining the id=
ea
>> of rewriting the whole thing anyway; it's in need of much more than
>> reformatting.
>
> Yes. I notice evilness in there. Not necessarily dire burn your house
> down evilness, but evilness none the less.

BTW, I'd be glad to help out if you want, as I suspect would some of
the p5p folks.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
