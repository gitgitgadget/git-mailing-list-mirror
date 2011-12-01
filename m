From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 0/4] git-p4: small fixes to branches and labels; tests
Date: Wed, 30 Nov 2011 23:02:59 -0500
Message-ID: <20111201040259.GA22189@arf.padd.com>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
 <loom.20111130T155409-599@post.gmane.org>
 <4ED6809A.9020703@diamand.org>
 <20111130225813.GA11544@arf.padd.com>
 <CAOpHH-U3PF0v7EPqnO0FNxNKh+uF1GH=cnA_MA09SaQTxo0cDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 05:03:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVxrb-0008A5-C4
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 05:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab1LAEDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Nov 2011 23:03:05 -0500
Received: from honk.padd.com ([74.3.171.149]:42126 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799Ab1LAEDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 23:03:04 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id A00E8278;
	Wed, 30 Nov 2011 20:03:03 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6D5783196F; Wed, 30 Nov 2011 23:02:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-U3PF0v7EPqnO0FNxNKh+uF1GH=cnA_MA09SaQTxo0cDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186160>

vitor.hda@gmail.com wrote on Thu, 01 Dec 2011 00:33 +0000:
> On Wed, Nov 30, 2011 at 10:58 PM, Pete Wyckoff <pw@padd.com> wrote:
> > This is another fundamental disconnect between p4 and git.
> > Reading
> >
> > http://www.perforce.com/perforce/doc.current/manuals/p4guide/07_lab=
els.html
> >
> > it is clear that labels are supposed to be used exactly where
> > tags cannot: =A0to specify a collection of files as they existed
> > at _different_ points in the commit history.
>=20
> Check the "Use Tag Fixup Branches" section in fast-import manual, it
> might help on this. The basic concept is to create a special branch
> that puts all files in the same state the P4 label would put them and
> then tag it in git.
>=20
> Tried to use this for my branch stuff, but with no success.

Interesting, thanks.  One could certainly construct any arbitrary
tree to represent the tag.  But it would be a truly evil merge of
possibly many commits.

> > Thus I think supporting labels is kind of pointless. =A0But in the
> > restricted use case that perforce docs tell us not to do, namely
> > using labels to identify change numbers, git can reflect that
> > with tags.
>=20
> I still use labels as simple tags. Telling that we should use
> changelists instead of labels is the same as saying that we should us=
e
> IP addresses instead of host names. It works, but I doubt you will
> ever remember it unless you write it down somewhere.

I see your point.  P4 labels are the only way that they support
tagging, apparently.  I'm okay with leaving label support in
git-p4.  And it will be nice if Luke makes it behave a bit
better.  But doing heroics to emulate cross-commit tags feels
like a lot of work, and the wrong direction.

		-- Pete
