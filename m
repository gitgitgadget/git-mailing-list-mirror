From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: Help on CGIT
Date: Tue, 29 Dec 2009 15:57:29 +0100
Message-ID: <8c5c35580912290657y70bbfda1rfe03e389e90f8977@mail.gmail.com>
References: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jorge Bastos <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPdVx-00047y-5M
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 15:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbZL2O5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2009 09:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZL2O5b
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 09:57:31 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:57634 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZL2O5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2009 09:57:30 -0500
Received: by ewy19 with SMTP id 19so2772279ewy.21
        for <git@vger.kernel.org>; Tue, 29 Dec 2009 06:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MoHceXoRci1uPPzqsTzx/YmsWoA3b8g9hbqUJJZ1gpw=;
        b=B7vIw5ECBaWMYC7yZwIa7tQE4d1NdCYbSmq4J7SRpRtTKO8HEGXwfFtOOKH0+wYE+e
         M8Yaj8syZ4Pk2GyMlZQgODIDyTapX6esYua/LTXjAXjeKlJiJ56ujcJdvx23xN6vo5dh
         vuSPx0BdMtOWWW6q6cI8TpvyZeEmbMe1t6Etc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LDaQOSqh5NBxnvCgijtuKKKpAib5T250VaSpD/7yX83gjOpF5ovjV8uLyU9kReqpMP
         E6wuEmBvaK5BwVxiURLJ+DnoTJxhp+mzt6kUvQloG6H7jZ7cKBMt5wOhu7PU1KWEDe7q
         n558am//fYlrTOQ2vF+fbnKmkEHS3QHPL3ADo=
Received: by 10.216.89.12 with SMTP id b12mr2758602wef.93.1262098649145; Tue, 
	29 Dec 2009 06:57:29 -0800 (PST)
In-Reply-To: <31576a6d119e2edd66bd8bcc3281e9ad@192.168.1.222>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135801>

On Tue, Dec 29, 2009 at 13:18, Jorge Bastos <mysql.jorge@decimal.pt> wr=
ote:
> I have CGIT working at 50%.
>
> The 1st page show's correctly, but when i click the project name, it
> becames unconfigured and wierd, and apache complains about this:
>
> [Tue Dec 29 12:12:25 2009] [error] [client 192.168.1.3] [cgit] Unable=
 to
> lock slot /var/cache/cgit/53200000.lock: No such file or directory (2=
)

=46irst, check if cgit works correctly with caching disabled (set
cache-size=3D0 in /etc/cgitrc).


> My apache configuration for CGIT is:
>
> =C2=A0AllowOverride None
> =C2=A0Options ExecCGI
> =C2=A0Order allow,deny
> =C2=A0Allow from all
>
> =C2=A0DirectoryIndex cgit.cgi
>
> =C2=A0AddHandler cgi-script cgi pl
>

What's the contents of /etc/cgitrc? Which cgit-version are you running?

--=20
larsh
