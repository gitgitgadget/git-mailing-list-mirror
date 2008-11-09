From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH (GITK) v3 6/6] gitk: Explicitly position popup windows.
Date: Sun, 9 Nov 2008 11:26:12 +0100
Message-ID: <20081109102612.GB5463@blimp.localdomain>
References: <1225652389-22082-1-git-send-email-angavrilov@gmail.com> <1225652389-22082-2-git-send-email-angavrilov@gmail.com> <1225652389-22082-3-git-send-email-angavrilov@gmail.com> <1225652389-22082-4-git-send-email-angavrilov@gmail.com> <1225652389-22082-5-git-send-email-angavrilov@gmail.com> <1225652389-22082-6-git-send-email-angavrilov@gmail.com> <1225652389-22082-7-git-send-email-angavrilov@gmail.com> <18708.11537.229423.296701@cargo.ozlabs.ibm.com> <81b0412b0811070639q47244bc4t10791781fb0ec43b@mail.gmail.com> <49146EC0.4050006@viscovery.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzb9P-00040H-Ge
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbYKJSEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 13:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYKJSEz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:04:55 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.180]:24076 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036AbYKJSEz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 13:04:55 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8A081oLA=
Received: from tigra.home (Fac0f.f.strato-dslnet.de [195.4.172.15])
	by post.webmailer.de (klopstock mo4) (RZmta 17.18)
	with ESMTP id h0653ckAAGgvrX ; Mon, 10 Nov 2008 19:04:40 +0100 (MET)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 45EE3277C8;
	Mon, 10 Nov 2008 19:04:40 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id A7BB636D28; Sun,  9 Nov 2008 11:26:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49146EC0.4050006@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100538>

Johannes Sixt, Fri, Nov 07, 2008 17:37:20 +0100:
> Alex Riesen schrieb:
> > 2008/11/7 Paul Mackerras <paulus@samba.org>:
> >> Is there any reason to call tk::PlaceWindow under Linux or MacOS?
> >> If not I'd rather add an if statement so we only call it on Windows.
> >>
> > 
> > Yes, please. I rather like the smart placement in compiz.
> 
> Just out of curiosity because I don't use compiz: Did you mean
>    "Yes, please call tk::PlaceWindow on Linux"
> or
>    "Yes, please add the if statement"

That one. So PlaceWindow is NOT called.
