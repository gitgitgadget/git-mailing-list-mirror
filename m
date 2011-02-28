From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Mon, 28 Feb 2011 11:01:39 +0100
Message-ID: <AANLkTikpYAFpj8ciqkgbEyQWiphy3FVQKAW+_+mz--V_@mail.gmail.com>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
	<4D68D630.9000608@drmicha.warpmail.net>
	<711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
	<AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
	<7v39n8ll0s.fsf@alter.siamese.dyndns.org>
	<4D6B5D09.8010806@drmicha.warpmail.net>
	<vpqwrkkpkea.fsf@bauges.imag.fr>
	<4D6B6F97.8030409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 11:01:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtzvJ-0006Lb-Jo
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 11:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab1B1KBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 05:01:42 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59207 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab1B1KBl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 05:01:41 -0500
Received: by qwd7 with SMTP id 7so2679943qwd.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SxV+v02hgc+YNqwtc5vRmbCTWwTlHU664zWwtwhOXHE=;
        b=uVaH+PJ6RkWG4kHuXhITr082T6z9yuRPG0fswpaho2e15AXhoBj2uIi+Vo/pdHMMuN
         dsaAmP3J//MZ2eusovZuNzd1ssV1O7mMrmFkKyZTWtflkIZZUnxTumhRU8GrhyLx+upj
         lwBwRXom29Lhf/F5jsMygWIU1MMYXXh/J/wzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=ckGwIE41UiTExKgmgGXkbuEEpJxUrYvxmpoqV9qFiH0keb8g9Imi8P4OCOD4GSnDbj
         g7wBCp3nMRIE0oPHaVT/BaVw2gXPO06fTVeVghAo8VOw3JRYenjMpODVCbDfhfL877hH
         fJErvkJgsyIcEhdrBSld7PJME/RAKZf9DHpGM=
Received: by 10.229.94.10 with SMTP id x10mr111869qcm.228.1298887299387; Mon,
 28 Feb 2011 02:01:39 -0800 (PST)
Received: by 10.229.75.209 with HTTP; Mon, 28 Feb 2011 02:01:39 -0800 (PST)
In-Reply-To: <4D6B6F97.8030409@drmicha.warpmail.net>
X-Google-Sender-Auth: 7EZTz4dkBrCohek84HU8TqmyRG8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168093>

On Mon, Feb 28, 2011 at 10:49, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> No no, I said "add" would default to what "-u" does now (see below).

add -u adds untracked files. An explicit operation by the user. I hope
you really don't mean that just 'git add' would add all untracked
files? That would cause a terrible mess if someone just enters 'git
add' (which they could very well do in other situations than just
after 'git init', there are many casual git users out there.)

-Tor
