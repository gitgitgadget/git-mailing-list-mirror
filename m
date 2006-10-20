From: "Tim Webster" <tdwebste@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:14:04 +0800
Message-ID: <72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <4536EC93.9050305@utoronto.ca>
	 <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>
	 <46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>
	 <45373E27.3050209@op5.se> <vpqwt6wsmb5.fsf@ecrins.imag.fr>
	 <72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>
	 <45379A02.1010105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Christian MICHON" <christian.michon@gmail.com>,
	"Andreas Ericsson" <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 05:14:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gakpu-0003Ld-Ch
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 05:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWJTDOJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 23:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWJTDOJ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 23:14:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:22219 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751598AbWJTDOG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 23:14:06 -0400
Received: by ug-out-1314.google.com with SMTP id o38so653241ugd
        for <git@vger.kernel.org>; Thu, 19 Oct 2006 20:14:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AZ3/gvhM7Ri/dYNpSX+ac6ZCPJhO28TvDPmaA/iQV4P9phI/h6pom8XDoie5Oy93nPyIfrny8vpi7PGnOiwKsHuT4wwTN9xDgHnQiHhGtCKD7Rj28iS6yGKCXp74AuemXoDKc+5bmjKYE/fbNcD2popYFfjYVoq9frj6joAgklw=
Received: by 10.66.221.6 with SMTP id t6mr1161930ugg;
        Thu, 19 Oct 2006 20:14:05 -0700 (PDT)
Received: by 10.67.100.9 with HTTP; Thu, 19 Oct 2006 20:14:04 -0700 (PDT)
To: "Aaron Bentley" <aaron.bentley@utoronto.ca>
In-Reply-To: <45379A02.1010105@utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29405>

On 10/19/06, Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Tim Webster wrote:
> > First I want to say every SCM I know of sucks when it comes to tracking
> > configurations, simply because they don't record or restore file metadata,
> > like perms, ownership, and acl.
>
> Arch supports that kind of metadata.
>
> I believe SVN supports recording arbitrary file properties, so it's just
> a matter of applying those properties to the tree.

yes svn has arbitrary properties which can be manipulated.
They are not really intended for permissions, ownership, and acl.
To use the svn properties for this requires adding scm tools.
Also svn does not allow files in the same directory to live in
multiple repos

>
> > Somethings I like the SCM tools to handle. Personally I would like the

> > Collaborative document editing and white boarding are other requirements.
> > odf and svg are xml file formats. I would like to see an efficient
> > xml diff as part of the SCM core. Using mime types SCM tools can unzip
> > files, bundles, and use mime type information to the SCM core xml
> > diff, plain diff
> > as required.
>
> An XML diff/patch or merge will not handle ODF properly.  There's too
> much extra semantic information.

I have only experiment with xml diffs on odf files.
From my experience xml diffs work fine on svg files.
For more information, please refer to
http://www.unibw.de/inf2/OO_VCS/oo_rcs_api.html


> > I think it is essential that the SCM core include
> > previsions for multiple
> > repo partners.
>
> You mean multiple merge sources?

yes, Multiple merge sources is handy for collaborative document editing
