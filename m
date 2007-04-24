From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Bug?: import-tars misbehaves on Subversion tarballs
Date: Tue, 24 Apr 2007 12:09:24 +0200
Message-ID: <20070424100924.GB23811@diana.vm.bytemark.co.uk>
References: <20070424073907.GA22121@diana.vm.bytemark.co.uk> <20070424084037.GA8906@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 12:09:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgHxy-0002NN-TU
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 12:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161534AbXDXKJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 06:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161532AbXDXKJk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 06:09:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1484 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161534AbXDXKJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 06:09:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HgHxc-0006dL-00; Tue, 24 Apr 2007 11:09:24 +0100
Content-Disposition: inline
In-Reply-To: <20070424084037.GA8906@informatik.uni-freiburg.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45438>

On 2007-04-24 10:40:37 +0200, Uwe Kleine-K=F6nig wrote:

> I don't know much, but there are two locations that make up the name
> (i.e. prefix + name). Can you try the following patch:

No, it still breaks, but in a new and interesting way: Now I _only_
get the files with long pathnames!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
