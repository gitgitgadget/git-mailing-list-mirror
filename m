From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Fri, 13 Jan 2006 10:34:20 +0100
Message-ID: <20060113093420.GA25242@diana.vm.bytemark.co.uk>
References: <1137144291.20073.104.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 13 10:34:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExLKP-0001oH-FH
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 10:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161512AbWAMJe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Jan 2006 04:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161513AbWAMJe0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 04:34:26 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:40457 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1161512AbWAMJeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 04:34:25 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ExLK8-0006nJ-00
	for <git@vger.kernel.org>; Fri, 13 Jan 2006 09:34:20 +0000
To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1137144291.20073.104.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14622>

On 2006-01-13 04:24:51 -0500, Pavel Roskin wrote:

> 1) "stg new --force" becomes "stg new" and "stg new" becomes "stg new
>    --empty", i.e. empty files can only be created with the "--empty"
>    switch.
> 2) "stg new --force" becomes "stg record" or something.
> 3) "stg new --force" becomes "stg new --record" or something.
> 4) "stg new" works both with and without modified files.

I agree with Pavel. I like option 4 the most, and 3 the least; since
creating a new patch from existing edits is more common (for me) than
creating an empty patch, it's awkward to make that command much
longer.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
