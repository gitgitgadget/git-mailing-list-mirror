From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v5a 1/6] fast-import: put option parsing code in seperate 
	functions
Date: Thu, 27 Aug 2009 12:37:48 -0700
Message-ID: <fabb9a1e0908271237n3bb89193t971adbf35247ed4@mail.gmail.com>
References: <1251398431-12461-1-git-send-email-srabbelier@gmail.com> 
	<1251398431-12461-2-git-send-email-srabbelier@gmail.com> <87y6p5xf5x.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Aug 27 21:38:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgknb-0001dL-DK
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 21:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbZH0TiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2009 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZH0TiI
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 15:38:08 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37280 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbZH0TiI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2009 15:38:08 -0400
Received: by ewy2 with SMTP id 2so1535252ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gcRBHom4SpBzH5jzrAP3+n5Y9wbYyUvJFiHCAmv4t7A=;
        b=wVDRB3xwZSISPLon+m0BXzDwG08DTP8v1qTWmy14OvwHgvYAWYRXyQS5qeasEHAM9e
         +EzgQ3jeioYv00BaF8+ca8Qf00NVx8UD8dytb0XArQEOtAnNdSd+IFY6smnMO8NdkvfE
         z0BcPpUXNAISL2Z4maxIbA+8Zlmo4UJU/c2TQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KBaXvZfW2o2c16O+qjVDjyjxPsJXVSUJ1GjGGsPxCTIduRe9xpgOlCZQmljcGXHvts
         EHLChgCF0cq11pqqOueHHFuVSSXY4sh9jBWD01qCLMOr8z8xmdU0jw2oE2CiCBeyh9QP
         WlhKskENf7O1YWnmxWOEe1NcBIAxak6p1AwoI=
Received: by 10.216.10.74 with SMTP id 52mr27146weu.226.1251401888125; Thu, 27 
	Aug 2009 12:38:08 -0700 (PDT)
In-Reply-To: <87y6p5xf5x.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127200>

Heya,

On Thu, Aug 27, 2009 at 11:52, Teemu Likonen<tlikonen@iki.fi> wrote:
> =A0 =A0fast-import: put option parsing code in seperate functions

Thanks, fixed.

--=20
Cheers,

Sverre Rabbelier
