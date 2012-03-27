From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Wed, 28 Mar 2012 02:05:18 +0530
Message-ID: <CACeyoge5iVAEebwj8NHo9VF=OO10M4sG4WegngBqr6qnsYvjQQ@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203251955.21454.jnareb@gmail.com>
	<CACeyogdhChrGe-k+VLkAzq1F9U1TFYsCN5Kc_u7jAwRhaz+fJQ@mail.gmail.com>
	<201203272114.33122.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:35:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCd70-0005ei-7w
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 22:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab2C0UfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 16:35:20 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52133 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260Ab2C0UfT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 16:35:19 -0400
Received: by obbeh20 with SMTP id eh20so326217obb.19
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NcOViEOeR6Llt7MXsodkIvA6HL3OZJMO9roEGqlvfd0=;
        b=lPVmTKiSTIJAmpMSuBUQF+nUxbcOtw9cQpoLleSixq37oRkLlGmPsuiTMZT2i+OgiT
         z5hmOry8cBpSWPXm8Vxxp5oShf1CujePRcsgTayO+u1L125zO3hnCNcl7u1EKiZJsGCi
         IILO4/KBKjEkFJIocsOnz7oyPENik5EBvPBED71W/9YmlJSvb5rndruvdJOouIowPz+c
         bXNjNIvWQoLjGedTrahyDcAJmmVPktAftzwOOZvVUS2Rt+w7bDRb6p2PzsayHGxaMsHR
         8bOKSF74TWzVlPtN8ThCbvhxC7zM35U3apynJcXL3tOu9ruymDjPS5xxO8qc/Z3VXZSl
         Htxw==
Received: by 10.60.28.137 with SMTP id b9mr34171536oeh.57.1332880518652; Tue,
 27 Mar 2012 13:35:18 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Tue, 27 Mar 2012 13:35:18 -0700 (PDT)
In-Reply-To: <201203272114.33122.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194084>

Dear Jakub,

I prepared a schedule for gsoc ,please take a look and suggest me in
case if you feel some tasks couldn't be completed with in indicated
time .

Week 1 =EF=83=A0 understanding how the whole gitweb and related server =
side
scripts are implemented , their design philosophy , coding standards ,
documentation standards to maintain the best practise coding
practices.  Brainstorming sessions regarding which libraries to use on
specific scenarios by keeping many criteria=E2=80=99s in mind and creat=
ing an
abstract design on the additional features  that have to be added.
Week 2 =EF=83=A0 Improving Javascript browser detection and incremental=
 blame.
Week 3 =EF=83=A0Improving UI of adjusting timezone by deciding which li=
brary /
framework to use on UI.
Week 4 & 5=EF=83=A0 design and implementation of client side sorting of=
 tables
and client side syntax highlighting of the blob view by handling how
git web splits the output into lines and providing line numbers.
Week 6 =EF=83=A0 testing the code robustly on as many browsers as possi=
ble
(with their versions) and documenting the code neatly .
MidTerm Delivarables : Improving javascript browser detection,
incremental blame,ui of adjusting timezone .Adding client side sorting
of tables and client side syntax highlighting of blob view .
Week 7 & 8=EF=83=A0 Using deferrands or queues in the interactive blame=
 to
avoid the editing of DOM which happens asynchronously to avoid
locking and automatic extending of clickable area for places where the
link is constrained to a single cell or of that type.
Week 9 & 10 & 11=EF=83=A0 design and implementation support for graphic=
al
representation of history in log ,shortlog and history using Raphael
javascript library, adding UI to compare arbitrary commits in the page
using commitdiff view similar to MediaWiki page history view and
creating a side by side diff from unified diff in javascript so that
switching between unified diff and side by side diff could be handled
on client side.
Week 12 =EF=83=A0 documentation , writing a detail report , testing
exhaustively and checking whether the written code follows the
characteristics .
Note: considerable amount of time will be spent each week
concentrating on design for adding a new feature since its design
greatly affects many things.

Thanks in advance.

yours sincerely,
chaitanya nalla.


On Wed, Mar 28, 2012 at 12:44 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Tue, 27 Mar 2012, chaitanyaa nalla wrote:
>> Jakub Narebski wrote:
>
>> > There was also some time ago a patch that added ability to mark a =
commit
>> > to compare current commit to (using JavaScript and cookies), to ha=
ve an
>> > UI to compare arbitrary commits using 'commitdiff' view. =C2=A0Or =
something
>> > similar to MediaWiki (Wikipedia) page history view.
>>
>> Hey jakub,
>>
>> Will that patch be included in future version, if it is the case can
>> i consider implementing with some enhancements??
>
> This idea is in my TODO list for gitweb, but I don't have specific pl=
ans
> on when it would be implemented (if at all).
>
> P.S. Please leave only relevant part of cited (quoted) response. =C2=A0=
Thanks
> in advance.
> --
> Jakub Narebski
> Poland
