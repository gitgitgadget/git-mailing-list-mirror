From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Tue, 8 Feb 2011 12:40:55 +0200
Message-ID: <20110208104055.GA10629@LK-Perkele-VI.localdomain>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie>
 <20110207095713.GA19653@do>
 <7v1v3jvaef.fsf@alter.siamese.dyndns.org>
 <AANLkTim_G9cPs=+1GQ2qBEgriOyKYgXk17iHE4oq9h2C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 11:41:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pml0X-0007LB-6g
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 11:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367Ab1BHKlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 05:41:14 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:47269 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1BHKlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 05:41:12 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 9F1BC8C727;
	Tue,  8 Feb 2011 12:41:10 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0725E8634D; Tue, 08 Feb 2011 12:41:10 +0200
Received: from LK-Perkele-VI (a88-112-56-215.elisa-laajakaista.fi [88.112.56.215])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id E5F32404B;
	Tue,  8 Feb 2011 12:41:01 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <AANLkTim_G9cPs=+1GQ2qBEgriOyKYgXk17iHE4oq9h2C@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166349>

On Tue, Feb 08, 2011 at 11:11:19AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Tue, Feb 8, 2011 at 3:48 AM, Junio C Hamano <gitster@pobox.com> wrote:

> bug regardless directory tracking support in 1.8.0. A corner case that
> nobody would likely encounter (except Ilari and his "ghost directory"
> problem).

Except it wasn't me who directly saw those problems. It was somebody else
on #git (back when I was there). That was a while ago. That's the reason
I don't exactly remember what exactly it did (possibly false modifications
causing some commands (merge/rebase) to abort?).

Hmm. I should test what exactly happens (including with older git versions
to see if those problems have (possibly unintentionally) got fixed).

-Ilari
