From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/4] Provide a dirname() function when
 NO_LIBGEN_H=YesPlease
Date: Tue, 12 Jan 2016 08:57:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601120856270.2964@virtualbox>
References: <cover.1452270051.git.johannes.schindelin@gmx.de> <cover.1452536924.git.johannes.schindelin@gmx.de> <0bab11634c8f05751b2ed5879bc4100441bba4b9.1452536924.git.johannes.schindelin@gmx.de> <CAPig+cQmhc=DmptyYWy1p3z4rz7_h-3XRrtFH7XxoW77z5Mz-A@mail.gmail.com>
 <xmqqtwmjvi75.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 08:57:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aItpV-0000Ws-9h
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 08:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761736AbcALH5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 02:57:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:60607 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761640AbcALH5U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 02:57:20 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LnPnu-1ZgoNp48J4-00hbAq; Tue, 12 Jan 2016 08:57:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqtwmjvi75.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:BEGmpwOuxmHOXQSqWh+lATqNwyL6kxjFzwBMICpj4oqIHIS3NA2
 /gd8ArWedPB6imw6BT+tngR5opnK31eJ48m33oZg74ga3BqWfMd+NxLsw3/iNMFXS2lIYGp
 PlrWkZomgep0c5EJfVF6M+auZop9/ZxmLOrSFO3uAQEsVQOkFnqE3HCd448R/eNRnsT/OmX
 CnrgIDXhVltHqI6cUufGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AnImhNMNXek=:2G0bQ5b/fjbcD42KV6ghDj
 JW+xrI5BIEDEIkjrnUfOwqk7eIT5WsczVU2JAtp3/W4Cm1b/z8vXUmtYkhs30U6uimF7lKApC
 U2fqEg8PQjELpBJx3m2inDK5StLU/KdFu8ZHP7UWNq2IqZGjoPMc7m0IREmy9OBeBMBOqaE9c
 YpO7h8GQc49FH9uYiWAgkOA4ybYTRyckfQ0v388LbwgnnEXseJq9PDDEF8F7dNxLND1POUXYB
 xAZ5Hhs5fVctzNrrjrL6xupuvAs8OGFNEY/l0y2jQIsD6tEflw+jKMn79jDhoG+TyTqTcz+Xv
 3B+qJgk7N2Z9fVHnDmQoOpg216E7bFipbp+AqWglPOu4HPLOw/MK1mOZPPNXE/M9KGbWz3WzG
 3s6Z5XizI1RjbX4LHrjElkzLXyxsMojFiXo4EJR+kMUUhrdiZlaayf0mi+Jgo7dpy50LUiy4e
 2VMp++NqAXckC7Ogb7Cuk+eZAXQtx3HXPT6aPyUv8r8BtwxfufkEp3RQJNIgztZFsEmkMl/uK
 PzTbWfCzXCB4HqCwZyQNQU9zNkKQjqT9w0dfhbZgY4MOLPcTv4pgI+CgHwam+C2AE3NeoQfg8
 d4FLi0yATHsBTHOPNAFAqximm+3qhQttYp7i5RD3fo4ytQT3tiZtPyk2ra7aiy6L22/VqmT3h
 pPxprnOGEaALPiVqhGoODbQJpksHxGA1k83SSrejdGe3ElOKytQiR7SESqUPkMWnIaDz3cQba
 z1Uqd2H0TsZq070moFbR/D3eePtZK2yP+t1H7e4Q0BsFhJniouX5GSnitHIJqAcbdzfQvAon 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283770>

Hi Eric & Junio,

On Mon, 11 Jan 2016, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > I wonder if this would be a bit easier to follow if it was structured
> > something like this:
> >
> >     static struct strbuf buf = STRBUF_INIT;
> >
> >     if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p)
> >         goto dot;
> >
> >     ...
> >     if (is_dir_sep(*p)) {
> >         ...
> >     }
> >     ...
> >     while ((c = *(p++)))
> >         ...
> >
> >     if (slash) {
> >         *slash = '\0';
> >         return path;
> >     }
> >
> >     dot:
> >     strbuf_reset(&buf);
> >     strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
> >     return buf.buf;
> 
> I'll queue the one from Dscho as-is for today, but avoiding the
> "jump back to a place where it happens to have an identical clean-up
> that need to happen" and defining the clean-up path at the end like
> this would probably be easier to follow.  It certainly would have
> saved one comment in the previous review cycle from me.

Thanks! I changed it and will mail out v4 shortly.

Ciao,
Dscho
