From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sun, 25 Mar 2012 23:38:32 +0530
Message-ID: <CACeyogdCsFZEqmm057ZMcCYRuxiZ2-yfcV9+e1AdOOhTjne8vA@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203241949.04956.jnareb@gmail.com>
	<CACeyogdkEdkYa+SQvUq50FU5P7ohq-tLf8tgi1v6o_HMM5bSsg@mail.gmail.com>
	<201203251955.21454.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 20:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBrrr-00017p-9r
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 20:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490Ab2CYSIe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Mar 2012 14:08:34 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33637 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab2CYSId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Mar 2012 14:08:33 -0400
Received: by obbeh20 with SMTP id eh20so4253467obb.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 11:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oqYhAzg/FA7WnRK5Mi/IJBbh8RQetD2Sef6vNOZhe1E=;
        b=XxfYDZ2piQJEUoRAbSy7w9QidPvYe3YpfyeQAn+8iKR4Cccr09is7E24V0ysaDsufD
         tlSDwqjrRH61mKXTTugyL1XIKkui3Q2rE0gZI++7u8SEJMgoOjqss/sNuAGfhUg/3AEU
         fLs0nN5XCd5OXdjY5/qTClYsu2YTtFLKWrb0x4R4d+D2lxPJ0Wx/9ZPN8miOSbxxqxdU
         dS+blWp8eSn3bpTj6IYrLVvhnLxiPWh8Mhf+MupVviBLMKadlXxk25sEKG3EbcZwQ1A7
         +KRD4dybLLes8lbJFnGqV15QfMiRzSyaT4usU6/xoh3GHUnzd6bYGeK1vsrR4gR786h3
         yGYg==
Received: by 10.60.4.106 with SMTP id j10mr23292717oej.47.1332698913032; Sun,
 25 Mar 2012 11:08:33 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sun, 25 Mar 2012 11:08:32 -0700 (PDT)
In-Reply-To: <201203251955.21454.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193880>

Dear Jakub,

thanks again.
 creating side-by-side diff from unified  diff in JavaScript, so that
swicthing between unified and side-by-side
 diff view  could be done entirely client-side, without hitting the ser=
ver
could you please elaborate on this , i didn't understand this completle=
y.

On Sun, Mar 25, 2012 at 11:25 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Sun, 25 Mar 2012, chaitanyaa nalla wrote:
>
>> Dear Jakub,
>>
>> if we handle the sorting of the tables on the client side itself,
>> will that be a =A0load on the browser?
>
> Well, if it turns out to be too heavy a load, we can use the same tri=
ck
> of "timed array processing":
>
> =A0http://www.nczonline.net/blog/2009/08/11/timed-array-processing-in=
-javascript/
>
> See for example this page to see sorttable in action:
>
> =A0http://en.wikipedia.org/wiki/Comparison_of_open_source_software_ho=
sting_facilities
>
>> Other ideas which I have in mind are
>>
>> 1. Highligting matched portions of project name while searching the
>> =A0 =A0project name, even more intuitively
>
> You probably couldn't have known that match highlighting in project
> search is done on server side by gitweb.cgi since commit 6759f95
> (Merge branch 'jn/gitweb-hilite-regions', 2012-03-04):
>
> =A0gitweb: Highlight matched part of shortened project description
> =A0gitweb: Highlight matched part of project description when searchi=
ng projects
> =A0gitweb: Highlight matched part of project name when searching proj=
ects
>
> It is not used by either git.kernel.org or repo.or.cz because it is
> too fresh (it is to be in yet to be released v1.7.10).
>
>> 2. project pagination.
>
> Is there any sense in pagination on client side? =A0Unless you turn i=
t into
> lazy loading / loading on demand Ajax-y pagination...
>
>
> Yet another idea is to implement creating side-by-side diff from unif=
ied
> diff in JavaScript, so that swicthing between unified and side-by-sid=
e
> diff view could be done entirely client-side, without hitting the ser=
ver.
>
>
> Note however that I think that it wouldn't be possible in time given =
to
> implement all those ideas. =A0You need to select those of them that y=
ou
> will put in project application.
>
> --
> Jakub Narebski
> Poland
