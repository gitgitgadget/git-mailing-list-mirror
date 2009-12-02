From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart transports.
Date: Wed, 2 Dec 2009 19:50:54 +0100
Message-ID: <fabb9a1e0912021050r4fd96ed4rf863917a965a42fb@mail.gmail.com>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> 
	<20091201171908.GA15436@Knoppix> <20091201193009.GM21299@spearce.org> 
	<7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix> 
	<7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix> 
	<alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de> <fabb9a1e0912021006x2905578bo16dbcaedc0d97bc6@mail.gmail.com> 
	<7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuIL-0002qN-M3
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbZLBSvJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 13:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755152AbZLBSvI
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:51:08 -0500
Received: from mail-vw0-f197.google.com ([209.85.212.197]:56685 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbZLBSvI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 13:51:08 -0500
Received: by vws35 with SMTP id 35so206762vws.4
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=GZU1NO0GIfn9uNoqGDGV0xKiQja6Ckl+QhCB4Njobr0=;
        b=h+EaaU+w6veeGMd7Q9qvmF1UvrbKNjNdphsAv8qdtLEJyoYUAYn2QD/jtLFPqD2oHG
         +Ob1mKOwwppcVeDnb51XXmfBjqzrUqFIkO50l1IXskp2d70ijKBZAz0uIRRNk0YpCPYJ
         Ckd3rqHCX3IKHJf63LdILzqEbVPbJOLMmXfZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XXb+Kwl8gHfq1ssj1Afq1t6vsp7wWP+2sg+vGkLN90GYm0f3ViUrgbhqxAjwecExey
         0SgD4/FB0a5dJrMXERRO+J6vvXZZJIZEx2scifUY1fLIXgo+AdT5atzr4GfDZvsQD4Yo
         4DPfW5jjyeQrQZaFDpKchXQcgEgpdm0I2TwNM=
Received: by 10.220.123.16 with SMTP id n16mr597986vcr.51.1259779874105; Wed, 
	02 Dec 2009 10:51:14 -0800 (PST)
In-Reply-To: <7vk4x5fcbf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134369>

Heya,

On Wed, Dec 2, 2009 at 19:41, Junio C Hamano <gitster@pobox.com> wrote:
> When the second implementation of http handler proves to be better th=
an
> the current one, we can flip the mapping, and anybody who were using
> "http://" to access some repository will automatically updated to use=
 the
> new backend instead of the old one. =A0With your scheme, you probably=
 could
> change the name of the old "http" backend to "http-deprecated" and th=
e new
> one from "second-class-citizen-http" to "http" to achieve a similar
> effect, but I do not think it is as nice as having one extra level of
> indirection.

I don't see how what you are talking about is any different. With the
mapping the executable of the alternative implementation still needs
to have a different name, no?

--=20
Cheers,

Sverre Rabbelier
