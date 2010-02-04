From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] make --max-pack-size argument to 'git pack-object'
 count in bytes
Date: Thu, 04 Feb 2010 12:49:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002041243570.1681@xanadu.home>
References: <1265255308-20514-1-git-send-email-nico@fluxnic.net>
 <1265255308-20514-3-git-send-email-nico@fluxnic.net>
 <20100204040046.GR14799@spearce.org> <7v7hqtty38.fsf@alter.siamese.dyndns.org>
 <7vtytxexjl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 18:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd5pm-0005US-MA
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 18:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0BDRte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 12:49:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36227 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab0BDRtd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 12:49:33 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXB005N8W60MD20@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 04 Feb 2010 12:49:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vtytxexjl.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138989>

On Thu, 4 Feb 2010, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] fast-import: count --max-pack-size in bytes
> 
> Similar in spirit to 07cf0f2 (make --max-pack-size argument to 'git
> pack-object' count in bytes, 2010-02-03) which made the option by the same
> name to pack-objects, this counts the pack size limit in bytes.
> 
> In order not to cause havoc with people used to the previous megabyte
> scale, and because this is a sane thing to do anyway, a minimum size of 1
> MiB is enforced to avoid an explosion of pack files.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

ACK.

>  --max-pack-size=<n>::
> -	Maximum size of each output packfile, expressed in MiB.
> -	The default is 4096 (4 GiB) as that is the maximum allowed
> +	Maximum size of each output packfile.
> +	The default is 4 GiB as that is the maximum allowed
>  	packfile size (due to file format limitations). Some
>  	importers may wish to lower this, such as to ensure the
>  	resulting packfiles fit on CDs.

What file format limitation is alluded to here?  It has been a while 
since the 4GB limit on pack file format has been removed.  If this is a 
limitation of fast-import only then maybe this should be explained more 
explicitly.


Nicolas
