From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [BUG] serious inflate inconsistency on master
Date: Wed, 4 Jul 2012 14:01:06 +0700
Message-ID: <CACsJy8AH6HHxE-P4j4O_VtVzz6-pe2VWk5ZayOfbZomfX2z7sg@mail.gmail.com>
References: <20120703221900.GA28897@sigill.intra.peff.net> <7vipe4tqns.fsf@alter.siamese.dyndns.org>
 <CACsJy8AFs6PV8XCAUar9KadE8g-WSaZofKQAGPB6VjbhVpSRig@mail.gmail.com> <7vy5n0rq9c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:01:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJap-0003HN-A5
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269Ab2GDHBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jul 2012 03:01:38 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62831 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab2GDHBh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2012 03:01:37 -0400
Received: by wibhr14 with SMTP id hr14so5166658wib.1
        for <git@vger.kernel.org>; Wed, 04 Jul 2012 00:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OnvLPcoFZClsg+6xS9qF1Xs5zK43EReVRGqk7MTSkPU=;
        b=zuSJDTGp4hRwQOsFQGQTbzPL9blo9bzGWHop+tLr++xzM97ECR5tP3xFH4Js9WeZN4
         CNPAHu87lBLKmtEa+C1EbL4/S7gS+CYCCS7vRXjaMWfV3XFvOpFRBfqz/nTpRHRDSuo/
         4V9BxG4xVK8FZpeNMt1CwFnJt7EGQzWogcp8HbR0Njh2gAKeWgTt0kOlgkhL1kKK392o
         IXkEQZfDVRWqSchQosmKo/fBe1Q1nORHibVBW8gEYe9nxv4vv5HcLYjuu/6J59zDS5tD
         lvYQvTCOnNBW7Ty2jvvmmQza+Gly0bOMGAyIZBEa5n4bNMCxRex3VWrDdCY/9or08PVH
         ttQw==
Received: by 10.216.173.136 with SMTP id v8mr3487687wel.167.1341385296273;
 Wed, 04 Jul 2012 00:01:36 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Wed, 4 Jul 2012 00:01:06 -0700 (PDT)
In-Reply-To: <7vy5n0rq9c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200986>

On Wed, Jul 4, 2012 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> By the way I searched the commit that introduces that check with "gi=
t
>> log --follow -p builtin/index-pack.c" but I could not find it. What
>> did I do wrong?
>
> Your commit 8a2e163cc shows changes to the file at ll.535-540; these
> come from 776ea370 builtin-index-pack.c ll.383-388.
>
> =C2=A0 $ git show 776ea370:builtin-index-pack.c

git newbie's hat's on. How do you find 776ea370, git-blame? Another
question is why doesn't git-log show that commit?
--=20
Duy
