From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 2/2] bundle: add parse_bundle_header() helper function
Date: Fri, 14 Oct 2011 08:59:20 -0400
Message-ID: <CABURp0otqxeKjLe-Rk3htZRa0M7+rerfrbVrXx-7Dr1tK3tTTg@mail.gmail.com>
References: <7vpqi034l0.fsf@alter.siamese.dyndns.org> <7vliso34gc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Phil Hord <hordp@cisco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 14:59:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REhMZ-0003T4-IX
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 14:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756507Ab1JNM7n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 08:59:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54371 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1JNM7m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 08:59:42 -0400
Received: by eye27 with SMTP id 27so1108724eye.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ePCU0dIzGITol+RU7Df9rXVTlXc2kXWpgKI42dcAtIQ=;
        b=f5pA94XiFuV6gOB1hpgYVul9l+g9fEOHAfKbRcymxFDfvrK33NALuqfuAr7YsrGoKA
         rPBVA2hWNYT48sgrTc62qJZ7aaDPH2NkdeZrFdiDq3LxzXNO6BhG4fvRNZP3Jj69uISC
         U3TD68QtkFaF2LDfK8r+5046Br8ARpuCaIAZM=
Received: by 10.216.138.221 with SMTP id a71mr3010371wej.102.1318597181134;
 Fri, 14 Oct 2011 05:59:41 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Fri, 14 Oct 2011 05:59:20 -0700 (PDT)
In-Reply-To: <7vliso34gc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183569>

On Thu, Oct 13, 2011 at 6:35 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Move most of the code from read_bundle_header() to parse_bundle_heade=
r()
> that takes a file descriptor that is already opened for reading, and =
make
> the former responsible only for opening the file and noticing errors.
=2E..

> =A0* It generally is a bad practice to base a non-RFC patch on an RFC=
 one,
> =A0 but in any case here is how I would do the is_bundle() helper.

I didn't label it RFC, but I did pose a question in the message
section.  Is there a rule for what marks something as RFC (if not the
RFC label in the subject line)?

Your implementation looks fine to me.

Phil
