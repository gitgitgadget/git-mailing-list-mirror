From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/4] git-gui: clear the goto line input when hiding
Date: Sun, 16 Oct 2011 12:29:57 +0200
Message-ID: <CAKPyHN2RK89nnZS5rv6Q=3_UXZFCovqPVCbn6zDDE+SN_=ZxAQ@mail.gmail.com>
References: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
	<a59d40509d4f80a6dae99bae5ef6311bb607bd34.1318513492.git.bert.wesarg@googlemail.com>
	<87bothkibf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Fries <David@fries.net>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 16 12:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFNyu-000644-ID
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 12:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336Ab1JPKaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 06:30:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61388 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1JPK37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 06:29:59 -0400
Received: by vcge1 with SMTP id e1so1421747vcg.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=j+MTI5M7jjl+vxG9Vl5VaTmN8gECl+3vYI4EDYbb50g=;
        b=TNvlGDeTF2QigZ38QW0PoegkbiOZVmvnJ9RLc6aOQVUAqAuLempyA90hzK/+uQUIdE
         yiT5NJfhYVJsKLpMlkapaq3mhVt8CCMH8ns4fmQ0B4Mm3NieVQTd86PEGqchtfVdWKsl
         vriIeeJQH2qBaQQ93IkKv3V32GZ7xm89UI2N8=
Received: by 10.52.69.9 with SMTP id a9mr16542788vdu.17.1318760997440; Sun, 16
 Oct 2011 03:29:57 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Sun, 16 Oct 2011 03:29:57 -0700 (PDT)
In-Reply-To: <87bothkibf.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183703>

Hi,

On Sun, Oct 16, 2011 at 00:20, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>---
>> lib/line.tcl | =C2=A0 =C2=A01 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>>diff --git a/lib/line.tcl b/lib/line.tcl
>>index 4913bdd..692485a 100644
>>--- a/lib/line.tcl
>>+++ b/lib/line.tcl
>>@@ -41,6 +41,7 @@ method show {} {
>>
>> method hide {} {
>> =C2=A0 =C2=A0 =C2=A0 if {[visible $this]} {
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$w.ent delete 0 end
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 focus $ctext
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 grid remove $w
>> =C2=A0 =C2=A0 =C2=A0 }
>
> You don't say why this one gets cleared but the search box is not
> cleared.

Because thats a different patch series. Which I already send to you.
Starting with "[PATCH 1/4] git-gui: handle config booleans without
value".

Bert

>
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
