From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 09:06:52 +0700
Message-ID: <AANLkTikOehig7LjpUC=b6iSjGnuF=TsZmipWDfQB7AW6@mail.gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com>
 <201012082051.09730.jnareb@gmail.com> <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
 <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino> <192758EC-4276-445D-B1D5-284073D5AB32@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Dec 09 03:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVur-00027a-Eb
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 03:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab0LICHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 21:07:24 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42817 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0LICHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 21:07:24 -0500
Received: by wyb28 with SMTP id 28so1763786wyb.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 18:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4IMHHTuM9dRSxUG/bi5v8Sr/1JlHIdmKswrWbZd71Y0=;
        b=S7TV7+oVRa9hRZhs5UKve1Rtst5tcCIZ6KOZuqA2D+PMwIH79EaZo7xM7FFm3LkjV1
         FuqhYNkKyELJPyPeq/H6y01hZTMsS+50SnL/yXcEo/KKbRYX1mM01gnU/Fs32R17cimF
         Wjm6zoJtsLrvOt18/FlnaaQHTSZuYgAAWdHHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pk5kuih8+jym6rIjaJFXBajLk21/VML8Rt+5K6LwG46CrvyTV4t8G+8NjTgPksR2LL
         4nYc+4/6XxdHtstKhpYdQsNXORFkN73ODDCSXYOK38zlI9nOgP7tUdrJDyziGEujQdnI
         O0LbHLh5QFumUH5FFkVXvxHf1fdHz5fovQjBI=
Received: by 10.216.168.73 with SMTP id j51mr12336wel.49.1291860442399; Wed,
 08 Dec 2010 18:07:22 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Wed, 8 Dec 2010 18:06:52 -0800 (PST)
In-Reply-To: <192758EC-4276-445D-B1D5-284073D5AB32@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163258>

On Thu, Dec 9, 2010 at 9:02 AM, Kevin Ballard <kevin@sb.org> wrote:
> On Dec 8, 2010, at 5:59 PM, Jonathan Nieder wrote:
>
>> Jakub Narebski wrote:
>>
>>> You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/f=
oo}x2
>>> means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.
>>
>> That said, does ^2x500 really do something meaningful that a person
>> would ever need? =C2=A0I like the
>>
>> =C2=A0 =C2=A0 =C2=A0 ^{:nth(3)/foo}
>>
>> syntax because perl6 supports m:nth(3)/foo/, suggesting a menu of
>> already-defined modifiers to implement when they prove useful, known
>> already to a certain subset of the audience and proven useful alread=
y
>> in a different context.
>
> I like the ^{:nth(3)/foo} syntax as well. Though I'm not familiar wit=
h Perl 6,
> this does have the benefit of being fairly obvious to the reader as t=
o what it
> means.

OK so :nth(3)/foo for all branches?
--=20
Duy
