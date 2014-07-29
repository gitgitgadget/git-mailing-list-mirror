From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "error: Tweaking file descriptors doesn't work with this
 MSVCRT.dll" on wine
Date: Tue, 29 Jul 2014 20:05:38 +0700
Message-ID: <CACsJy8Att+O7fF-2mMjqkfm75yXihfJNWutGDAqUkZs34pKLGw@mail.gmail.com>
References: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com>
 <53D73F7D.1010902@web.de> <53D7917B.8060100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Stefaniuc <mstefani@redhat.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 15:06:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC76c-0002DQ-F0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbaG2NGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:06:09 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:48522 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbaG2NGI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 09:06:08 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so8511466ieb.21
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KUkKop6app0edt7JZS3ejA4ogy8ae4J3gsZ7ZIdqBz4=;
        b=tJIRFS/4eZO8M0oYlfHW5b7jTv3nGVb79O3fWIAQiWoQzjxQDzconZZ/NZUweUlUe5
         CIHt4k0zCbC0EzPbKD4jC+f+rnaBHjbVwjsfyvjqLPFFrQteVb29a7PkVqJALqPzJ4N1
         4nEeURPErZsjVSNG9e1A7FWm4suOWg/AhRROutFKAnrcOkj4oD0g3yf8UAL8dNKQ/4+h
         p7+99ZzNYP+Yc+nnlqy+zhfD86md4rdljB9xA/J1qztBdZhN8UT0uSce91YqU/hySgRb
         JxfyzUhwWyzLEa2Th5QKKxT73MXBvGDsIoEBCvHtmccGPAEifcQ91xuX9aBBVSsSSnxj
         8r9w==
X-Received: by 10.43.129.74 with SMTP id hh10mr5414519icc.48.1406639168061;
 Tue, 29 Jul 2014 06:06:08 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Tue, 29 Jul 2014 06:05:38 -0700 (PDT)
In-Reply-To: <53D7917B.8060100@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254429>

On Tue, Jul 29, 2014 at 7:20 PM, Michael Stefaniuc <mstefani@redhat.com=
> wrote:
> On 07/29/2014 08:30 AM, Torsten B=C3=B6gershausen wrote:
>> On 07/28/2014 12:39 PM, Duy Nguyen wrote:
>>> I know wine is kind of second citizen but is there a cheap trick to
>>> make it work on wine? Reverting fcd428f (Win32: fix broken pipe
>>> detection - 2012-03-01) could result in conflicts in compat that I'=
m
>>> not comfortable resolving. I don't have Windows at home. Wine is th=
e
>>> only option for me (or if somebody has a modern.ie image for KVM, o=
r a
>>> simple recipe to make one, that'd be great). "Fix wine" is not real=
ly
>>> an option.
> Why is fixing Wine not an option? The guy working on MSVCRT in Wine i=
s
> very responsive; all that is needed is just a bug in
> https://bugs.winehq.org/ and he'll look at it. Or give me more detail=
s
> and I'll create the bug entry.

Not an option as in "_I_ will be working on it". I don't suppose lots
of people use git on wine to be worth the trouble, but then again
making wine msvcrt more compatible is probably a good thing so I'll
open a bug for wine.
--=20
Duy
