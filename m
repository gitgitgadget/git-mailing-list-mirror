From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] notes: Allow adding empty notes with -C
Date: Sun, 21 Sep 2014 11:46:23 +0200
Message-ID: <CALKQrgcP_G9G4+NACbSgjTG9kssgRJxbH-St0RKVVbHEHgA2tA@mail.gmail.com>
References: <CALKQrgd9BPUTrgZvFCj_fznRG6RmfiGzW68XF++yykMguypTig@mail.gmail.com>
	<1411268449-14636-1-git-send-email-johan@herland.net>
	<541E9203.9040702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>,
	"James H. Fisher" <jhf@trifork.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 21 11:46:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVdj4-0004E9-22
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 11:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbaIUJqe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2014 05:46:34 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:52157 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbaIUJqd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Sep 2014 05:46:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XVdix-000HZW-89
	for git@vger.kernel.org; Sun, 21 Sep 2014 11:46:31 +0200
Received: by mail-pa0-f44.google.com with SMTP id eu11so1781434pac.3
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 02:46:23 -0700 (PDT)
X-Received: by 10.66.124.202 with SMTP id mk10mr16491845pab.1.1411292783747;
 Sun, 21 Sep 2014 02:46:23 -0700 (PDT)
Received: by 10.70.10.5 with HTTP; Sun, 21 Sep 2014 02:46:23 -0700 (PDT)
In-Reply-To: <541E9203.9040702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257347>

On Sun, Sep 21, 2014 at 10:53 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2014-09-21 05.00, Johan Herland wrote:

[...]

>> +cat > expect << EOF
> Git style for shell scripts: Plase put no space between < or > or >> =
and the file name:
> cat >expect <<EOF

[...]

>> +     git log -1 > actual &&
> git log -1 >actual &&

Ok, will fix (although the rest of the file leans towards the
alternative style with space).


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
