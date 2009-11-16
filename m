From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Speed up bash completion loading
Date: Sun, 15 Nov 2009 17:55:57 -0800
Message-ID: <20091116015557.GZ11919@spearce.org>
References: <20091111220832.GA31620@progeny.tock> <4AFCFF50.5080401@gmail.com> <20091113070652.GA3907@progeny.tock> <4AFD06CD.7090003@gmail.com> <20091113085028.GA4804@progeny.tock> <20091113090343.GA5355@progeny.tock> <4AFDC4F3.1050607@gmail.com> <20091114110141.GB1829@progeny.tock> <7vd43krwd0.fsf@alter.siamese.dyndns.org> <20091115102912.GA4100@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 02:56:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9qp6-0006vt-Lb
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 02:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbZKPBzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 20:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbZKPBzw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 20:55:52 -0500
Received: from george.spearce.org ([209.20.77.23]:53423 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZKPBzw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 20:55:52 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id F288C381D5; Mon, 16 Nov 2009 01:55:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091115102912.GA4100@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132982>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Since git is not used in each and every interactive xterm, it
> seems best to load completion support with cold caches and then
> load each needed thing lazily.  This has most of the speed
> advantage of pre-generating everything at build time, without the
> complication of figuring out at build time what commands will be
> available at run time.
> 
> Suggested-by: Kirill Smelkov <kirr@mns.spb.ru>
> Cc: Shawn O. Pearce <spearce@spearce.org>

Acked-By: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
