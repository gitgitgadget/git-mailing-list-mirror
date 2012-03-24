From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sun, 25 Mar 2012 00:27:08 +0530
Message-ID: <CACeyogenMu2HO9iDBGgGmg0QvtdxY5cKcuGEeMAwckJsEi9RbQ@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203241417.10478.jnareb@gmail.com>
	<CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
	<201203241949.04956.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 19:57:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBW9N-0004lX-B1
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 19:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755584Ab2CXS5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 14:57:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58772 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130Ab2CXS5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 14:57:09 -0400
Received: by obbeh20 with SMTP id eh20so3521168obb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+2eH3leIuIFdhawfc03D5JQXNH9B8rg3XImDxiKXMfU=;
        b=K7d1SSSP6aoigLvh/1Hp6wuYkQ4G6SA3s7Yd/9cUDp99YsB2dEAIKQ2PTDTFsyQJHB
         P/1/ndcYs8FdTtwNzI/4fKqyiYZCnNNQnE7ESZbxrlt4fEKD7XVtJmGt5jrDsn0vyPmd
         0lhV0QFrlyXW9rAtIcl+adwtIu6epSrUuKpXvHRyQxro1AqWV+QsYgQgu30e4wcFs3a8
         wDlGoqcYG/okNAeM30QIzBxwq3C/fYz9IspTwki1MH3acJplpWGc5yZJT6REVd71bPoy
         8NTuDttHf8dUCWa2w2EEIOfclX6UcuhSiSrRQ51blp0PFV/VobK4WWnB3cvmsXsMuPui
         h/sw==
Received: by 10.182.188.38 with SMTP id fx6mr10557032obc.77.1332615428627;
 Sat, 24 Mar 2012 11:57:08 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sat, 24 Mar 2012 11:57:08 -0700 (PDT)
In-Reply-To: <201203241949.04956.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193838>

that's great ,thanks for your time and concern.I will carefully
consider each and every suggestion and approach you if i need any
clarification .

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
