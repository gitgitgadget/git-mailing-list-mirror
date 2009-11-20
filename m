From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 06:08:02 +0300
Message-ID: <20091120030801.GE22556@dpotapov.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com> <20091120014843.GB22556@dpotapov.dyndns.org> <20091120023540.GA17796@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Dennie <gdennie@pospeople.com>,
	'Jason Sewall' <jasonsewall@gmail.com>,
	'Jakub Narebski' <jnareb@gmail.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 20 04:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBJrJ-0004tX-MC
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 04:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbZKTDIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Nov 2009 22:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753684AbZKTDIK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 22:08:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:25663 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbZKTDIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 22:08:09 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1124588fga.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 19:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wkXRcrezzeZzDG1uylAkxLyUjq5pgO8kFvHlScGUnKA=;
        b=mpVpeouRPg3qHVDZQiJPXpbUsazsMuTzVqYfLN1sliFiv0KGtD/SaNbZ3JqRhCVEFJ
         Khwrq6o3vDdzXaGkFMzsjdZCTuJpp0PeMFrnBnM+B02ebvXuteZb5G7N0jcnAcT6D79X
         X5cNTACsAm0sCVivo61KpSdYm5aKcUFuyqtGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iwdECsrlpeehc4nL7W4fSwh1J0K7dqwkcHARep90DgzQLlShnVnu6xf4qcWALJIeS+
         ZuxKAmVoxORTnUBGzVFIVYbjvVLim6kIiWqDQz+ueGE5bkP/VTUvT1VGl8LJ5GLD2m5V
         bWQxJXniPG2W2wo30xblUQZZWnS9Fot9/R3YY=
Received: by 10.103.37.27 with SMTP id p27mr398766muj.46.1258686493951;
        Thu, 19 Nov 2009 19:08:13 -0800 (PST)
Received: from localhost (ppp91-76-17-113.pppoe.mtu-net.ru [91.76.17.113])
        by mx.google.com with ESMTPS id n7sm4784393mue.54.2009.11.19.19.08.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 19:08:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091120023540.GA17796@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133300>

On Fri, Nov 20, 2009 at 03:35:40AM +0100, Bj=F6rn Steinbrink wrote:
> On 2009.11.20 04:48:44 +0300, Dmitry Potapov wrote:
> > On Wed, Nov 18, 2009 at 09:03:31PM -0500, George Dennie wrote:
> > >=20
> > > For example, the functional notion of the repository seems well
> > > defined: a growing web of immutable commits each created as eithe=
r an
> > > isolated commit or more typically an update and/or merger of one =
or
> > > more pre-existing commits.=20
> >=20
> > In Git, commits are not immutable.
>=20
> Commit _are_ immutable. Like all git objects (blob, tree, commits, ta=
g).
> "Rewriting" history actually means creating a new history (adding
> objects), and then changing a ref (most often a branch head) to
> reference the new instead of the old history.

I stand corrected. All objects in Git repository are actually immutable=
,
but because references can be changed (and tools like git-rebase change
it automatically), it _appears_ like editing existing commits, but in
fact old commits do not disappear immediately. Even if there is no othe=
r
branches or tags that refer to old commits, git-reflog stores reference=
s
to them for 30 days after that the garbage collector can remove them.


Dmitry
