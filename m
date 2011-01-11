From: Johan Herland <johan@herland.net>
Subject: Re: git notes and core.editor config
Date: Tue, 11 Jan 2011 13:36:19 +0100
Message-ID: <201101111336.19466.johan@herland.net>
References: <AANLkTi=0BrBV+DLF_QfDi0mMVdz5tCLFsDMBKvw52nzz@mail.gmail.com> <201101111131.17429.johan@herland.net> <AANLkTik-=s-F8dmBRLU8o9LcSztb1P0WnkN5HK_n_No4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:36:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcdSd-0007hp-B3
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab1AKMgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 07:36:23 -0500
Received: from smtp.opera.com ([213.236.208.81]:58249 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1AKMgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:36:21 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p0BCaJqo012494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jan 2011 12:36:19 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTik-=s-F8dmBRLU8o9LcSztb1P0WnkN5HK_n_No4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164934>

On Tuesday 11 January 2011, Jeenu V wrote:
> On Tue, Jan 11, 2011 at 4:01 PM, Johan Herland <johan@herland.net>=20
wrote:
> > On Tuesday 11 January 2011, Jeenu V wrote:
> >> My core.editor value in $HOME/.gitconfig is set to
> >>
> >> =A0 [core]
> >> =A0 =A0 =A0 editor =3D vi "+set tw=3D72 spell"
> >>
> >> so that I've text width of 72 with spell check turned on. I
> >> haven't found problems with any git commands that invoke editor,
> >> but notes. 'git notes' seems to invoke the vi for me with 3
> >> separate arguments instead of just one: "+set, tw=3D72, and spell"=
=2E
> >> In other words, I don't think it honors shell quoting for editor
> >> config variable.
> >>
> >> Could this be a bug?
> >
> > What Git version are you running?
>
> $ git --version
> git version 1.7.0.4

Ah, there's your problem. In v1.7.1 "git notes" was builtin-ified (it=20
used to be a shell script, but was reimplemented in C), so you're still=
=20
running the shell script version of "git notes". I believe upgrading=20
will solve your problem (as well as making "git notes" more=20
featureful).


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
