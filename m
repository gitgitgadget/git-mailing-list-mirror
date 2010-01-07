From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH git-gui 5/5] git-gui/Makefile: consolidate .FORCE-*
	targets
Date: Wed, 6 Jan 2010 18:20:34 -0800
Message-ID: <20100107022034.GE32155@spearce.org>
References: <20091128112546.GA10059@progeny.tock> <20091128113709.GD10059@progeny.tock> <20100106080216.GA7298@progeny.tock> <20100106081638.GF7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 03:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NShza-0001iU-5O
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 03:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756607Ab0AGCUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 21:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756601Ab0AGCUj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 21:20:39 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:48211 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab0AGCUi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 21:20:38 -0500
Received: by yxe26 with SMTP id 26so17284741yxe.4
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 18:20:37 -0800 (PST)
Received: by 10.150.118.5 with SMTP id q5mr41112808ybc.298.1262830836858;
        Wed, 06 Jan 2010 18:20:36 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm19923884iwn.11.2010.01.06.18.20.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 18:20:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106081638.GF7298@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136315>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Providing multiple targets to force a rebuild is unnecessary
> complication.
> 
> Avoid using a name that could conflict with future special
> targets in GNU make (a leading period followed by uppercase
> letters).
> 
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, applied.

-- 
Shawn.
