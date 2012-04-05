From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: sparse-checkout test failures [powerpc-darwin8]
Date: Thu, 5 Apr 2012 12:35:58 +0700
Message-ID: <CACsJy8CTvXUq6W1tqXb0061Z5aFtvG1O8LkZuxXCfbQ909rHOQ@mail.gmail.com>
References: <Pine.LNX.4.64.1204041616001.16407@hal-00.csl.cornell.edu>
 <7v1uo389l8.fsf@alter.siamese.dyndns.org> <Pine.LNX.4.64.1204041736170.16407@hal-00.csl.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Fang <fang@csl.cornell.edu>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFfN7-0005uK-8H
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 07:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610Ab2DEFgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 01:36:31 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58373 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab2DEFga convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 01:36:30 -0400
Received: by wgbdr13 with SMTP id dr13so929545wgb.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 22:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j95CsL9QpiygRY4SyFm7u2uopP/ZoKc5ElTNDa3/yyc=;
        b=w5XzOJVwBP1a6gqaYjOapeQVNzZk4qcem/RYxgVjB7s/SBoqPjzUTMtbx99G7iplcb
         KR2hD79aSyQQFG4CNOfvRCiUpBrb8ZON3+r4O7aeftNlS0531qx6UlxvCMoiE+0aMCrB
         j+TeQESYEwCn2h0CRm5Rl1yTEtR9Tb9ktDUyyB/smsbh0+Z9KlDJSodP3f2ZjNuu8cI+
         cqfZRMK+53Y9FnlU+30/z3pxMwYyXXCETbZqTQjp01RSDKJHxWOEM9BY2o7+IgC4KeyG
         cuvldiqgC5iNN5gexUCy0PFlGVEFkveGWDhm1XKPagfGciKo9tAFhhh5dwNUL1nnFar2
         Evew==
Received: by 10.180.102.3 with SMTP id fk3mr1492568wib.9.1333604188880; Wed,
 04 Apr 2012 22:36:28 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Wed, 4 Apr 2012 22:35:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1204041736170.16407@hal-00.csl.cornell.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194758>

On Thu, Apr 5, 2012 at 4:41 AM, David Fang <fang@csl.cornell.edu> wrote=
:
>> David Fang <fang@csl.cornell.edu> writes:
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0With git 1.7.9.4, I'm seeing test failur=
es with
>>> t1011-read-tree-sparse-checkout.sh.
>>
>>
>> Hrm. =C2=A0Do you mean 1.7.9 worked and 1.7.9.4 doesn't, or you just=
 happened
>> to try 1.7.9.4 and do not know if this is a regression?
>> I do not have any Darwin or PowerPC boxes, but the answer to the abo=
ve may
>> help others who do to help diagnosing the issue further.
>
>
> Unfortunately, I didn't try any of the earlier 1.7.9.x releases, the
> previous one I tested was 1.7.8.4, which passed all tests (except for=
 known
> breakages, and a few other disabled tests).

Please try to bisect if you have time, or at least v1.7.9, and run
those two tests with "-v".
--=20
Duy
