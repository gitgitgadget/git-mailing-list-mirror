From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: cpio command not found
Date: Thu, 1 Nov 2007 01:00:18 +1100
Message-ID: <ee77f5c20710310700jf5e4aa4waede0da924d38adc@mail.gmail.com>
References: <18216.31314.990545.518458@lisa.zopyra.com>
	 <20071031133039.GA29065@diana.vm.bytemark.co.uk>
	 <18216.35066.259686.376571@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 15:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InE7W-0004OZ-Ii
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 15:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbXJaOAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbXJaOAU
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 10:00:20 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:57389 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbXJaOAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 10:00:19 -0400
Received: by rv-out-0910.google.com with SMTP id k20so136162rvb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BLRWCdhBeUxQlYke4PDTLa005dRCD1VZgaurmUDgv3U=;
        b=uXJanKTneKPXp4pBjksJsU9xdkYuvOyamXvuPNIYiJVC4fzkr0HGM+eeYAYiS9rP1ySHXpCmwzU9ehB8ioe/QEtXwF7bkUMuHa+kXghT3UxhMrogfJ2K40XlyZOywb84L1w97giM4mrhf/h8FeZiRpdt1ZtlcqNalukXyVr17f4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f8iaulfj3TyjfAFCtr2aNbhI7GDVG1oZmGSzcazSpEuKGuuzgEHI3gpi5iwEdP9j4JYwCkakC2QcBMYiVb8tnDqM3vbdKv5Jn2/DqxjhhmK+Sq7NzlA5RS2NFmcxOteluTi4oWQMHn38/vnBZJQxhYtO85pPcpKIr0oERMnfDNU=
Received: by 10.141.179.5 with SMTP id g5mr3949234rvp.1193839218840;
        Wed, 31 Oct 2007 07:00:18 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Wed, 31 Oct 2007 07:00:18 -0700 (PDT)
In-Reply-To: <18216.35066.259686.376571@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62832>

On 11/1/07, Bill Lear <rael@zopyra.com> wrote:
> On Wednesday, October 31, 2007 at 14:30:39 (+0100) Karl Hasselstr=F6m=
 writes:
> >On 2007-10-31 06:51:30 -0600, Bill Lear wrote:
> >
> >> I don't remember this dependence from earlier versions of git. I
> >> have been running git 1.4.xx on this machine for a while...
> >
> >When you clone with -l, git uses cpio to hardlink to the original
> >repository. What has changed is that -l is now used by default when
> >cloning a repository that's accessed via the file system (as opposed
> >to over some network protocol).
> >
> >To work around this, specify the repository location with file://, a=
nd
> >git won't try to hardlink (and hence won't try to use cpio).
>
> Hmm, thanks for the workaround, but I don't altogether like leaving
> things like this.
>
> If the system does not have cpio, I think the build of git should
> complain and fail, or it should activate code that treats any
> repository accessed over the file system as it would file://.

Something like this could be done at run-time instead. You might
install cpio, but shouldn't require a rebuild of git just to use it.


Dave.
