From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCHv2] git-web--browse: Add support for google chrome
Date: Wed, 19 May 2010 09:32:59 -0400
Message-ID: <AANLkTikxis7BU-OGi76MzjN_JuOwmGNhDXYmZ1_bgMTl@mail.gmail.com>
References: <1274262692-3783-1-git-send-email-pavan.sss1991@gmail.com>
	 <1274262692-3783-2-git-send-email-pavan.sss1991@gmail.com>
	 <1274265104.2121.7.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	jnareb@gmail.com, chriscool@tuxfamily.org, pasky@ucw.cz
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 15:33:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEjOV-0007MR-Ta
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 15:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab0ESNdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 09:33:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53209 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0ESNdA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 09:33:00 -0400
Received: by iwn6 with SMTP id 6so2949555iwn.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 06:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=8qEO/c8QQJZFSPcFHOLFA6NAEK4kjryN7jmJcMNVvPk=;
        b=G1ZROYULv2uCq0DjHilkVzN1EBMt8NxV5vmZU8/iam8m2j1sat11fWE5WtMGW+hWLn
         6hrBbCcNR/F6hSgoo+MuRAb7eFI9NOacRMlLLv1IBHdCUAUQEgkoS1YbUT0Z+Xu9zvpN
         WI42J9A65R0ys5SHnuC/EsOVEvBRyfdCQ3dW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hAFkT7tQ3P/6nM715OIKLPDoldD0xDG0zE7UoCuPBr4cxP3njPJ2sW/O+EwXfoZwJS
         y9fhOYUysDASeVvBFzkh3dYT67dv9UqFFVzz/A+O9DUduNFX/YSnefVpXN2JENGTIAWB
         Kzkm4cBLPt75Qb6B69iOba98f7rPI0zU4pOcM=
Received: by 10.231.183.19 with SMTP id ce19mr550271ibb.35.1274275979386; Wed, 
	19 May 2010 06:32:59 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Wed, 19 May 2010 06:32:59 -0700 (PDT)
In-Reply-To: <1274265104.2121.7.camel@wpalmer.simply-domain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147327>

On Wed, May 19, 2010 at 6:31 AM, Will Palmer <wmpalmer@gmail.com> wrote:
> perhaps this has already been discussed, but aren't "chrome" and
> "chromium" two different browsers? (based on the same code, sure, but
> different releases which are often installed separately, all the same)

Correct. The chromium browser is 100% open-source. You can compile it
yourself or download a continuous build of it from the chromium trunk
(the Chromium project uses subversion for
chromium/chrome/chrome-frame, though interestingly uses git for
ChromiumOS). This is generally a developer release.

Google Chrome is a Google-branded version of the chromium browser. It
includes some non-opensource or restricted components (such as H.264
playback, Flash, Google design assets, etc), so you can't compile it
yourself. Rather you can only download binaries of various vintages
(dev, beta, stable). This is generally the consumer release.

j.
