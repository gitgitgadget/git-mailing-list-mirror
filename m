From: Robert Navarro <crshman@gmail.com>
Subject: Re: jGit Eclipse Plugin Feature
Date: Sat, 7 Mar 2009 12:19:18 -0800
Message-ID: <efe536470903071219q6b8ed517xc35808fb710c2244@mail.gmail.com>
References: <efe536470903070205w1dbff989je6dd6126d09e4a74@mail.gmail.com>
	 <49B299B7.80009@gmail.com>
	 <200903071845.20855.robin.rosenberg.lists@dewire.com>
	 <49B2BF9A.9030405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 21:20:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg30r-0001SN-GH
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 21:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076AbZCGUTV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 15:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbZCGUTV
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 15:19:21 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:10041 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbZCGUTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Mar 2009 15:19:20 -0500
Received: by yw-out-2324.google.com with SMTP id 5so612713ywh.1
        for <git@vger.kernel.org>; Sat, 07 Mar 2009 12:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=evsIRcZ+ltOMzy7TPsds0ywflmUmu/WWArfZe9nguKI=;
        b=Zrd67cq3mfGw5nD3Ht6TxFfA9VLES0RnOBgnIFie1XCgA8gDpiPOU0dpQtLSyvfc7w
         EE7jNnxQ70hRmpD7QKv+HzSUoTbjdkSwXVVjhE3W+dlimLPDQd17E7ncCxkvIi8NMzjm
         NgpUYY7rQtaqHEtUqyAArASwYZkUmSJzC/DrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fc9CK/4lL+UuA5zktdm0YkxJh6+hGlJQ5vKwx0gckRryZ9boPnr/O/hHNA1AcCuH/y
         GIcA5ol5OUkUeIDc9pG2aWmzIN8gM++eS38RwCjk2/6WGwyjUuC2V5ogS30c+dYPixc0
         UlzAlhOMq9fP6l6wDT4QxAZS5cd1bZ+Kw27pk=
Received: by 10.150.154.5 with SMTP id b5mr1030069ybe.82.1236457158174; Sat, 
	07 Mar 2009 12:19:18 -0800 (PST)
In-Reply-To: <49B2BF9A.9030405@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112577>

Hey Guys,

While I haven't programmed java in years, nor have I ever done an
eclipse plugin.....I was looking at the mercurialeclipse plugin for
some inspiration, they do have a recently used drop down on their
push/pull wizards. I'm going to see if I can get up to speed on how
they do this and possibly implement something similar.

However, I do think that a remotes dialog would be very nice,
something that you can just choose from whenever you wanted to do a
push/pull operation.

Thanks for entertaining the idea =3DD

On Sat, Mar 7, 2009 at 10:40 AM, Tor Arne Vestb=F8 <torarnv@gmail.com> =
wrote:
>
> Robin Rosenberg wrote:
> > l=F6rdag 07 mars 2009 16:58:47 skrev Tor Arne Vestb=F8 <torarnv@gma=
il.com>:
> >> Robert Navarro wrote:
> >>> Hello,
> >>>
> >>> Sorry about my last "subscribe" email, skipped over this part in =
the
> >>> wiki...."You don't even need to be subscribed to post, just send =
an
> >>> email to: "
> >>>
> >>> Anyways.....I wasn't sure where to post this but I'll give it a s=
hot
> >>> here.....I know there is an eclipse jGit plugin in the works and =
I
> >>> wanted to know if it would be possible to get a remember or recen=
tly
> >>> used servers feature added to the push/pull feature.
> >> I have done some initial prototyping of a Remotes View. I'll see i=
f I
> >> can bring that to life somehow.
> >
> > I assumed the feature is about the push dialog. If we have a remote=
s
> > view it'd be nice to see it there too.
>
> Yepp. I imagine something like a list of remotes, which can be
> referenced at any point a remote is needed, like the push dialog.
> Wizards that need a remote, can display the list of the existing
> remotes, with a "create new" option, which would launch the page from
> the "create new remote" wizard (similar to the "Add new CVS Repositor=
y"
> stuff). Something along those lines.
>
> > Where should it remembered? In the workspace or .git/config?
>
> Good question. Will need some thinking :)
>
> Tor Arne



--
~Robert Navarro
