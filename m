From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Advice on choosing git
Date: Wed, 12 May 2010 11:15:30 +0200
Message-ID: <AANLkTimIfAZp0ywpwMyllp3QtmO2Js6H1HhkP4l47bGl@mail.gmail.com>
References: <4BEA4B46.6010009@smartmediacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>
To: Noah Silverman <noah@smartmediacorp.com>
X-From: git-owner@vger.kernel.org Wed May 12 11:21:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC885-0002Fc-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 11:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107Ab0ELJVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 May 2010 05:21:14 -0400
Received: from mail-qy0-f171.google.com ([209.85.221.171]:53877 "EHLO
	mail-qy0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0ELJVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 May 2010 05:21:12 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2010 05:21:12 EDT
Received: by qyk1 with SMTP id 1so9329476qyk.5
        for <git@vger.kernel.org>; Wed, 12 May 2010 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CPFHxEXqyBE+IcXPA+V8LKj0kPcmh7n0xpoIrXadEAs=;
        b=JjJRuokGviyyGoqnOJrfjrD7yZizxo56VxO0OIvIr4OCXCbC6eBE0vaQZ/hsuiD2hj
         NE3+uu6SP8aETv5ueSjIQ1RQZhtEp3qt8x1LgpiD2kwIi+6JpnlXsy4GeHRXM1Sr+JQH
         ofJPKmMIyq7sWpmNDqKllXfa/AsVJzPF8EudQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dgAOWmksXlFYB4JXih6tY5JDESLWnV0h3iEvIPo+td+QA6vqFYotasH+hfP6YwDxvM
         ortBvspUDOV99YngCRsdQ9dJks/bxWUwhnpe+i3WnsD/mtVswiQAl/ayOTyExisCeu3w
         DZqF3pmFGy/HbGO9n2qPsyuaKzeLBWCdxRoYY=
Received: by 10.229.230.5 with SMTP id jk5mr535636qcb.194.1273655750171; Wed, 
	12 May 2010 02:15:50 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Wed, 12 May 2010 02:15:30 -0700 (PDT)
In-Reply-To: <4BEA4B46.6010009@smartmediacorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146934>

Hi,

On Wed, May 12, 2010 at 8:31 AM, Noah Silverman <noah@smartmediacorp.co=
m> wrote:
> I'm looking for both a version control system and backup system.

I recommend git for versioning and bup [1] for backup.

> Bazaar also looks like a possible option, but I'm not sure it handles
> drive usage better. =C2=A0Their website has a lengthy manifesto about=
 how
> they're better than Git, but I don't have enough experience with eith=
er
> to make an informed decision.

Scott Chacon maintains this page [2] that compares Git with other
versioning systems. From my personal experience, I find Bazaar to be
quite horrible and slow. Mercurial is user-friendly, but nowhere near
Git in terms of speed, power, and size.

-- Ram

[1] http://github.com/apenwarr/bup
[2] http://whygitisbetterthanx.com/
