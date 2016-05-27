From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v8 0/9] connect: various cleanups
Date: Sat, 28 May 2016 06:59:43 +0900
Message-ID: <20160527215943.GA21018@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
 <a6f4bf06-a52b-dcdf-9407-0c03b8b1dfe1@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 28 00:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6PnV-0002eP-UT
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 00:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbcE0V76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 May 2016 17:59:58 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:34446 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756306AbcE0V75 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 17:59:57 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b6PnD-0005j5-Ql; Sat, 28 May 2016 06:59:43 +0900
Content-Disposition: inline
In-Reply-To: <a6f4bf06-a52b-dcdf-9407-0c03b8b1dfe1@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295798>

On Fri, May 27, 2016 at 04:24:20PM +0200, Torsten B=F6gershausen wrote:
> On 27.05.16 04:27, Mike Hommey wrote:
> > Changes from v7:
> > - Fixed comments.
> >=20
> > Mike Hommey (9):
> >   connect: document why we sometimes call get_port after
> >     get_host_and_port
> >   connect: call get_host_and_port() earlier
> >   connect: re-derive a host:port string from the separate host and =
port
> >     variables
> >   connect: make parse_connect_url() return separated host and port
> >   connect: group CONNECT_DIAG_URL handling code
> >   connect: make parse_connect_url() return the user part of the url=
 as a
> >     separate value
> >   connect: change the --diag-url output to separate user and host
> >   connect: actively reject git:// urls with a user part
> >   connect: move ssh command line preparation to a separate function
> >=20
> >  connect.c             | 235 +++++++++++++++++++++++++++++---------=
------------
> >  t/t5500-fetch-pack.sh |  42 ++++++---
> >  2 files changed, 170 insertions(+), 107 deletions(-)
> >=20
> Is the whole series somewhere on a public repo ?

Is it now :)

> No major remarks so far, if possible, I would like
> to have a look at the resulting connect.c

https://github.com/glandium/git/blob/connect/connect.c

Mike
