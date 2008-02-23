From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Sat, 23 Feb 2008 13:15:47 +0000
Message-ID: <57518fd10802230515v2f71d6a8jcdc33fb2332ceb8f@mail.gmail.com>
References: <47AAA254.2020008@thorn.ws>
	 <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org>
	 <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org>
	 <200802231352.37934.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Gerrit Pape" <pape@smarden.org>, git@vger.kernel.org,
	"Paul Mackerras" <paulus@samba.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 14:16:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSuFC-0008Ed-TP
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 14:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbYBWNPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 08:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbYBWNPu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 08:15:50 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:44423 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbYBWNPs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2008 08:15:48 -0500
Received: by rv-out-0910.google.com with SMTP id k20so493316rvb.1
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=OWBmIXwyd8pWNdeK+vhnG1irD0YwUb0qcOrFKzyXo8s=;
        b=cq1s+L3FR0TA6EQnQ+bukg4YppwUv2lDWfiVaVea5rgr9wwH+IxO5YT/eS/sIcH+7UKDi+A5kj1XsmX1xAgEC6zHIjfID4DpA0j5hoY539apG4fLRFtuUYUKJqa2/9Alae89x5iUrGaazK046GCyRH6vtmv3xV98zrp5dvDIEXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DJRdtY9EmbMXyGUQXVn/PNtDKiL10f4Hp0aWljKhm5l/0LpfWhB7g/Cou8QHGy6WDSaKlTKoR7SGr1Vuq7qIwhZaA8rMkcD3ERle3MAqBLtTz9qkctEcKgjMH9EfWLgQtv6gUthv2EZ1AIpdPvMtI+BWDV//n7o0wxnOh/XubyI=
Received: by 10.141.142.15 with SMTP id u15mr267202rvn.66.1203772547614;
        Sat, 23 Feb 2008 05:15:47 -0800 (PST)
Received: by 10.141.86.15 with HTTP; Sat, 23 Feb 2008 05:15:47 -0800 (PST)
In-Reply-To: <200802231352.37934.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Google-Sender-Auth: 57fbedf4d6a72a4e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74821>

On Sat, Feb 23, 2008 at 12:52 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> l=F6rdagen den 23 februari 2008 skrev Gerrit Pape:
>
> > Saving the geometry can cause several inconveniences, e.g. when usi=
ng a
>  > temporary dual screen setup, or sharing ~/.gitk between multiple
>  > systems.  Additionally it can be argued that window placement and =
sizing
>  > are the tasks of the window manager.  So don't do that anymore.
>
>  Shouldn't the restoring code also be dropped then?

Perhaps, though that would prevent you setting up default width &
height.  You'd always be stuck with the (too small IMO) original
window size
