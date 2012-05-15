From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ls-tree and wildcards
Date: Tue, 15 May 2012 18:29:53 +0700
Message-ID: <CACsJy8AdoOcUxq+pmhAPxiPAiQc60aCLf7Jt31YFW4+6OHZEEg@mail.gmail.com>
References: <4FAE7CBD.3020605@rotorised.com> <7vbolqiuh1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ryan McCue <lists@rotorised.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 15 13:30:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUFxY-0006xS-Ra
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 13:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757793Ab2EOLa0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 07:30:26 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43372 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653Ab2EOLaZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 07:30:25 -0400
Received: by wibhn6 with SMTP id hn6so3468903wib.1
        for <git@vger.kernel.org>; Tue, 15 May 2012 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5+uVB0xoHz4jHGmbHDsqHRTrjgEWEOgkaOQni/bQTYg=;
        b=RBEXdRIL5k1itZ2cXm43oN385YIky921TNc8KbFcdh+S6OLh6PxjhTPzSJBANFko7W
         cFmA1aSbC5mfgZWNY9SEm4kM49ZPX7L11LE+GUjR65saq24xmA3Z5L/o2HMH/3PrJtuh
         x75iTKf5f9geEj8vHAiPCYft62Ckw5DRvrGKSifXxrF8Wng7jaFGEGhwQ9pTM6bcPc93
         Bvw3zyZRfqUELsPztOpbcIwt7vYqiQEIOtbwx2j5Bme1k6UK0wbsmuoDVHidpOFyfKPD
         biBHjC+WnViJy0XV8eGHY961GzY56OqBUJQRSld6lkLO/NdbV+/dN/eUNz9+V1RBrYIA
         OZ0w==
Received: by 10.216.132.226 with SMTP id o76mr7499276wei.93.1337081423842;
 Tue, 15 May 2012 04:30:23 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Tue, 15 May 2012 04:29:53 -0700 (PDT)
In-Reply-To: <7vbolqiuh1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197828>

On Mon, May 14, 2012 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Later Nguyen and others started working on unifying the two separate
> "pathspec" semantics and we are probably halfway there. =C2=A0Many of=
 the
> commands from "diff/log" family now can take wildcard (there may be n=
ew
> bugs in the codepaths, though), but "ls-tree" has not been converted.

Do we break backward compatibility by teaching ls-tree new pathspec
semantics? I guess directories with wildcards in the name are rare,
the chance of someone doing "ls-tree a*" is low. But I may miss
something.
--=20
Duy
