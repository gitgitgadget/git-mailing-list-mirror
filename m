From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Wed, 2 Feb 2011 09:31:17 +0100
Message-ID: <AANLkTikBH8Qs3izT86WW7qyJ2etwFFj9GPVJ2QeRCmag@mail.gmail.com>
References: <20110202022909.30644.qmail@science.horizon.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 09:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkY7t-0000PN-NI
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 09:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab1BBIbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 03:31:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64194 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab1BBIbj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 03:31:39 -0500
Received: by bwz15 with SMTP id 15so312623bwz.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=AT+X4tQLDsSoL1PfWfzJq676gdlFf5svpGLy0VEAV4I=;
        b=KFlB8u4BdZJXPdSB3nmt23Q4vtHiLYY5BftqWiI6bjUPFx0uIHE8XD/ZOZPavD9WYk
         Cnn8l41AoPkkXBLhXYdJJepxoXC1V4yQ2rSq1U1tFeOnavmppg/QWMvdCMp4msZlJlOn
         dy4cyNUa6+NIZwlBAcA2l/StQ8rwzQv5DVMx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=TguVySH5vf7+QFh1ZmQiA1ec71PMYSWtSmQ4qlnm/a0veGM/ynwP8qUctuJrtk4mno
         UVmaOf7rRD1fZ/EXEvlGttoCk6AAzfP270IiMx/x5QFjBy/RfIonwnSB0SSck8x9I1FB
         brVYd82P8tj7n3y0bcuAkNUkGrqcZrbX18XRo=
Received: by 10.204.113.148 with SMTP id a20mr2000118bkq.48.1296635497812;
 Wed, 02 Feb 2011 00:31:37 -0800 (PST)
Received: by 10.204.120.197 with HTTP; Wed, 2 Feb 2011 00:31:17 -0800 (PST)
In-Reply-To: <20110202022909.30644.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165898>

On Wed, Feb 2, 2011 at 3:29 AM, George Spelvin <linux@horizon.com> wrote:
> If there's a compelling reason to change, could someone please describe it?

I think the most compelling argument I can think of is that it makes
top-level entries like Documentation, RelNotes, COPYING, README and
INSTALL easier to spot when doing "ls". For some users (first-time
hackers etc) that's a pretty big plus, I'd think.
