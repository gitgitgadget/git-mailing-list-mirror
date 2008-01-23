From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 09:02:43 +0000
Message-ID: <57518fd10801230102n4f430219p2701c7561f184569@mail.gmail.com>
References: <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati!on.org>
	 <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.org>
	 <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
	 <20080122133427.GB17804@mit.edu> <20080123000841.GA22704@mit.edu>
	 <alpine.LFD.1.00.0801221625510.1741@woody.linux-foundation.org>
	 <20080123013325.GB1320@mit.edu> <20080123064139.GC16297@glandium.org>
	 <4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	 <20080123084345.GN14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Kevin Ballard" <kevin@sb.org>, "Mike Hommey" <mh@glandium.org>,
	"Theodore Tso" <tytso@mit.edu>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbWA-0000B6-21
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 10:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYAWJCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2008 04:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYAWJCq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 04:02:46 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:58403 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbYAWJCo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2008 04:02:44 -0500
Received: by py-out-1112.google.com with SMTP id u52so4055527pyb.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 01:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=SplK1uDbYYaO2j8YBuSjLqRZ6XkcvdyGxF2nR7Cu+uA=;
        b=gDKs5wTO0BuJtEK+2zqILgsfsV95vTHllSQA35exGDLVwt+asmqz3w75zQ34ftcD4RNR+4+u+OlWbPVLplC8n6FXSV+G23mvqeUauKBwpTOUJyOGwsfS3rj5/y8vblWodh6RGYpeUK67hCq5cCn3Lbjqqmk7h6eHbzQPd0odQmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=hR4VtMv9CW8j5dmsAhQ/NEDgeqJ8P2MFtquwCtNKZbOB/tLOewNCwepV17H7VFRmCBWLJ0b6GR5VDdxLw057EcprplnxmbLiqE1HVTNUZfP1j6X+RlonWAldgj56WxpyALQbaY7fC63ecSzFu/yJFfuyHhL8HwZqoIRiPLcttfI=
Received: by 10.140.164.1 with SMTP id m1mr6144059rve.266.1201078963048;
        Wed, 23 Jan 2008 01:02:43 -0800 (PST)
Received: by 10.141.5.2 with HTTP; Wed, 23 Jan 2008 01:02:43 -0800 (PST)
In-Reply-To: <20080123084345.GN14871@dpotapov.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: f7075fa9c5c5161a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71524>

On Jan 23, 2008 8:43 AM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Wed, Jan 23, 2008 at 03:15:02AM -0500, Kevin Ballard wrote:
> >
> > Entirely possible, though renormalizing file contents seems a bit l=
ess
> > likely. I will point out that the text input system in OS X seems t=
o
> > default to producing NFC (at least, typing `echo 'M=E4rchen' | xxd`=
 in
> > the Terminal shows that the input string there is NFC).
>
> I wonder what happens if you do this:
>
> touch 'M=E4rchen'
> echo M*rchen | xxd -g1
>
> Will that produce NFC or NFD?
>

0000000: 4d 61 cc 88 72 63 68 65 6e 0a                    Ma..rchen.
