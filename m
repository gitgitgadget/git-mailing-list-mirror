From: Siju George <sgeorge.ml@gmail.com>
Subject: Re: XML Parsing Error: junk after document element
Date: Fri, 12 Feb 2010 09:53:06 +0530
Message-ID: <b713df2c1002112023k757a54faq933b9a9bdacc7d1c@mail.gmail.com>
References: <b713df2c1002102347g70cc212et21d507d44bb5aead@mail.gmail.com>
	 <m3ocjw82ai.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 05:23:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfn3l-0002pi-Cw
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 05:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757790Ab0BLEXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 23:23:09 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:64414 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757784Ab0BLEXH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 23:23:07 -0500
Received: by ywh35 with SMTP id 35so1787641ywh.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 20:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TELfPBUBLkCmgK93GWZCJfE7ixf0ZCJjTBqc8iutgpM=;
        b=TLyyh5G5v+EEWIsxObkGj7PJ56KefTrir7EztgtZQ5dn4dbKx9eREICkfZutaKBv8n
         aRdSqVWz2U622EXq4zCRn7E+9DJxYZJ/ULBXBXDXP7YXVtmP8ZTvj6eD6ozfg+oCaYpn
         cPK0+oMUAhW7JAvEMVhFMEDzTF2m3qFwY1g0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XQPZ0pJKh7nDE3/PGwKje10BmyZphgijbobHc13fhcqb7kRur8L7xznyJ8FeSTcE1i
         0OLhdLBCyirJHBdbFkIEjwP+n+oQDrnQKbjxWaAFOJcD+iZCTZF/65uJq+Mi5g4+V79I
         7PXC+3kQh6ds+FjWRXQgE2QDvYfZvHbde8e1w=
Received: by 10.90.21.11 with SMTP id 11mr966292agu.97.1265948586638; Thu, 11 
	Feb 2010 20:23:06 -0800 (PST)
In-Reply-To: <m3ocjw82ai.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139657>

Thanks a lot Jakub for the response :-)

On Thu, Feb 11, 2010 at 4:31 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>
> Which version of gitweb?[1]
>

 gitweb-1.6.0.6  - all packages are from pkgsrc on DragonFly BSD
v2.5.1.672.gf81ef-DEVELOPMENT #17: Tue Feb

>=A0Which version of git?[2]
>

scmgit-1.6.6.1

>What web server?
>

 apache-2.2.14nb1

> Which version of CGI.pm is used by web server?[3]
>

$CGI::revision =3D '$Id: CGI.pm,v 1.263 2009/02/11 16:56:37 lstein Exp =
$';
$CGI::VERSION=3D'3.43';




> Try to view source, or use different web browser that doesn't do
> strict XML validation to find the source of this error.
>

I was using firefox 3.6-2.
Trying with Konqueror Version 4.3.4 (KDE 4.3.4) Using KDE 4.3.4 (KDE
4.3.4) I dont get the error but it does not list my projectts. I get
this message on the page.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

projects /


 404 - No projects found

OPMLTXT
OK
The requested URL /cgi-bin/gitweb.cgi was not found on this server.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

this page is shown when I take the URL

http://172.16.3.27/cgi-bin/gitweb.cgi

but I have the projectroot configure in gitweb.conf and there is a git
project in that location.

# cat /usr/pkg/etc/gitweb.conf | grep projectroot
our $projectroot =3D "/Backup1/Data/git-repositories";
# ls -l /Backup1/Data/git-repositories
total 0
drwxr-xr-x  1 root  wheel  0 Feb 11 10:40 systems-configuration
# ls -l /Backup1/Data/git-repositories/systems-configuration/.git/
total 0
-rwxr-x---  1 root  wheel  393 Feb 11 11:03 COMMIT_EDITMSG
-rwxr-x---  1 root  wheel   23 Feb 11 10:40 HEAD
-rwxr-x---  1 root  wheel   92 Feb 11 10:40 config
-rwxr-x---  1 root  wheel   73 Feb 11 10:40 description
drwxr-x---  1 root  wheel    0 Feb 11 10:40 hooks
-rwxr-x---  1 root  wheel  120 Feb 11 11:29 index
drwxr-x---  1 root  wheel    0 Feb 11 10:40 info
drwxr-x---  1 root  wheel    0 Feb 11 10:58 logs
drwxr-x---  1 root  wheel    0 Feb 11 11:03 objects
drwxr-x---  1 root  wheel    0 Feb 11 10:40 refs
#


> If everything else fals, you can always edit gitweb.cgi to comment ou=
t
> content-type negotiation, to always serve as text/html mimetype -
> which should torn off XML validation, as below:
>
> =A0 =A0 =A0 =A0my $content_type;
> =A0 =A0 =A0 =A0# require explicit support from the UA if we are to se=
nd the page as
> =A0 =A0 =A0 =A0# 'application/xhtml+xml', otherwise send it as plain =
old 'text/html'.
> =A0 =A0 =A0 =A0# we have to do this because MSIE sometimes globs '*/*=
', pretending to
> =A0 =A0 =A0 =A0# support xhtml+xml but choking when it gets what it a=
sked for.
> =A0 =A0 =A0 =A0# Disable content-type negotiation when caching (use m=
imetype good for all).
> =A0 =A0 =A0 =A0#if (defined $cgi->http('HTTP_ACCEPT') &&
> =A0 =A0 =A0 =A0# =A0 =A0$cgi->http('HTTP_ACCEPT') =3D~ m/(,|;|\s|^)ap=
plication\/xhtml\+xml(,|;|\s|$)/ &&
> =A0 =A0 =A0 =A0# =A0 =A0$cgi->Accept('application/xhtml+xml') !=3D 0)=
 {
> =A0 =A0 =A0 =A0# =A0 =A0 =A0 $content_type =3D 'application/xhtml+xml=
';
> =A0 =A0 =A0 =A0#} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$content_type =3D 'text/html';
> =A0 =A0 =A0 =A0#}
>
>

yes I tried it and the first error disappears from firefor and now I
get the same error from konqueror in firefox too

What could be the trouble?

Thanks

--Siju
