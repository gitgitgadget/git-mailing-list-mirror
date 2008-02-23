From: Mike Hommey <mh@glandium.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 15:08:20 +0100
Organization: glandium.org
Message-ID: <20080223140820.GA4303@glandium.org>
References: <200802221837.37680.chase.venters@clientec.com> <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr> <20080223014445.GK27894@ZenIV.linux.org.uk> <7vfxvk4f07.fsf@gitster.siamese.dyndns.org> <20080223020913.GL27894@ZenIV.linux.org.uk> <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com> <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 15:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSv1v-0004X6-Mz
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 15:07:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758914AbYBWOF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 09:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758883AbYBWOF4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 09:05:56 -0500
Received: from vuizook.err.no ([85.19.215.103]:56483 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758896AbYBWOFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 09:05:54 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JSv0a-0006oa-Pg; Sat, 23 Feb 2008 15:05:51 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JSv36-00018W-AQ; Sat, 23 Feb 2008 15:08:20 +0100
Content-Disposition: inline
In-Reply-To: <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74826>

On Sat, Feb 23, 2008 at 03:47:07AM +0100, J.C. Pizarro wrote:
> On 2008/2/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>  > On Fri, Feb 22, 2008 at 05:51:04PM -0800, Junio C Hamano wrote:
>  >  > Al Viro <viro@ZenIV.linux.org.uk> writes:
>  >  >
>  >  > > On Sat, Feb 23, 2008 at 02:37:00AM +0100, Jan Engelhardt wrote:
>  >  > >
>  >  > >> >do you tend to clone the entire repository repeatedly into a series
>  >  > >> >of separate working directories
>  >  > >>
>  >  > >> Too time consuming on consumer drives with projects the size of Linux.
>  >  > >
>  >  > > git clone -l -s
>  >  > >
>  >  > > is not particulary slow...
>  >  >
>  >  > How big is a checkout of a single revision of kernel these days,
>  >  > compared to a well-packed history since v2.6.12-rc2?
>  >  >
>  >  > The cost of writing out the work tree files isn't ignorable and
>  >  > probably more than writing out the repository data (which -s
>  >  > saves for you).
>  >
>  >
>  > Depends...  I'm using ext2 for that and noatime everywhere, so that might
>  >  change the picture, but IME it's fast enough...  As for the size, it gets
>  >  to ~320Mb on disk, which is comparable to the pack size (~240-odd Mb).
> 
> 
> Yesterday, i had git cloned git://foo.com/bar.git   ( 777 MiB )
>  Today, i've git cloned git://foo.com/bar.git   ( 779 MiB )

Why do you need to clone it again ? Just git fetch from it.

Mike
