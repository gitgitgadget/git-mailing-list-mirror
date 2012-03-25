From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sun, 25 Mar 2012 14:01:57 +0530
Message-ID: <CACeyogdkEdkYa+SQvUq50FU5P7ohq-tLf8tgi1v6o_HMM5bSsg@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203241417.10478.jnareb@gmail.com>
	<CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
	<201203241949.04956.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 10:32:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBirw-0005Fj-5v
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 10:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab2CYIcA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Mar 2012 04:32:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57712 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab2CYIb6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Mar 2012 04:31:58 -0400
Received: by obbeh20 with SMTP id eh20so3939119obb.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hjYbhIuTnfh31GDwKCLHouI1KAmIXVJF/ljdr7dG2bg=;
        b=JuczNRg62irSeipHPJSFvkjODq+ptsHyQsV2ClQU3OCf8qsyY/NBSWJF08wF/+3vFJ
         AUBFPJ1gWWIqn6viFlsCaGgmm1CgepB9qzf0MF7ZdFKWIWYnlsV4PIfe/hvQdpOfqO9a
         U1EPaOnUV+r1A5h6QGptsdvsuMqCkySXSQjbzk8ZaFZ6GFC2O/EVUJCVGSLg4nUMObJj
         +VWVL/Gjg62ljM/Qm3c5YmNGQQxOwA01Ai40gg/I0rXu9U8KQoWdUtMPT8oPRickroBy
         hTRgQrF/2TOXrlFb3j5eGHm+dRdOpU79PtR1hNAlmm40zs75109HOdj0H/giWRgaVz/M
         Rrnw==
Received: by 10.60.28.137 with SMTP id b9mr21830245oeh.57.1332664317958; Sun,
 25 Mar 2012 01:31:57 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sun, 25 Mar 2012 01:31:57 -0700 (PDT)
In-Reply-To: <201203241949.04956.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193861>

Dear Jakub,

    if we handle the sorting of the tables on the client side itself
,will that be a  load on the browser?
Other ideas which i have in mind are

1.Highligting matched portions of project name while searching the
project name ,even more intuitively
2.project pagination.

On Sun, Mar 25, 2012 at 12:19 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> On Sat, 24 Mar 2012, chaitanyaa nalla wrote:
>
>> Dear Jakub ,
>>
>> =A0could you please suggest any other ideas or features so that i ca=
n
>> think upon them and come up with further good ideas.
>
> One idea for additional feature that I have already mentioned, and wh=
ich
> I have put on https://github.com/peff/git/wiki/SoC-2012-Ideas is
> client-side sorting of tables, e.g. of list of all projects, a la
> jQuery / MediaWiki (Wikipedia) "sorttable".
>
> Another would be using deferreds or queues for interactive blame, so
> that repainting (editing DOM) happens asynchronously to avoid locking
> up browser, like in
> =A0http://www.nczonline.net/blog/2009/08/11/timed-array-processing-in=
-javascript/
>
> There was also some time ago a patch that added ability to mark a com=
mit
> to compare current commit to (using JavaScript and cookies), to have =
an
> UI to compare arbitrary commits using 'commitdiff' view. =A0Or someth=
ing
> similar to MediaWiki (Wikipedia) page history view.
>
>
> Yet another would be support for graphical representation of history =
in
> 'log', 'shortlog' and 'history' views e.g. using Raphael.js
>
> Perhaps it would be possible to employ some JavaScript syntax highlig=
hter
> to pretty-print contents of 'blob' view.
>
>
> Hope That Helps.
>
>
> P.S. You can see gitweb at work here:
>
> =A0http://git.kernel.org/?p=3Dgit/git.git
> =A0http://repo.or.cz/w/git.git
> --
> Jakub Narebski
> Poland
