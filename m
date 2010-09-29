From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Tue, 28 Sep 2010 19:45:25 -0500
Message-ID: <AANLkTikXEfBdd6sDS9iJ0ULN-jihha+U4JZxRFG+SRFG@mail.gmail.com>
References: <20100928222332.GA28859@soprano.nvidia.com>
	<tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
	<20100928233832.GA20224@soprano.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Joe Kain <JKain@nvidia.com>
To: Aaron Plattner <aplattner@nvidia.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 02:45:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0knn-0006Me-GM
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab0I2Api convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 20:45:38 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:56935 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0I2Aph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 20:45:37 -0400
Received: by qyk36 with SMTP id 36so157424qyk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 17:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qC9ZaOwFZjtjynbL5qrQUXEtmNqor5iZJOmYMjjjAMI=;
        b=Us5w/BLzhysMoxX8I8BqwdLFVCdVUgP6NJcoq8Fm30qOncASfeAMv0eeIoGuGPV+PB
         x2kUCjMPKwrQCazHxgoQcrQSz+8liJGB3ypA0lZ8RnC8TMHIA4R92YnSa01URIPtDiNi
         2O8AIaKMcspzGKeVpdL0aqJiA2/EgasdgtjlE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fwCQ5DH9t4sga0YLQXlWrBsivf71CpPM7wmRQQrXp7CUa6IgiFNx5c6Q4Po2C04Ja4
         O3ycTggR5sJKBhe+BkaIFbyHYhFoTQ9xQc8equWhEpCqt1E0J78Sj7Gt+aRHrdFY+PK/
         H8WCQIFD3wabZI5q+09900c9X3XqTcy4wtfc0=
Received: by 10.224.19.129 with SMTP id a1mr548620qab.324.1285721125783; Tue,
 28 Sep 2010 17:45:25 -0700 (PDT)
Received: by 10.220.203.3 with HTTP; Tue, 28 Sep 2010 17:45:25 -0700 (PDT)
In-Reply-To: <20100928233832.GA20224@soprano.nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157517>

On Tue, Sep 28, 2010 at 6:38 PM, Aaron Plattner <aplattner@nvidia.com> =
wrote:
> On Tue, Sep 28, 2010 at 03:40:11PM -0700, Brandon Casey wrote:
>> On 09/28/2010 05:23 PM, Aaron Plattner wrote:
>> > Switching to a detached head prints something like
>> >
>> > =C2=A0 HEAD is now at 9d14017... dir.c: squelch false uninitialize=
d memory warning
>> >
>> > These dots get selected when you double-click on the abbreviated
>> > commit hash, which makes it annoying to copy and paste.
>>
>> This must be another gnome-terminal/konsole "innovation".
>>
>> xterm still does the "right thing"(tm) _and_ it doesn't eat my
>> alt keystrokes like alt-b to move the cursor back a word. /rant
>
> How is your xterm configured? =C2=A0On my stock Ubuntu 9.10 system, i=
t doesn't
> do the "right thing"... the dots are selected. =C2=A0Gvim gets it rig=
ht.

Nothing special, and nothing that would affect the double-click selecti=
on
functionality as far as I know.  Though I don't know what controls that=
=2E

   $ cat ~/.Xresources
   XTerm*geometry: 80x33
   XTerm*faceName: Liberation Mono
   XTerm*faceSize: 9
   XTerm*foreground: green
   XTerm*background: black

Centos5.X and Fedora11.

I hesitate to ask, since you /seem/ to understand that xterm,
gnome-terminal, and
konsole are three different programs, but I can also imagine there are
people who may
use the word "xterm" in a generic way to refer to all X11-based
terminal programs.
So, no offense, but  are you sure you're running the program called
"xterm"?  If the
answer is yes, then please ignore the rest of this paragraph.  If you
are just clicking
on the terminal icon to pop-up a terminal, then try typing "xterm"
into that terminal.
The xterm program may not even be installed by default on Ubuntu
anymore (I don't
know).  But I'm thinking it probably is, and that gvim may merely be
vim run inside
an xterm, and that's why the selection is working properly.

> Also, Alt-B appears to work fine in gnome-terminal. =C2=A0I don't hav=
e Konsole
> to try.

Ok, they recently got rid of the Tab(with an underlined 'b') menu
item. Try alt-f to go
forward by a word then.  That's still intercepted by gnome.

-Brandon
