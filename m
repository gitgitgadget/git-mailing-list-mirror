From: =?iso-8859-1?Q?Zo=EB_Blade?= <zoe@bytenoise.co.uk>
Subject: Re: [PATCH] userdiff: add support for Fountain documents
Date: Fri, 17 Jul 2015 15:03:37 +0100
Message-ID: <9078E9B2-7EB5-4FC9-BE1B-93D67B4D7D2A@bytenoise.co.uk>
References: <1437134351-15392-1-git-send-email-zoe@bytenoise.co.uk> <e2ddebd5451a9331e03b24c719f68530@www.dscho.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 16:03:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG6Et-0001k4-3j
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 16:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbbGQODm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 10:03:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56629 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbGQODm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jul 2015 10:03:42 -0400
Received: from [192.168.0.26] ([82.69.105.163]) by mrelayeu.kundenserver.de
 (mreue001) with ESMTPSA (Nemesis) id 0M0p8p-1YxsKS2V5j-00v40m; Fri, 17 Jul
 2015 16:03:39 +0200
In-Reply-To: <e2ddebd5451a9331e03b24c719f68530@www.dscho.org>
X-Mailer: Apple Mail (2.1878.6)
X-Provags-ID: V03:K0:nVhxvscQdKrMVJtDKL98bq03cqbZjHFtT9iOENWyKmOGXvIJtFG
 nMAzVnqzOlg718sZgGiZaq7akcz2Ih3xQ/amTE6vnOq155QPj+pY9taqUVhl9ILGxdoREaX
 qJIyfGqT4msHTTtNOH+V2uo7hGaFXPNwscQt9w0PlKAW5Rmf0U1pMQ6kBSDdpK/NPaF58Gb
 ZAbDdeZ0y0MUGestBUgiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9PDwElkbz9k=:tfbeIVIjOrxEByAr3lpdAd
 PhoIqnQ0rlzaCZcEht4SImhq2Ze+Wl8pKA+Ac3jbTw8JPi0Cz1gssa8bJUFzXA+YIqJEKybMs
 uCysKDrSQ8gx5oDxk3TjlUW2OyI28UUBHhmJ8wE3U+bCjv/RML6qvV3JE0XfXOSJgJZGQT4KW
 DfZYZyrjdRPzTS3wpsuutLINCjJwmp/4btHNgeb9dYJv17uxuyBPhZfdoy7wRWvmF1WOLfNgy
 1+AyIj6hfVhUYzyQ/RbJNXzpduDn5UsMdDBAX7TKOCcxCiqYoXQpO49bpirfuBxAiKc9fKrIh
 tdhcsuk0HL6zhK2sKMt7hf7Ls42qcyYGPK10SCbt0kdfF+bECJCxKIHs6WRM/Fi+T0EDlGWLn
 eFZgHEynix5u+aHpiwhUGFeDL7EFP9uBkGINBfkGQcNxfqali8r9i8uWhnMxwD/3RKSqStBXF
 +84JPDHbSvKbSbg3dTMeZuWTLQNSpfGESn0O9wMzOC7rR9giC57WNH0HfRFtRVjg++80k5QtF
 8dY+kIG7ejbb2aY9MYorR7KbuoIYb+SoaR5Z1BYAh1S6CYMQpGyMl3fZJVwBUYlSQvrd9w+3/
 1ujCOZCUYJbVmrUW1KDumXkawsq2Dk04uU6JD88gKBQndKv/iBG1BVPjoG31kXynZsWVBXR0o
 T8eoZ5604OOup10WYwICeYh52bolPJPijNpaBK5nnIe+m1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274072>

On 17 Jul 2015, at 14:03, Johannes Schindelin <johannes.schindelin@gmx.=
de> wrote:

> Maybe you want to add a paragraph explaining a bit more about Fountai=
n, or at least link to http://fountain.io/?
>=20
> In any case, you will need to sign off on your patch:
>=20
>    https://github.com/git/git/blob/v2.4.6/Documentation/SubmittingPat=
ches#L234-L286

Thanks, I'll amend it accordingly.  I originally mentioned the Fountain=
 site in my rough draft of the commit message, but then removed it agai=
n after reading more of the patch submitting documentation and not spot=
ting the nuance about when is and isn't a good time to include URLs.  N=
o bother, I managed the commit message in another repo... :D  I'll brin=
g it back and tidy it up a bit, then sign it off.

Thanks,
Zo=EB.