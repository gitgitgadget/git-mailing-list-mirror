From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: What do you use to receive mailed patches? (was: What do you use to send git patches?)
Date: Fri, 5 Sep 2008 17:15:44 +0300
Message-ID: <e29894ca0809050715p6cc11525k7da204b43ae164ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org, "Tor Arvid Lund" <torarvid@gmail.com>,
	"Christian Jaeger" <christian@jaeger.mine.nu>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:17:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbc7I-0007uX-FN
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbYIEOPq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYIEOPq
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:15:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:58532 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbYIEOPp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 10:15:45 -0400
Received: by wa-out-1112.google.com with SMTP id j37so300591waf.23
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=S3Lc26gwJlrM5AxHB14GzkZRSsAmv4tLXc3J6gU587I=;
        b=whkct6+ypyRxtJCAqR2RjderTa1m1N1G33spftZWRIa2XeQtF+6n1r3Jyo+vxUdeen
         inCHikOuwMsnh2t6qOxQNSYB4iBN7Oaz0vQRFIbC3d5woc8emDTZPE7d6XHo6OV5YJHq
         Nz4rVxGNZZ2bi1O8chF2ovqZ/uwr/oQzfm2Eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=ufGc3znnkVPBN11wgCiqbyFdni4jZNm0igxlnzeuYAV5qDqUuFCVfe5OSO7lOb+RdC
         1z6Z8XUV/jj0sAZj3zOe0EdGP2J88gRJW/GNdeN17W2puEi2eF0uk/jWiHe5juQhgYYk
         KIaClr62fbSxMIjW5lvmLek1mM0+LWlZGxqMI=
Received: by 10.114.144.1 with SMTP id r1mr10077704wad.97.1220624145270;
        Fri, 05 Sep 2008 07:15:45 -0700 (PDT)
Received: by 10.114.102.7 with HTTP; Fri, 5 Sep 2008 07:15:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95015>

Hi!

Thanks Jakub for your answer.

On Fri, Sep 5, 2008 at 5:10 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> If somebody could explain how they handle the git send-mail patches
>> they recieve, I would be thankful. How do you create .mbox files? Wh=
at
>> is your workflow when you deal with mails?
>
> I almost always use git-format-patch to generate patches (some people
> use git-show or git-diff for proof-of-concept patches), and either us=
e
> git-send-email (I have sendmail configured to send mails via GMail,
> but my computer is single-user machine; you can try sendemail.smpt*
> options instead, if you have appropriate Perl modules installed), or
> use KMail: Message > Insert file, ensuring that in Options I have Wor=
d
> wrapping turned off.
>
> In some rare case I used 'stg mail' (also via properly configured
> sendmail).
>

My question was about handling the patches you receive. Sending
configuration is quite easy.

Thanks
--=20
Marc-Andr=E9 Lureau
