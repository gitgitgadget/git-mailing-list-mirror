From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 16:53:25 -0500
Message-ID: <CAMP44s1mnz2A20bNo2um9BhO=b3WOtOGWundXuH+5nYNNDcKxA@mail.gmail.com>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
	<1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
	<20130903071256.GD3608@sigill.intra.peff.net>
	<20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 23:53:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGyXS-0000GB-OI
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 23:53:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760885Ab3ICVx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 17:53:27 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56432 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760322Ab3ICVx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 17:53:26 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so4940600lbh.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 14:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6ffY+bZhQP2M9cQOINTDg8T6iS1btnwVKEIy7ztxMcg=;
        b=QTyil7b6Yum0i28kVYI0vPD3QQi+E4CoUEg2OnK0BrpI1SOZ/n4gO+aPVuDr5RFbPk
         +9t2d5TJFD6XCYBbEdEuh+oi96nf8s+jrpPAcQ+D4SRJbAx+IoXkArx+/g/s5cqWB8AX
         xEkxaQVUUZYDInRcOA8DjF8JEHncVR4GPPxpKvQlEBDKEppPLa37B5gWREJuG9wbYilV
         gvJefAkQ/bvQafjPADKCUf7tiAZueQRf9yvOVWxW7ZKCSPXnuY6lftON+6FtKSgFN/bk
         oLrUAfgET5ECf2RDYmoYDjue4dXeh41ac7G6114bpDDD1mVQcqTQMWMbKYBOpbBFRbCY
         l1dA==
X-Received: by 10.112.168.35 with SMTP id zt3mr27026043lbb.11.1378245205280;
 Tue, 03 Sep 2013 14:53:25 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Tue, 3 Sep 2013 14:53:25 -0700 (PDT)
In-Reply-To: <20130903170419.GA29921@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233786>

On Tue, Sep 3, 2013 at 12:04 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> SZEDER G=C3=A1bor wrote:
>> On Tue, Sep 03, 2013 at 08:39:54AM -0500, Felipe Contreras wrote:
>
>>> There are two ways to fix an inconsistency, the other way is to fix
>>> test_cmp. But that would be a change, and change is not welcome in
>>> Git.
>>
>> It depends on the change, I suppose.  I agree, changing 3k+ lines ju=
st
>> to avoid yoda conditions...  I doubt the gain worth the code churn.
>
> Especially when the idiom being changed is not even being made better=
=2E
> ;-)

But it is better.

> test_cmp_rev follows the same order of arguments a "diff -u" and
> produces the same output as plain "git diff".  It's perfectly readabl=
e
> and normal.  I think Felipe is pushing buttons and testing boundaries=
=2E

Those are irrelevant implementation details.

--=20
=46elipe Contreras
