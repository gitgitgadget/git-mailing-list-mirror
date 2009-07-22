From: Allan Kelly <allankelly@gmail.com>
Subject: Re: Why is it important to learn git?
Date: Wed, 22 Jul 2009 22:50:37 +0100
Message-ID: <9586f3420907221450p6b9df86cy62e1832d06150286@mail.gmail.com>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
	 <20090722210738.GA25324@dpotapov.dyndns.org>
	 <m3my6wbdfs.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTji3-0007N6-RH
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbZGVVuk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 17:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbZGVVuj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:50:39 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:33179 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbZGVVuj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 17:50:39 -0400
Received: by bwz28 with SMTP id 28so473981bwz.37
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=agW91Isd2jLF8Vi7VreifQV2LKXk6ZrPF0PfV97qE5w=;
        b=sHSEVAeG7JhKikWAyx2tR48L39TlhJl0xz9wtyWfY4DjqQfiP++ktj+Qh31e9rnQ/s
         Tc2zeBgB88qWenHt423t1JYusBGoWWe6ViX+wT0MdJFj6rqxG2Tlyut81Uvzy/jRp1xY
         zH3A2itWPxtZhq1+F38emVG34nBWmq0LoT0ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ppJ9iZtcQM4lqrFZ94jx1CegU/eUqXPRsd8qdinyZC8Uui0cgNzNjoL1dYacdY02Z7
         TXQYzMwfquZ3nhTH71IeRzJKsByFnipyqMlfbqEVDcvirRXiUxxKioQ6K9lUAn793gSf
         YbrRH0bNRSi79ZM0/58qJU7UTj1H95YOy+koA=
Received: by 10.204.58.16 with SMTP id e16mr1318249bkh.43.1248299438107; Wed, 
	22 Jul 2009 14:50:38 -0700 (PDT)
In-Reply-To: <m3my6wbdfs.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123790>

Has anyone done a presentation on this (very interesting) subject with =
examples?

What's good about this practice/pattern?
What's bad about that practice/pattern?

I ask because if not, I'd like to - with your help!

Cheers, al.

2009/7/22 Jakub Narebski <jnareb@gmail.com>:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>> On Tue, Jul 21, 2009 at 11:08:31PM -0600, Tim Harper wrote:
>> >
>> > How has mastering the advanced features of git helped you to be a
>> > better programmer?
>>
>> I don't think that features itself make as big difference as the fac=
t
>> Git provides you much more flexibility in choosing a more appropriat=
e
>> workflow than you have with any centralized VCS. (Yes, you will stil=
l
>> find many Git features handy even if you work with it as you did wit=
h
>> CVS, but you will miss most benefits of Git).
>>
>> To really understand what benefits Git offers, you have to realize f=
irst
>> what is wrong CVS and CVS-like VCSes. Unfortunately, it is difficult=
 to
>> explain just in a few words. Some implementation deficiency of CVS i=
s
>> obvious (and it was addressed in some CVS clones like Subversion), b=
ut
>> more fundamental problems are far less obvious even for people who u=
sed
>> CVS for many years.
>
> See also my answer for "Difference between GIT and CVS" question
> at StackOverflow:
>
> =A0http://stackoverflow.com/questions/802573/difference-between-git-a=
nd-cvs/824241#824241
>
>> To be fair to CVS, it is far from the worst VCS. There are some insa=
ne
>> lock-based VCS, which were so painful to use (mostly due to these
>> exclusive locks but often due to some other insanity too) that anyon=
e
>> who worked with may think about CVS as a really nice system...
>
> By the way, even if CVS didn't implement support for file renames and
> copying, at least it provides support for file deletion (as opposed t=
o
> *khem* SourceSafe).
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
