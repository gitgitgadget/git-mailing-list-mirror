From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
	foreign vcs
Date: Wed, 5 Aug 2009 14:53:48 -0700
Message-ID: <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org> 
	<alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de> <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com> 
	<alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:54:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoRn-0007to-3E
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbZHEVyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752706AbZHEVyK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:54:10 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:33202 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbZHEVyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:54:08 -0400
Received: by ewy10 with SMTP id 10so341903ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ucnATBD49oATTk7s+MC4oYjvm9OrUhuFFWAr8jG6Ej4=;
        b=HJIMUFGgXkA8JTz3/+36kPMft4KYqXSbhuxmF8dKgJJ8lhCWxWs2YsIBQ/0cNUFgVU
         NHxUo+jJ1SSA67GxyGRFk+mMnIhd4VjNuuM8ZCRCHkusJQb5LaJcG9zCh2Lvtw9C4blF
         TqGBHDV97rSdEUUYpvt8Pg01ptFGnDTeGy3Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=T79ZCp7q8hQZutuWGmCqSRBtg20xRMK2Fh1A5gyXRCNs01I5roOZIIXxmqt3Gb/+0j
         2eU5SiIKvZgxdHqbHL+/HRJdLhxlOK/dStMxpFXjI20EMGdYRnOTWY0ZAkzIy/VQkt4E
         8XMm96vNbNwm/7b+CYMXgnSmCPSm6ZqT09kcY=
Received: by 10.216.28.208 with SMTP id g58mr1986669wea.11.1249509248119; Wed, 
	05 Aug 2009 14:54:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125003>

Heya,

On Wed, Aug 5, 2009 at 14:50, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Problem: on Windows, we cannot name the helper git-remote-http+svn: "+" is
> not an allowed character in a filename.

Then do a s/+/-/ before calling the helper; no-one said the
translation between protocol name and helper name had to be 1:1, as
long as we document it there is no reason not to? Then again, maybe
it's more better to use 'svn-http" or 'svn:http' to make it obvious
that it's a special feature thingy.

-- 
Cheers,

Sverre Rabbelier
