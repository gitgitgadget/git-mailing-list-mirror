From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC PATCH v4 11/26] Move WebDAV HTTP push under remote-curl
Date: Fri, 30 Oct 2009 23:02:39 +0800
Message-ID: <be6fef0d0910300802t44801cb9n7a129905725f5c56@mail.gmail.com>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
	 <1256774448-7625-12-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Clemens Buchacher <drizzd@aon.at>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Mike Hommey <mh@glandium.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 16:02:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3t01-0004PP-RP
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 16:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbZJ3PCf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Oct 2009 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbZJ3PCf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 11:02:35 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:63159 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932210AbZJ3PCe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 11:02:34 -0400
Received: by iwn10 with SMTP id 10so2176927iwn.4
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n1Znci2pfHNKefOU4PeNmyGw7a9sSCBgDjPVgrOuOg4=;
        b=BAeC8XIR/uXUaB2mlUEUM/S1X6MhgOahhW4iQ/zGc/Sy5GWVw+52xbQNXasI6PIVxF
         VualtHLkD5DLQpFShrNQiRJYO4/GYV9kD/hblN5qPIgmneRzefVCCiMpDKOjuXIQaf71
         KnOZhrUsxpELnM4MxFRdneTrcy+GolEP9WfjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EIC+VSPP8EkM4Ama/XFf7V5KJ/ik24R2a9LOqAvNiAli/FWImVHIQ8KRK0enJzeYMw
         mG//qd1tLYyVWrU5UjPU09bMp7Zbse0cBbKCbweBRpl3C+/+Nx+9i6h+EA8/0IBnwJjf
         tK2g8Rcplp5zzcdUNpwd44odueTmS/9VWTw8s=
Received: by 10.231.10.16 with SMTP id n16mr374665ibn.24.1256914959503; Fri, 
	30 Oct 2009 08:02:39 -0700 (PDT)
In-Reply-To: <1256774448-7625-12-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131707>

Hi,

On Thu, Oct 29, 2009 at 8:00 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> =A0update http tests according to remote-curl capabilities

it would be great if you could mention the $ORIG_HEAD bit:

 o Use a variable ($ORIG_HEAD) instead of full SHA-1 name.

--=20
Cheers,
Ray Chuan
