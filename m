From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 19:41:11 +0200
Message-ID: <20130611174111.GA22235@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
 <20130609191518.GB12122@paksenarrion.iveqy.com>
 <7vhah4d3sk.fsf@alter.siamese.dyndns.org>
 <20130611170815.GA20009@paksenarrion.iveqy.com>
 <CAMP44s0VksnZmi21u6T79AvMebWA3gXmWbQ6pp=FAHL=D4q6+Q@mail.gmail.com>
 <20130611172416.GB20009@paksenarrion.iveqy.com>
 <CAMP44s3OG2MSO=zwAvzTnTLYOJmhsmbjrVJOxP-0ZSaxgMuUXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:38:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSWW-0001Ib-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab3FKRiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 13:38:20 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35956 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab3FKRiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:38:19 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so2929903lbd.18
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=74TlE7VutuJrSt4tFO0AyuMqL643OxmreR/P6ddNRog=;
        b=YBVzGPTWo/ZK32B0E8E73HQWJsLgxUS0ehNKVhHwLPjF3EtydpZDVoAp+i3JYm89SI
         X0yZ141TquUW9lR49N/ti/GdBsS9kQ36/tMFpZlo/7Thm/NcL55UflmXtc5/mMNOjmRd
         EB08PqDEEV/SeVwbdTKK0Gzm3iOZoi2Aats7xa6r1S0RlsejDSIpZJXDROFwOi4+zV7+
         rL6blTfLIxcebGjLSRXiPdQ6q6j6oMZ10d+SRChjWANSToJ1RWo95bexkBegOKG6Y7Zc
         Gehl8SThH6bLe3DM35SLR9q4ZCKr/lrlZ45O+NqkDt8uCAs3yY96SQG41Lf+aweYj1jY
         OyFg==
X-Received: by 10.112.12.137 with SMTP id y9mr9211541lbb.91.1370972298555;
        Tue, 11 Jun 2013 10:38:18 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id w9sm6054534lbk.7.2013.06.11.10.38.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Jun 2013 10:38:17 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UmSZD-0005pH-6M; Tue, 11 Jun 2013 19:41:11 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s3OG2MSO=zwAvzTnTLYOJmhsmbjrVJOxP-0ZSaxgMuUXA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227475>

On Tue, Jun 11, 2013 at 12:26:42PM -0500, Felipe Contreras wrote:
> On Tue, Jun 11, 2013 at 12:24 PM, Fredrik Gustafsson <iveqy@iveqy.com=
> wrote:
> > On Tue, Jun 11, 2013 at 12:09:32PM -0500, Felipe Contreras wrote:
> >> It's not removed. It's simply moved.
> >
> > Sorry about that, I wasn't paying enough attention. But why are you
> > moving it?
> >
> > All other arguments to git am is set in git-rebase.sh, why just set
> > -q just before the invokation in git-rebase--am.sh?
>=20
> Because the next patch checks if there's any arguments meant for 'git
> am' to switch to am rebase mode. We shouldn't switch to that mode if
> the only argument to 'git am' is going to be -q.

Okay, that make sense. How about rephrase the commit message and add
this explanation. It's really not a cleanup but a preparation for the
next patch.

If I was a maintainer and only got this patch I would reject it. Every
patch in a patch serie should be justified to be applied as a single
patch, yes?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
