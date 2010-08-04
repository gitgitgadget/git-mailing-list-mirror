From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Inspecting a corrupt git object
Date: Wed, 4 Aug 2010 15:09:57 +0200
Message-ID: <20100804130957.GB1537@jpl.local>
References: <20100804092530.GA30070@jpl.local> <i3bd0r$g2l$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alejandro Riveira =?iso-8859-1?Q?Fern=E1ndez?= 
	<ariveira@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 15:10:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgdjT-0006Q8-49
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 15:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751Ab0HDNKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 09:10:00 -0400
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:46297 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476Ab0HDNJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 09:09:59 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 98D1EEA5CE
	for <git@vger.kernel.org>; Wed,  4 Aug 2010 15:09:58 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At01AEoDWUxT46eEPGdsb2JhbACHZ5g5DAEBAQE1LcNShTsE
X-IronPort-AV: E=Sophos;i="4.55,315,1278280800"; 
   d="scan'208";a="556943167"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb3.telenor.se with ESMTP; 04 Aug 2010 15:09:58 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 13284422BF; Wed,  4 Aug 2010 15:09:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <i3bd0r$g2l$1@dough.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152580>

On Wednesday, August 04, 2010 at 11:48 CEST,
     Alejandro Riveira Fern=E1ndez <ariveira@gmail.com> wrote:

> On Wed, 04 Aug 2010 11:25:30 +0200, Magnus B=E4ck wrote:
>
> > From what I gather from the community book and Pro Git, a git objec=
t
> > file is a deflated representation of the object type as a string,
> > the payload size, a null byte, and the payload. Is there a standard
> > tool for inflating the file back so that I can inspect what the
> > actual difference between these two are? Short of writing a tool
> > utilizing zlib, at least.
>
>  Maybe
>
>  git cat-file -p <sha1>
>
>  ?

Sorry, I should've been more clear here. I know about cat-file's
pretty-printing abilities, but I just wanted to inflate the loose
object data and see *exactly* where the differing byte ended up.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
