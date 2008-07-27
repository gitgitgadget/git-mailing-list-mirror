From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 15:07:24 -0400
Message-ID: <9e4733910807271207o2e18cef1h869c659bd0ae31ba@mail.gmail.com>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
	 <alpine.DEB.1.00.0807272000270.5526@eeepc-johanness>
	 <9e4733910807271116q29323664l8d44fdded1de8c8e@mail.gmail.com>
	 <20080727183309.GD32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 27 21:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNBbY-0000up-FB
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 21:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757994AbYG0TH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jul 2008 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757925AbYG0TH0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 15:07:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:21982 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757742AbYG0THZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 15:07:25 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3398446wri.5
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=e0vEgknSlAH4V5UW+NT0sS3iNqkHGlFXOI620V4TunA=;
        b=kMb/w9L5pwmWbxG1npRiNafDHuvuSi7lUmUfYFsCVacHk4nd30tRehll1UBiPVIJpa
         fAa/ZgSHccJYrKYt30ukN6GPELd8kTBOf2CYMBjJCsVssWW8myZPjnwruhj2IZ0fBlB6
         QZGKaMk3zcp53flfAqRueW5bfDNPpgkWXEC64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fz0/WhcUx6AO0aI2BUrAm/IBgBs4wQpRO9uxbIc911aKjVyaerRi31XMo7Yr69zoo6
         oHPGUzmrzeqXmrZTKIXKybBpYcL45Q2TgTXBYf3+ij+Ef5Nc7JFDFgBunSHvoVzx99Xr
         80imoRHeOelCsUUoEPoDcJRzfA3yLP/Sdo0fo=
Received: by 10.90.29.17 with SMTP id c17mr3200708agc.25.1217185644814;
        Sun, 27 Jul 2008 12:07:24 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Sun, 27 Jul 2008 12:07:24 -0700 (PDT)
In-Reply-To: <20080727183309.GD32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90357>

On 7/27/08, Petr Baudis <pasky@suse.cz> wrote:
> On Sun, Jul 27, 2008 at 02:16:30PM -0400, Jon Smirl wrote:
>  > On 7/27/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote=
:
>
> > > Something like .mailmap?
>  > >
>  > >  And to show the mapped author name instead of the committed one=
, you would
>  > >  use "--pretty=3Dformat:%aN"?  (Needs 1.6.0-rc0 at least, IIRC)
>  >
>  > So we can already do this? Where is a .mailmap for the kernel tree=
?
>
>
>         http://repo.or.cz/w/linux-2.6.git?a=3Dblob;f=3D.mailmap
>
>  ...right there. :-)

I updated to 1.6.0-rc0 and this is working. mailmap needs some
cleanup. Errors are still in the list, but this is a lot better than
it was. That made about 800 'contributors' disappear.

Is there a way to do short log and have it map the names? What about
replacing the emails with their current email address?

Random missing entries....
Greg KH
Greg Kroah-Hartman

Hans J Koch
Hans J. Koch

Jean-Christophe Dubois
Jean-Christophe DUBOIS

Miguel Boton
Miguel Bot=F3n

--=20
Jon Smirl
jonsmirl@gmail.com
