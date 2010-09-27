From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [Alt. PATCH 2/2] Documentation: pack.compression: explain how to
 recompress
Date: Mon, 27 Sep 2010 10:10:47 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009271010180.1146@xanadu.home>
References: <20100927133104.25ce5285@jk.gs>
 <alpine.LFD.2.00.1009270742250.1146@xanadu.home>
 <20100927141936.590d71b3@jk.gs> <20100927142158.487b8f19@jk.gs>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_YgI9OhopdBCRQ3YWMjFeGg)"
Cc: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Mon Sep 27 16:10:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0EPw-00060e-KY
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 16:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324Ab0I0OKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 10:10:49 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55244 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab0I0OKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 10:10:48 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L9E008BLSPZ5A40@VL-MR-MRZ22.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 27 Sep 2010 10:10:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100927142158.487b8f19@jk.gs>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157334>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_YgI9OhopdBCRQ3YWMjFeGg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Mon, 27 Sep 2010, Jan Krüger wrote:

> Add a small remark about how to recompress all existing objects after
> changing the compression level for pack files.
> 
> Signed-off-by: Jan Krüger <jk@jk.gs>

Acked-by: Nicolas Pitre <nico@fluxnic.net>


> ---
> 
> --- Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > In addition to that change, perhaps a note could be added to the 
> > documentation for pack.compression indicating that for the new
> > setting to take effect for existing packs, they must be repacked with
> > -F.
> 
> Good idea. Here it is.
> 
>  Documentation/config.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d294dd6..506477b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1465,6 +1465,10 @@ pack.compression::
>  	not set,  defaults to -1, the zlib default, which is "a default
>  	compromise between speed and compression (currently equivalent
>  	to level 6)."
> ++
> +Note that changing the compression level will not automatically recompress
> +all existing objects. You can force recompression by passing the -F option
> +to linkgit:git-repack[1].
>  
>  pack.deltaCacheSize::
>  	The maximum memory in bytes used for caching deltas in
> -- 
> 1.7.2.3.392.g02377.dirty
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_YgI9OhopdBCRQ3YWMjFeGg)--
