From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 4/8] Support remote helpers implementing smart
	transports
Date: Wed, 2 Dec 2009 09:12:08 -0800
Message-ID: <20091202171208.GD31648@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi> <20091201192233.GL21299@spearce.org> <20091202055543.GC31244@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:12:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFska-0008LW-O8
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184AbZLBRMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755092AbZLBRMF
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:12:05 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:42151 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbZLBRMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:12:05 -0500
Received: by ywh12 with SMTP id 12so429076ywh.21
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 09:12:11 -0800 (PST)
Received: by 10.101.4.38 with SMTP id g38mr374441ani.2.1259773931330;
        Wed, 02 Dec 2009 09:12:11 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 39sm630747yxd.63.2009.12.02.09.12.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 09:12:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091202055543.GC31244@Knoppix>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134354>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> On Tue, Dec 01, 2009 at 11:22:33AM -0800, Shawn O. Pearce wrote:
>  
> > Why 'OK'?  Currently remote-helpers return an empty blank line
> > to any successful command, not 'OK'.
> 
> Changed to "" (i.e. blank line) for next round.

Arrrgh.  Just to correct myself... the 'option' command uses 'ok',
'error', 'unsupported' as its response messages.  Which means
'option' breaks the blank-line-is-ok convention I tried to hold
you to above.

I consider this a mistake on my part.  'option' should respond with
a blank line on success just like 'fetch' or 'push' does.

-- 
Shawn.
