From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 11:30:10 -0400
Message-ID: <45379A02.1010105@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>	<45357CC3.4040507@utoronto.ca>	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca>	<845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>	<46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>	<45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr> <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Christian MICHON <christian.michon@gmail.com>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 17:31:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaZql-0003d4-Hs
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 17:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946105AbWJSPaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946106AbWJSPaW
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 11:30:22 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:51691 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1946105AbWJSPaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 11:30:21 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GaZqY-0008FB-00; Thu, 19 Oct 2006 11:30:14 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Tim Webster <tdwebste@gmail.com>
In-Reply-To: <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29358>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tim Webster wrote:
> First I want to say every SCM I know of sucks when it comes to tracking
> configurations, simply because they don't record or restore file metadata,
> like perms, ownership, and acl.

Arch supports that kind of metadata.

I believe SVN supports recording arbitrary file properties, so it's just
a matter of applying those properties to the tree.

> Somethings I like the SCM tools to handle. Personally I would like the
> SCM tools to be platform independent. This would ensure that correct
> things happening on ext3 mounted on windows.
> I don't think execute bit belongs in the basic file inventory information.

Our choices have been predicated on producing the best SCM we can for
the purpose of developing software.  We find that the execute bit is
very useful for build scripts and other incidental scripts.

The other attributes didn't seem useful for software development, so
they're not part of the baseline.

> Collaborative document editing and white boarding are other requirements.
> odf and svg are xml file formats. I would like to see an efficient
> xml diff as part of the SCM core. Using mime types SCM tools can unzip
> files, bundles, and use mime type information to the SCM core xml
> diff, plain diff
> as required.

An XML diff/patch or merge will not handle ODF properly.  There's too
much extra semantic information.

> I think it is essential that the SCM core include
> previsions for multiple
> repo partners.

You mean multiple merge sources?

> It would be nice if the SCM tools included rss feeds for communicating zip
> patch bundles.

The bzr "webserve" plugin provides rss feeds.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFN5oB0F+nu1YWqI0RAjSoAJ9xrZtSrZpVVoz6qAf/sZnd/StsUACfenqX
6bemNgMSbhtL0JjIlvulrb4=
=bSpK
-----END PGP SIGNATURE-----
