From: Cory Sharp <cory.sharp@gmail.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 23:54:41 -0700
Message-ID: <bb9d69200905132354h6b64171g24351840fb1d0893@mail.gmail.com>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	 <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	 <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
	 <7veiusz45w.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132334m7a4e3a4akde3529abeab5a09@mail.gmail.com>
	 <7v4ovoxk0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UqB-0000VK-6k
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760777AbZENGym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 02:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753632AbZENGym
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:54:42 -0400
Received: from mail-qy0-f133.google.com ([209.85.221.133]:61948 "EHLO
	mail-qy0-f133.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbZENGyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 02:54:41 -0400
Received: by qyk39 with SMTP id 39so2105132qyk.33
        for <git@vger.kernel.org>; Wed, 13 May 2009 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mYqpmdJWLMtYZIKMbpMkO9Kl1uWqynwSxaBybmveeU4=;
        b=KAsU1r93JHuaEV8FBlWXDmJkHElkOg82WCspgXIkgU0wDNxAxQjrqLPFx3CJIVj9Lp
         YOxjOOKmsr6Ai0Q7qlwuXOy8M21FX24PRONykC1EsFCVhA0C/o5GYupdpB+kU58XyQja
         ymQbh+u5/aYaq0J0FsK6MLgmfH8oIm7U8z+iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e4gAzPzxIO/WEy9ZIdpwEqL4ghDnMAy90BTCg3RTG65ge8TGpyi8OSIW1f1cbc+b22
         JdvZLl4Bm3FA8GeNyHGZBHfl3P2rU4KAxeQqLVJ+4JGNjzP/iNJQLYYLDPmCTXHQvKZh
         IPT+lh1De4aj4fll33MswnzTqyUCAto7WkDuI=
Received: by 10.229.70.138 with SMTP id d10mr1461649qcj.22.1242284081932; Wed, 
	13 May 2009 23:54:41 -0700 (PDT)
In-Reply-To: <7v4ovoxk0n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119154>

On Wed, May 13, 2009 at 11:42 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Because "merge" is (no surprise) what tracks what (two or more) thing=
s
> were merged. =A0And with --squash you are choosing not to make a merg=
e. =A0I
> am not sure if there is any more thing to be explained...

Yeah I'm not quite getting it.  Thanks for trying to explain, though.
