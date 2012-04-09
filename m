From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 02/12] completion: simplify __gitcomp
Date: Mon, 9 Apr 2012 22:12:54 +0300
Message-ID: <CAMP44s1P2sSWDa9nT-LO+EmFvsMQs3yogO+Q0o460FH_r3b=nA@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-3-git-send-email-felipe.contreras@gmail.com>
	<20120408124652.GN2289@goldbirke>
	<CAMP44s0nSH7ZjC4T=7pXS2MyAkZ133hOXa_tn3q4er+FbcOc_w@mail.gmail.com>
	<20120408132704.GB4103@burratino>
	<CAMP44s3c2SNSh=TGhYv=JKGu4QJfPB_xoBip5wwLoDh3dLHYNw@mail.gmail.com>
	<20120408143621.GA2631@burratino>
	<CAMP44s1hmG_xMjeB_Wv8pU=aPt=QK27R1OsePeeH5TK9w2GCqg@mail.gmail.com>
	<4F83311B.50901@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 09 21:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHK1N-0007do-6H
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 21:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824Ab2DITM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Apr 2012 15:12:56 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36683 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728Ab2DITM4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2012 15:12:56 -0400
Received: by eekc41 with SMTP id c41so1152418eek.19
        for <git@vger.kernel.org>; Mon, 09 Apr 2012 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EUsX8ohRTF+A0repEhjXFffmAcdTMRQ3MF4C00WqI3M=;
        b=ywilmlAtpdgNIafx7wM+MdfOAMEkKHeycWiWjuckV350LIFxS5jVjrYrFRTVxkIa2B
         YdDq37H/OHlBQvtt4qXtPM2QChlxMjbqIEdDzIkyNForJWJ81RXT/9hS9VZL1zwe8SFM
         w84NuwvhqJxo2+9O4BroaOnMavG72Ya3O7XCmmclFlm0YeAGxUtaugXai8LRJVBw1iD2
         sgUiYyCyQkw7ax3kWmGHR+YYEwSs679yA2PTortOhysuHY8gmuuv9eFWV9mmzmPNW+26
         3oOg1MyHod+sI8jMiINrftLI+/ZXWaZNxwnwFxe1ycan+MZ45D75gebp6J8ytvNt25/e
         EDIg==
Received: by 10.14.127.129 with SMTP id d1mr988387eei.59.1333998774784; Mon,
 09 Apr 2012 12:12:54 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 9 Apr 2012 12:12:54 -0700 (PDT)
In-Reply-To: <4F83311B.50901@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195032>

On Mon, Apr 9, 2012 at 9:57 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 08.04.2012 16:58, schrieb Felipe Contreras:
>> On Sun, Apr 8, 2012 at 5:36 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:
>>> (dropping Shawn from cc since I'm not under the impression he works
>>> =C2=A0on the completion script these days)
>>> Felipe Contreras wrote:
>>>
>>>> Whoa! Breaking their tab completion? Where? Can you show me some e=
vidence?
>>>
>>> If you weren't listening before, I'm not sure what I can add now[*]=
=2E
>>
>> This is what you said; "in exchange for us breaking their tab
>> completion". There's a big difference between "breaking", and
>> "*potentially* breaking". I have never seen any evidence of tab
>> completion actually being broken.
>
> I have:
>
> http://thread.gmane.org/gmane.comp.version-control.msysgit/13310/focu=
s=3D13335
> http://thread.gmane.org/gmane.comp.version-control.git/185184/focus=3D=
185189

I meant being broken by this patch.

Plus this patch series actually fixes those issues.

--=20
=46elipe Contreras
