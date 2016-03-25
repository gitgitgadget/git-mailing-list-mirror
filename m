From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [PATCH v3/GSoC 3/5] git-credential-cache: put socket to
 xdg-compatible path
Date: Sat, 26 Mar 2016 02:00:30 +0800
Message-ID: <CAKqreuyOGk=iZes_bgiBpnO5Ht+9VzZG3_j5H33i6qtBx1R5nQ@mail.gmail.com>
References: <1458728005-22555-1-git-send-email-huiyiqun@gmail.com>
	<1458728005-22555-3-git-send-email-huiyiqun@gmail.com>
	<20160325100041.GC8880@sigill.intra.peff.net>
	<CAKqreuzwa+ztwsF3CRb++J-iqW=_evfBQ7Q7veyYU2ydJXnpcg@mail.gmail.com>
	<20160325175635.GB10563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Your friend <pickfire@riseup.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:00:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajW2G-0001Ko-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610AbcCYSAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 14:00:32 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36030 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbcCYSAc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 14:00:32 -0400
Received: by mail-oi0-f67.google.com with SMTP id k128so1135685oig.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=+Pyk65v/YIxHLi6CpmRKHzG5NrGV2wBTRjxrgDEc2Js=;
        b=YXJOfGsyNyzGU7olrmG3//CBE7sWv3y60qZOroar522zYm++1uUgNXglMIH1v9C3NV
         AP4h3OYU+PCziH05yEioqMlCA7I1jd+qu92joxcCKrJEPSuDsEZ8DMtmlxFUMtNMRdFK
         C+uOyVa+XCeUYFNXXRRPLY8FbjSNZkO6ix+z/MjyI3nhM76Y+Br13anWx6qX8aIaq/M7
         nyKWyj++J8ROazvshzARFFpHRoJ55Q6bchGEzmvS/xY844scyREkL4famWXlZ8gGk53q
         VcJQfEww2wsbaxPKNkRRXKZl7VGzTWh/kp9g7VTvY8H6aQbydPnXzq47nxUAvcuC+cZS
         7APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=+Pyk65v/YIxHLi6CpmRKHzG5NrGV2wBTRjxrgDEc2Js=;
        b=XfgsMBdUn9wdX3xiCH3rRAzNCzHyHLsi0nr2KW3t2q9XhGQ9LrRPX/lGbk5LRdugJP
         miadZDEcbVlrMvWaauuWvIas90aiBiaSd4RQIzaVc8V2z3K8EunjiuLCIHA6rct8EOvQ
         1qs3kqDVUfds3Iuyk1MRKiwnH4VgBl4px8pruq9IE0r/AyuEXStaY+Yj+zNj4C1bGJox
         h7zN41c5N3h4QOxBy64jTPpLnfb4+74H15g+t3I9b7avQ5Bznzcbmf8oS6S4JUjFVK9Y
         Eb+o9siWYbZwG4PlIDwpOpilcWdffXxNQ+fOtnrlxln+UeWUnje7Ajy7Kwn+JeD+35Jw
         VCFw==
X-Gm-Message-State: AD7BkJKGXer7d3ZKo6NJ3sweN2M4ZOH3/dnSwCgRPgAZPAwHEIYuptC05jqhqX2oxrZt76lM/VXHOlRBMWuwzg==
X-Received: by 10.157.49.116 with SMTP id v49mr7525714otd.97.1458928830738;
 Fri, 25 Mar 2016 11:00:30 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 11:00:30 -0700 (PDT)
In-Reply-To: <20160325175635.GB10563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289921>

2016-03-26 1:56 GMT+08:00 Jeff King <peff@peff.net>:
> On Fri, Mar 25, 2016 at 10:28:55PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4=
 wrote:
>
>> >> diff --git a/credential-cache.c b/credential-cache.c
>> >> index f4afdc6..40d838b 100644
>> >> --- a/credential-cache.c
>> >> +++ b/credential-cache.c
>> >> @@ -105,7 +105,7 @@ int main(int argc, const char **argv)
>> >>       op =3D argv[0];
>> >>
>> >>       if (!socket_path)
>> >> -             socket_path =3D expand_user_path("~/.git-credential=
-cache/socket");
>> >> +             socket_path =3D xdg_runtime_dir("credential-cache.s=
ock");
>> >>       if (!socket_path)
>> >>               die("unable to find a suitable socket path; use --s=
ocket");
>> >
>> > We do our own mkdir and chmod in credential-cache; this should be
>> > redundant with what xdg_runtime_dir() does, and can be removed, ri=
ght?
>>
>> But user may specify another path via --socket <path>, this path may=
 have
>> wrong permission. I'm considering how to handle this situation.
>
> Good point, we do need to cover that case.
>
> Perhaps the work done by xdg_runtime_dir() needs to be split into two
> fucntions: one to just provide the path, and the second to securely
> create a given path.

Good, I will implement it like that.

>
> -Peff
