From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 11:51:43 +0100
Message-ID: <fabb9a1e0903130351w592ee33dm499f10306d565aab@mail.gmail.com>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>
	 <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>
	 <49BA39A1.9090203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li57H-0002iT-2M
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbZCMK6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZCMK6V
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:58:21 -0400
Received: from mail-bw0-f175.google.com ([209.85.218.175]:43180 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbZCMK6U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 06:58:20 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Mar 2009 06:58:20 EDT
Received: by bwz23 with SMTP id 23so69755bwz.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HV5KTo5i0IZhblzuIvO+ZM9rbjtR7LJPSo+B2I4DclU=;
        b=hSB66L8/kSIX83kUzujiB0LakLFuse3Jii0laAOvW73INFQTcZ3Qr1acNIQFfzMWrg
         zvkjfg86litQxhvOPC02z+oHzir3TPoFREp7ndxKPVKA1P3AGOuTGbDKhAMCaK41nQaA
         nTmYskubDhoNPvEp7tNXZkWVcoUiahEEHzi8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cZSffi5LAxnjTLFZo2Yv+6+qV/u9wclth6iRrqvtPqK9V07lr1bfgd1Fbyokxxiy15
         4n677NoNaPCXmSYbaBcS9KPRvm45XlrSo91wiGudc3lj0pCxGRRSIwMv+16fG9yRdD/+
         p3Y5CsmDqj7hHZeDRxFekbPZPx2oCGbMdag8o=
Received: by 10.103.227.10 with SMTP id e10mr541902mur.30.1236941503590; Fri, 
	13 Mar 2009 03:51:43 -0700 (PDT)
In-Reply-To: <49BA39A1.9090203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113171>

Heya,

On Fri, Mar 13, 2009 at 11:46, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> And people asked me not to be cryptic... even though the OP explicitely
> asked for encryption, of course ;)

I wasn't being cryptic, I just don't remember the details of smudge,
just that it exists, and that it allows you to perform operations on a
file on checkout and on add.

-- 
Cheers,

Sverre Rabbelier
