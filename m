From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 10/9 v4] difftool: fix regression in '--prompt' options
Date: Thu, 22 Mar 2012 15:01:12 -0400
Message-ID: <CAFouetj+myKuUqw3-SwnbZ-=Sey29q9xYdaW4noHp_ebkmrk-A@mail.gmail.com>
References: <1332358560-13774-4-git-send-email-tim.henigan@gmail.com>
	<1332381236-16004-1-git-send-email-tim.henigan@gmail.com>
	<7viphxz37j.fsf@alter.siamese.dyndns.org>
	<871uoljbe9.fsf@thomas.inf.ethz.ch>
	<CAFouetjqzAwCe3mHkpJB4Xod4rJEF9OD77ch906TGUd9+-KZWA@mail.gmail.com>
	<7v3990zi5h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	davvid@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:01:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnGA-0005ae-Kc
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759142Ab2CVTBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 15:01:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65408 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab2CVTBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2012 15:01:13 -0400
Received: by iagz16 with SMTP id z16so3478800iag.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nS6U1ZzLvSph+lE1zdHiLKqMkSFabbojFuhWIItDasI=;
        b=V+j4u9m7jJ95emKCsNY9Gbu/JfDsYziszI67NHTSndv5s6eeabH1BkFgi2hq/qV2Nu
         H3y9bP9tvzUxaml3St+UqWoldtPKSNyDf5/frtantIhVFSITYapygQgdw5NubSADNfth
         UwEs/wbFGCrDYczpGazJMyGNyAsNzLAkTguS+I7XYj8rmPu7lOWizjIRVCG2oYMEFd+B
         9Pxff2JKP5n2OIPH4poGnFm6q+jjeB6+B1vqUOB867wTsNNBl6vwtgONajExIp3XlWPa
         mTiApjSIV1lFUZUqK8B8SYBjud26tygjyi95uFGVhWBoyp+kzFX60L/w7jOjDjzhdaQe
         bhwQ==
Received: by 10.42.142.136 with SMTP id s8mr5624110icu.36.1332442872632; Thu,
 22 Mar 2012 12:01:12 -0700 (PDT)
Received: by 10.42.138.5 with HTTP; Thu, 22 Mar 2012 12:01:12 -0700 (PDT)
In-Reply-To: <7v3990zi5h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193688>

On Thu, Mar 22, 2012 at 12:59 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> v5 of the patch will use Getopt to parse the '--[no-]prompt' options
>> again. =C2=A0I will also add a new patch to the series to implement
>> '--no-gui'.
>
> Sensible. =C2=A0At that point, it should be rolled into an updated [1=
/9] so
> that Getopt::Long is used correctly from the get-go, I think.

That sounds reasonable.  I will re-roll the series with the following c=
hanges:
  - Squash "fix regression in '--prompt' options" into the first patch
  - Squash "teach dir-diff to copy modified files back" into the
implementation of --dir-diff
  - Squash "add test for difftool --tool-help" into implementation of
--tool-help
  - Squash "add tests for difftool --dir-diff" into the implementation
of --dir-diff
  - Reorder so that "add '--no-gui' as an option" is patch #2
(immediately after change to Getopts::Long)

This should make the series look cleaner and also insure that new
features and their tests are added in the same commit.

I will resend the entire patch series (will be v6) when this is done.

Does this sound like a good plan?
