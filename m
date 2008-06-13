From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 10:41:42 +0200
Message-ID: <CA1D4ABE-0B83-44CC-B582-1E85784330AB@wincent.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer> <20080611230344.GD19474@sigill.intra.peff.net> <co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil> <20080612041847.GB24868@sigill.intra.peff.net> <u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil> <20080613054840.GA27122@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:43:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K74sc-0005js-1W
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbYFMImd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 04:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbYFMImd
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:42:33 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:43693 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbYFMImc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 04:42:32 -0400
Received: from cuzco.lan (185.pool85-53-11.dynamic.orange.es [85.53.11.185])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m5D8fhbY030944
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 13 Jun 2008 04:41:45 -0400
In-Reply-To: <20080613054840.GA27122@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84848>

El 13/6/2008, a las 7:48, Jeff King escribi=F3:

> On Thu, Jun 12, 2008 at 11:46:34AM -0500, Brandon Casey wrote:
>
>>
>> from reflogs even though stashes are implemented using reflogs. The =
=20
>> big
>> difference is that reflogs are created automatically and stashes =20
>> are created
>> by explicit user action. Automatically deleting something that git =20
>> creates
>> automatically is ok and desirable, doing so for something the user =20
>> explicitly
>> created is not necessarily so.
>
> Wincent made this same argument. I don't really agree with it. It is
> predicated on the assumption that stashing something _is_ asking for =
=20
> git
> to remember it.

=46or me it is quite clear that stashing something _is_ asking for Git =
=20
to remember it. It's an explicit user action. It's a request to =20
remember something. Whether or not this is actually the best tool for =20
the job of long-term storage is much less important than the fact that =
=20
the user explicitly requested it. IMO this trumps all other factors. =20
Just because "stash" sounds quicker than "commit" doesn't make it any =20
less of an instruction to Git to store something.

Wincent
