From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Mon, 10 Jan 2011 08:50:44 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101100846220.6883@xanadu.home>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
 <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
 <AANLkTinVYWit95O9Y0r5BKJiMGJRAOvgPqZ0s8Eez7KJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_CU4VxYkfOdcRnoaMVKSXgw)"
Cc: Zenaan Harkness <zen@freedbms.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 10 14:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcI94-0003M5-8T
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 14:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab1AJNup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 08:50:45 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19007 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab1AJNup (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 08:50:45 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LET00GTA7S00XC0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 10 Jan 2011 08:50:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTinVYWit95O9Y0r5BKJiMGJRAOvgPqZ0s8Eez7KJ@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164876>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_CU4VxYkfOdcRnoaMVKSXgw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Mon, 10 Jan 2011, Nguyen Thai Ngoc Duy wrote:

> On Fri, Jan 7, 2011 at 11:33 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Here's what I suggest:
> >
> >        cd my_project
> >        BUNDLENAME=my_project_$(date "+%s").gitbundle
> >        git bundle create $BUNDLENAME --all
> >        maketorrent-console your_favorite_tracker $BUNDLENAME
> >
> > Then start seeding that bundle, and upload $BUNDLENAME.torrent as
> > bundle.torrent inside my_project.git on your server.
> 
> I was about to ask if we could put more "trailer" sha-1 checksums to
> the bundle, so we can verify which part is corrupt without
> redownloading the whole thing (this is over http/ftp.. not torrent).

Aren't HTTP and FTP based on TCP which is meant to be a reliable 
transport protocol already?  In this case, isn't the final SHA1 embedded 
in the bundle/pack sufficient enough?  Normally, your HTTP/FTP client 
should get you all data or partial data, but not wrong data.


Nicolas

--Boundary_(ID_CU4VxYkfOdcRnoaMVKSXgw)--
