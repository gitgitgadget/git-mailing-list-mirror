From: Ping Yin <pkufranky@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Mon, 18 May 2009 23:55:37 +0800
Message-ID: <46dff0320905180855n1d772cb8sea69c7d5f47713e3@mail.gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
	 <32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
	 <7vzldes0ce.fsf@alter.siamese.dyndns.org>
	 <32541b130905151131h76048ff2o418764aa41bcd13b@mail.gmail.com>
	 <46dff0320905180855m3e1bd74esb564af0fbcf4b1ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 17:55:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65Bq-0001mC-1J
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbZERPzh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 11:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbZERPzg
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:55:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:28622 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbZERPzg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 11:55:36 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2023379ywb.1
        for <git@vger.kernel.org>; Mon, 18 May 2009 08:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h1ICpm7N/bek1PN2leWHKEEoh1JotvUwIrVWJFALVKk=;
        b=rdI8/Yrcq05cC70Mgn/bEOdJab1BwqVcTjDzHVjxf0JoXl/LbGwyEG7zVmZKiTVymL
         OwhV8GWfTdNsjhti6+Q9eQZfl7ywDq9m9sRaFWT2q/+OR8zrOUbLoRfvqC0FdahUmReW
         VJbkieSltOuw/CHYhLR6+DyRnRFdJrsoITgZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bj4HCTKDK/88mDKfX8wUAi+eTgQlISZVqeQKS+DepwBUXlIf2SNwMvZVui2hCEGwv6
         Qe/Rqt6LBRGZDOXwONHi7ninXPnr+rKuc722AawbyZk6Zd6ks/0iQcexj86rZ9dOqagq
         fgH+2oxRwgibi8pZ5hoWU83CeGo2kE/m4+aAA=
Received: by 10.90.65.14 with SMTP id n14mr6006019aga.108.1242662137792; Mon, 
	18 May 2009 08:55:37 -0700 (PDT)
In-Reply-To: <46dff0320905180855m3e1bd74esb564af0fbcf4b1ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119452>

Ping Yin



On Mon, May 18, 2009 at 11:55 PM, Ping Yin <pkufranky@gmail.com> wrote:
> On Sat, May 16, 2009 at 2:31 AM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Fri, May 15, 2009 at 2:11 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Avery Pennarun <apenwarr@gmail.com> writes:
>>>> ... =C2=A0Obviously I would need to write a man page, but I've bee=
n
>>>> hesitant to do that in case people have suggestions that need the
>>>> whole UI to change. =C2=A0Perhaps that's a chicken-and-egg problem=
, though,...
>>>
>>> If you fear that you might get into a situation that the UI _must_ =
change
>>> because it does not fit people's needs or workflows, that is a sign=
 that
>>> the UI and the workflow it was designed to support may not have bee=
n well
>>> thought out yet. =C2=A0At least, you do not even _know_ if it is we=
ll thought
>>> out or not. =C2=A0It is understandable that people would say "sound=
s cool,
>>> could potentially be good, but I'll wait and see if it is real" and=
 leave.
>>
>> Well, I'm already using it myself in my own projects and I like it.
>> So I'm pretty confident that it is *a* useful workflow. =C2=A0Whethe=
r it's
>> useful for others is a good question, and the only way to know the
>> answer is to put it out there.
>>
>> But I'm at a bit of a loss as to why so many people (er, as compared
>> to none) seem to have gotten excited about the tool, but then it
>> fizzled. =C2=A0This implies to me that something is missing. =C2=A0P=
erhaps it's
>> just the documentation; I'll work on that next, then.
>>
>
> It's really a cool feature, but i havn't tried it. Why?
>
> It will spends me some time saving and applying the patches and then
> testing it (i don't have the appropriate environment setuped). But I
> am busy and there is no urgent need to use this feature ( it is only =
a
> rare case for me). =C2=A0So i will wait until i need the feature or t=
here
> is an easy to fetch the code ( pu of official reposotory or other
> repository with these patches applied).
>
> I don't whether this is a common reason, but at least it is the reaso=
n for me.
>

s/dont't/don't know/
