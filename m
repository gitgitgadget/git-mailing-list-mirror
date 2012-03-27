From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Tue, 27 Mar 2012 20:25:04 +0530
Message-ID: <CACeyogd4NBto3SRU-0uCPzpUiVyEJpA=giEc7zvsZ06b-m9b0Q@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203241949.04956.jnareb@gmail.com>
	<CACeyogdkEdkYa+SQvUq50FU5P7ohq-tLf8tgi1v6o_HMM5bSsg@mail.gmail.com>
	<201203251955.21454.jnareb@gmail.com>
	<CACeyogdhChrGe-k+VLkAzq1F9U1TFYsCN5Kc_u7jAwRhaz+fJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 16:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCXnl-0001RB-2w
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 16:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab2C0OzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 10:55:08 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62878 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab2C0OzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 10:55:05 -0400
Received: by gghe5 with SMTP id e5so4690098ggh.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Z0fGGDg+4FEqXDllH5tKH8NYq8pL8C/EWNAz8OdIEPo=;
        b=LFNrjvp22LH1df6umPMAc9eLRO4/oNIzflirGDjN+treG0Pj/IBgEyebmbPQecPwc2
         quXX8jQQyuLrvrVIZZakiMgK2AT4HJ2FLyDP+LA2LNnFfZwVX5eSAuAhZueheOnsK3OB
         xLkWROjP7Kq7gIxL0z44xk9vjGQawEyzepJHTqiQdooLEniBFpwDP0l2+7ga37wwfRdL
         YFdud5oxfNIwksgxvDitxCgtAxifgg8NS+p0yVWqda5sKgCbTp5aIewN4Mib2wmSubDo
         ym9NDKmJPCGtGUgo7RhswnCCAgYhS8VhsDFZ72VjCs1Yfi2tDsZyb7tmRdhw0PXW/jr3
         alWQ==
Received: by 10.60.4.170 with SMTP id l10mr32568957oel.67.1332860104946; Tue,
 27 Mar 2012 07:55:04 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Tue, 27 Mar 2012 07:55:04 -0700 (PDT)
In-Reply-To: <CACeyogdhChrGe-k+VLkAzq1F9U1TFYsCN5Kc_u7jAwRhaz+fJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194047>

On Tue, Mar 27, 2012 at 8:23 PM, chaitanyaa nalla <nallachaitu@gmail.co=
m> wrote:
>>There was also some time ago a patch that added ability to mark a com=
mit
>>to compare current commit to (using JavaScript and cookies), to have =
an
>> UI to compare arbitrary commits using 'commitdiff' view. =A0Or somet=
hing
>> similar to MediaWiki (Wikipedia) page history view.
>
> Hey jakub,
> will that patch be included in future version , if it is the case can
> i consider implementing with some enhancements??
>
>
>
> On Sun, Mar 25, 2012 at 11:25 PM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>> On Sun, 25 Mar 2012, chaitanyaa nalla wrote:
>>
>>> Dear Jakub,
>>>
>>> if we handle the sorting of the tables on the client side itself,
>>> will that be a =A0load on the browser?
>>
>> Well, if it turns out to be too heavy a load, we can use the same tr=
ick
>> of "timed array processing":
>>
>> =A0http://www.nczonline.net/blog/2009/08/11/timed-array-processing-i=
n-javascript/
>>
>> See for example this page to see sorttable in action:
>>
>> =A0http://en.wikipedia.org/wiki/Comparison_of_open_source_software_h=
osting_facilities
>>
>>> Other ideas which I have in mind are
>>>
>>> 1. Highligting matched portions of project name while searching the
>>> =A0 =A0project name, even more intuitively
>>
>> You probably couldn't have known that match highlighting in project
>> search is done on server side by gitweb.cgi since commit 6759f95
>> (Merge branch 'jn/gitweb-hilite-regions', 2012-03-04):
>>
>> =A0gitweb: Highlight matched part of shortened project description
>> =A0gitweb: Highlight matched part of project description when search=
ing projects
>> =A0gitweb: Highlight matched part of project name when searching pro=
jects
>>
>> It is not used by either git.kernel.org or repo.or.cz because it is
>> too fresh (it is to be in yet to be released v1.7.10).
>>
>>> 2. project pagination.
>>
>> Is there any sense in pagination on client side? =A0Unless you turn =
it into
>> lazy loading / loading on demand Ajax-y pagination...
>>
>>
>> Yet another idea is to implement creating side-by-side diff from uni=
fied
>> diff in JavaScript, so that swicthing between unified and side-by-si=
de
>> diff view could be done entirely client-side, without hitting the se=
rver.
>>
>>
>> Note however that I think that it wouldn't be possible in time given=
 to
>> implement all those ideas. =A0You need to select those of them that =
you
>> will put in project application.
>>
>> --
>> Jakub Narebski
>> Poland
