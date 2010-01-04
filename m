From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule 
	working directory in git gui and gitk
Date: Mon, 4 Jan 2010 17:35:39 -0500
Message-ID: <32541b131001041435t7373990dxcab10a2d8aa346d8@mail.gmail.com>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> 
	<4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> 
	<20100104222701.GE22872@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRvX2-00060u-Ty
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 23:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab0ADWgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365Ab0ADWgH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 17:36:07 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:60927 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab0ADWgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 17:36:03 -0500
Received: by yxe26 with SMTP id 26so15026231yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 14:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=qhYKomyMfGplErNFVIoSAai5sXtUxV4c99XdevAfzrY=;
        b=I31hYMGdS6ictZ+nXguFVzACH4k95o3CVcJyC1LnUgxDpNkK51tHv5/iwG3Kr4D2g2
         dfHb4E8cwjVIWZsSwthWd13Bzz5eKKFP6rnSBBZkXp6ztyAnt/5umEUINS2GKtiABGf6
         VmP7rhKEFgxZxvloIa//C57jFzymSObl+blDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gQ0IJUQYgRsT1zN0cE63cI7Z1AUejV7ZOBSfAkSbKA3RhNs8qE5JP3NydFFVhc9jTS
         QxgfKhjSJ3fLNVXduIChT6kWDBoRbH8Zbla0ffLXL3TW6QXuA75YsOnKKuvVVmEnQOu2
         rWSeyI78m8vZyhHiTkLPGcAJ/bmLX7dtRcNoY=
Received: by 10.150.119.3 with SMTP id r3mr25886233ybc.324.1262644559229; Mon, 
	04 Jan 2010 14:35:59 -0800 (PST)
In-Reply-To: <20100104222701.GE22872@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136146>

On Mon, Jan 4, 2010 at 5:27 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Besides, as long as there is enough reason to have out-of-Git alternative
>> solutions such as repo, submodules deserve to be 2nd-class citizens.
>
> If I didn't think I'd be shot by current submodule users, I'd offer
> to write a full replacement based around the current in repository
> format, but with sane features like we have in repo.

Perhaps write it and call it 'git sub' or something.  Put them both
in, and let users decide which they want to use.  Or, like git
subtree, maintain it separately.

Personally, I've avoided tools like repo because they seem to try to
kidnap my *entire* git experience, most of which is already fine.
It's just submodules that are crazy.  I think it's probably similar
for other people.

Avery
