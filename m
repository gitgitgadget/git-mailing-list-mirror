From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Wed, 11 Mar 2009 11:49:16 -0400
Message-ID: <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>
	 <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>
	 <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tom Holaday <tlholaday@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 16:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhQhj-0007gP-RK
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 16:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbZCKPtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 11:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbZCKPtT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 11:49:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:60935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZCKPtS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 11:49:18 -0400
Received: by rv-out-0506.google.com with SMTP id g37so59471rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QKN/ghoCoBUDYuTYOKH3rCeMjNahJ8AFgAPFHn1UHo4=;
        b=fMtzFH5AKWzFy81PNtw0dVZemY9lXFPiZ0po98j/7Do7OcD5fr04JpxdR5OZ7+IOzN
         3k18uZyXUNzPRFosb6VUKtynDU8lqRC+Vm0/l7rM1ckEQxBVDsvperwdmO8vdcuy01AR
         7BdEJydKLI5sJiq/yHC20uYIANxA1MEiudlBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SMtP/yr53/MVAgKRA6HAHA9OlqcVCeWWuQ+34137C8PR/BwuvdC2HIXbk2utqvjHAC
         wFAJz2cTBdaXCMusfroxxFZQ9zqH0QuTBa1DwLpl/aPwzkj0ZEBDUEx2WxA2xYFR9CgC
         eOZioHsYydAUyOhGFgK4OG9dnLxJsEyNqYGk4=
Received: by 10.141.197.21 with SMTP id z21mr4456632rvp.107.1236786556790; 
	Wed, 11 Mar 2009 08:49:16 -0700 (PDT)
In-Reply-To: <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112944>

On Wed, Mar 11, 2009 at 11:39 AM, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
> On Wed, Mar 11, 2009 at 11:12 AM, Jay Soffian <jaysoffian@gmail.com> =
wrote:
>> And your man pages still won't be perfect. Preformatted text will lo=
ok
>> like this:
>>
>> =C2=A0.ft C
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
>> =C2=A0.ft

I must be losing my mind. This is suddenly working, though I can't
track it down to any change in git. I just rebuilt my man pages and
this no longer is occurring, even though I still have a terminal
window open with the output of "git help help" _showing this problem_
and that's from man pages I built/installed just a few days ago. (And
I haven't upgraded MacPorts lately.)

Oh well.

j.
