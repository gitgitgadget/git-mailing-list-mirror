From: Jakub Narebski <jnareb@gmail.com>
Subject: What do you use to send git patches? (was: [ANNOUNCE] Git User's Survey 2008)
Date: Fri, 05 Sep 2008 07:10:45 -0700 (PDT)
Message-ID: <m3d4jipttz.fsf_-_@localhost.localdomain>
References: <200808312329.17312.jnareb@gmail.com> <48BB9742.3000109@gmail.com>
	<200809011034.48342.jnareb@gmail.com>
	<48BE8109.9030701@jaeger.mine.nu>
	<1a6be5fa0809030546n28e2a1besdc4435e874f2f0f9@mail.gmail.com>
	<94a0d4530809030949v7c8c6ec4uc60bc873a40637d0@mail.gmail.com>
	<e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Felipe Contreras" <felipe.contreras@gmail.com>,
	git@vger.kernel.org, "Tor Arvid Lund" <torarvid@gmail.com>,
	"Christian Jaeger" <christian@jaeger.mine.nu>
To: =?iso-8859-15?q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 16:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbc2X-0005xR-3l
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 16:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbYIEOKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 10:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbYIEOKt
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 10:10:49 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:43309 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbYIEOKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 10:10:48 -0400
Received: by gv-out-0910.google.com with SMTP id e6so18327gvc.37
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=uztfIuydVmev/2HcJzTtKjwLZs8z6grXHXaWumMNPrw=;
        b=p1en7XHIItAwkxn6CnnjC4gYwjPT+fdh8ErF9a0RntviJlsWZ0//XpYb2TusnzAyP+
         NmzssJ6qP9Yyt0zfaMaOYSyJPiIKUip+vYGvClk0csIBdkN6lVUfuLNuZqh61ea53seX
         Tk8nEt0EQHUaXh5bppJ7g+A5O2vXKw4NFczCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=JFlmxGeLr1cn0C6iamxPCscyhRtPaEj35b8jhv5QNVtqNc75+TTRYeexl4WjuqXMpJ
         IbSorTkgQ4oIYJzH2V57qPbyIxqu8qBbwnb/Ilezny2sBh2koiS2tQE+mp3/4tkoX28q
         GC0EhyWwc5uHz1J8U3z+bjc2DkmgmWx06Ye5E=
Received: by 10.103.247.5 with SMTP id z5mr7985318mur.24.1220623846292;
        Fri, 05 Sep 2008 07:10:46 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.238.224])
        by mx.google.com with ESMTPS id j10sm447367mue.17.2008.09.05.07.10.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Sep 2008 07:10:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m85EAIq0026782;
	Fri, 5 Sep 2008 16:10:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m85EA0fZ026768;
	Fri, 5 Sep 2008 16:10:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <e29894ca0809050646g2f198890le2312d065696d1dd@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95013>

"Marc-Andr=E9 Lureau" <marcandre.lureau@gmail.com> writes:

> May I suggest to add a question next year: which email client do you
> use to handle git attachements (if you do) ?
>=20
> I cannot find yet a good workflow with either mutt, gmail or evolutio=
n
> over imap.
>=20
> If somebody could explain how they handle the git send-mail patches
> they recieve, I would be thankful. How do you create .mbox files? Wha=
t
> is your workflow when you deal with mails?

I almost always use git-format-patch to generate patches (some people
use git-show or git-diff for proof-of-concept patches), and either use
git-send-email (I have sendmail configured to send mails via GMail,
but my computer is single-user machine; you can try sendemail.smpt*
options instead, if you have appropriate Perl modules installed), or
use KMail: Message > Insert file, ensuring that in Options I have Word
wrapping turned off.

In some rare case I used 'stg mail' (also via properly configured
sendmail).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
