From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into modules
Date: Wed, 24 Aug 2011 07:47:03 +0530
Message-ID: <CAK9CXBUsEN=avE1c=RvLVf5ws9B6rZ4tP=gyaWpOPQa=y0qZAw@mail.gmail.com>
References: <1304431450-23901-1-git-send-email-jnareb@gmail.com>
 <1314131735.3120.3.camel@kheops> <4E54102D.8060900@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 04:17:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw321-0007vi-TN
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 04:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab1HXCRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 22:17:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47396 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab1HXCRY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 22:17:24 -0400
Received: by fxh19 with SMTP id 19so664872fxh.19
        for <git@vger.kernel.org>; Tue, 23 Aug 2011 19:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=in6JYmhFW76OgSpCTexCZJhNg2OLgMAULv2Gmev1VB8=;
        b=WZPUcfWBUQ6yF8AVy4hYbVTkB/HDsa9no5W+pbqcDF04aKu/VKz4sNjMIuIMipH1aY
         GiGL8ttqoPdpIl2W3MdIiLizisrrXCSu2viTiQPeGIhzarCcAyH7pCxVOiU9Dl9q9hWT
         KM7DlXF6jXwTzz0cmGM/MGMLOEkXSY/DpadOI=
Received: by 10.223.7.7 with SMTP id b7mr6417925fab.9.1314152243064; Tue, 23
 Aug 2011 19:17:23 -0700 (PDT)
Received: by 10.223.70.203 with HTTP; Tue, 23 Aug 2011 19:17:03 -0700 (PDT)
In-Reply-To: <4E54102D.8060900@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179985>

I can try to restart it. I had a lot of health issues last year, But I
am free now to finish this series.

On Wed, Aug 24, 2011 at 2:10 AM, J.H. <warthog9@eaglescrag.net> wrote:
> Pretty much stalled like most things on gitweb. =A0I've been knee dee=
p in
> a lot of GSoC stuff, conferences and dealing with kernel bugs and Jak=
ub
> has been busy on other things so we haven't had a solid head bashing
> session to get this all worked out yet.
>
> Maybe while I'm over in Prague / Europe for KS & Linuxcon we can hash
> things out.
>
> - John 'Warthog9' Hawley
>
> On 08/23/2011 01:35 PM, Sylvain Rabot wrote:
>> Hi,
>>
>> Just wanted to know what is the current status of splitting gitweb
>> sources into modules.
>>
>> Regards.
>>
>> On Tue, 2011-05-03 at 16:04 +0200, Jakub Narebski wrote:
>>> Gitweb is currently next to largest file (after gitk) in git source=
s,
>>> more than 225KB with more than 7,000 lines. =A0Therefore adding any
>>> large feature that would require large amount of code added, like
>>> gitweb caching by J.H. and my rewrite of it, or "gitweb admin/write=
"
>>> [failed] GSoC 2010 project by Pavan Kumar Sunkara, would require fo=
r
>>> new code to be added as a separate module. =A0Otherwise gitweb woul=
d
>>> fast become unmaintainable.
>>>
>>> Note that there is already patch series sent which as one of side
>>> effects splits the JavaScript side of gitweb into many smaller
>>> self-contained files:
>>>
>>> =A0 [PATCH 03/13] gitweb: Split JavaScript for maintability, combin=
ing on build
>>> =A0 http://thread.gmane.org/gmane.comp.version-control.git/172384/f=
ocus=3D172385
>>>
>>> Not in all cases splitting gitweb upfront would be required. =A0At =
least
>>> in the case of gitweb caching it doesn't. =A0What must be done howe=
ver
>>> is preparing the infrastructure for modular gitweb sources; to
>>> properly test such infrastructure we need at least one split gitweb
>>> module. =A0With patch series preparing for splitting or true splitt=
ing of
>>> gitweb sent upfront the future patch series that implements
>>> code-extensive feature (like e.g. output caching) would be smaller =
and
>>> easier to review.
>>>
>>>
>>> This series is intended to bring such infrastructure to gitweb, to
>>> prepare way for adding output caching to gitweb. Alternatively it c=
an
>>> be thought as beginning of splitting gitweb into smaller submodules=
,
>>> for better maintainability.
>>>
>>> This patch series was sent to git mailing list as
>>>
>>> =A0 [PATCH 0/2] gitweb: Begin splitting gitweb
>>> =A0 http://thread.gmane.org/gmane.comp.version-control.git/165824
>>>
>>> In the above mentioned first version of this series, the first patc=
h
>>> that prepared the way for splitting gitweb was in three versions: A=
, B
>>> and C. =A0In this second version of this series the first patch in
>>> series most closely resembles version C in v1 series.
>>>
>>> In this version gitweb uses _both_ 'use lib __DIR__."/lib";' and
>>> 'use lib "++GITWEBLIBDIR++";', in correct order (as compared to
>>> version C of v1 series), so that __DIR__."/lib" is checked first,
>>> i.e. modules installed alongside gitweb.cgi win.
>>>
>>> Pull request:
>>> ~~~~~~~~~~~~~
>>> This series is available in the git repository at:
>>> =A0 git://repo.or.cz/git/jnareb-git.git gitweb/split
>>> =A0 git://github.com/jnareb/git.git gitweb/split
>>>
>>> Well, those patches has a few minor cosmetic fixups...
>>>
>>> Table of contents:
>>> ~~~~~~~~~~~~~~~~~~
>>> * [PATCHv2 1/2] gitweb: Prepare for splitting gitweb
>>> =A0 [PATCHv2 2/2] gitweb: Create Gitweb::Util module
>>>
>>> =A0 First patch implements infrastructure, second proof of concept =
patch uses
>>> =A0 this infrastructure, testing it ("make -C gitweb test-installed=
").
>>>
>>> Shortlog:
>>> ~~~~~~~~~
>>> Jakub Narebski (1):
>>> =A0 gitweb: Prepare for splitting gitweb
>>>
>>> Pavan Kumar Sunkara (1):
>>> =A0 gitweb: Create Gitweb::Util module
>>>
>>> Diffstat:
>>> ~~~~~~~~~
>>> =A0gitweb/INSTALL =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 ++
>>> =A0gitweb/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 23 ++++++-
>>> =A0gitweb/gitweb.perl =A0 =A0 =A0 =A0| =A0151 ++++-----------------=
------------------
>>> =A0gitweb/lib/Gitweb/Util.pm | =A0177 +++++++++++++++++++++++++++++=
++++++++++++++++
>>> =A04 files changed, 219 insertions(+), 139 deletions(-)
>>> =A0create mode 100755 gitweb/lib/Gitweb/Util.pm
>>>
>>
>
>



--=20
- Pavan Kumar Sunkara
