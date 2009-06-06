From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 18/23] http-push.c::remote_exists(): use the new http API
Date: Sat, 6 Jun 2009 09:03:04 +0800
Message-ID: <be6fef0d0906051803w7be60788vc48752350d578308@mail.gmail.com>
References: <20090606000557.18c55768.rctay89@gmail.com>
	 <m33aae5rn2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:03:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkJW-0004vB-0l
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbZFFBDG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 21:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbZFFBDD
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:03:03 -0400
Received: from mail-px0-f202.google.com ([209.85.216.202]:55293 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbZFFBDD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 21:03:03 -0400
Received: by pxi40 with SMTP id 40so307037pxi.33
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dixM3EPAP2dGbLHZRqBHzVdVhlfxzCbfftB+HMhqSgg=;
        b=q0gHlCvkC1w4zObcxA2GHRfb1bNv4qmhbUclvEm9OAKtbEjUXnExSZS+7O4uYuea4X
         1Epksbex9AwAZoJg7D0RGRUu8fBtbv6aC/9RUDQVuchJkM3yIM+MnAYbTzjlunbdgaea
         k4IsecI30uV+XmhLWuhwhCRMmZsfn/0rbbkJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qw/h/IZvpOcqNjAStvylaz7JdfUD66ChXolYx0ZcpUbmeVJw2Ldf5wmhStsL8a7q1H
         oYYH8dP0uuGNLlfQYVDZux1l11JMcuiXRempszBYDORteuuPATpOYhEkthX9zDV0V2+P
         aSgPzplb1TGZSwjdBNPRYUOz4mJWQae+T+0Ys=
Received: by 10.142.103.11 with SMTP id a11mr1596220wfc.303.1244250184389; 
	Fri, 05 Jun 2009 18:03:04 -0700 (PDT)
In-Reply-To: <m33aae5rn2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120854>

Hi,

On Sat, Jun 6, 2009 at 4:54 AM, Jakub Narebski<jnareb@gmail.com> wrote:
> What is the subject of this patch:
> =A0"http-push.c::remote_exists(): use the new http API"
> or
> =A0"Use the new http API in update_remote_info_refs()"?

See my reply to patch #19.

--=20
Cheers,
Ray Chuan
