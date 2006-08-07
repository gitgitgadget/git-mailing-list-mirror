From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Re: Problem with clone hanging
Date: Mon, 07 Aug 2006 15:26:53 -0700
Message-ID: <1154989613.26375.104.camel@sardonyx>
References: <1154968942.26375.23.camel@sardonyx>
	 <20060807171240.GA19907@harddisk-recovery.com>
	 <1154971295.26375.48.camel@sardonyx>
	 <20060807215201.b54da1ce.vsu@altlinux.ru>
	 <1154975000.26375.86.camel@sardonyx>  <20060807183230.GA14955@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 00:26:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GADXw-0007Sq-Oi
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 00:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWHGWZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWHGWZ7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 18:25:59 -0400
Received: from hierophant.serpentine.com ([64.81.58.173]:22211 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S932285AbWHGWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 18:25:58 -0400
Received: from [127.0.0.1] (demesne.serpentine.com [192.168.16.11])
	by demesne.serpentine.com (Postfix) with ESMTP id 58FAD20B541;
	Mon,  7 Aug 2006 15:25:55 -0700 (PDT)
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20060807183230.GA14955@procyon.home>
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25048>

On Mon, 2006-08-07 at 22:32 +0400, Sergey Vlasov wrote:
> On Mon, Aug 07, 2006 at 11:23:20AM -0700, Bryan O'Sullivan wrote:
> > On Mon, 2006-08-07 at 21:52 +0400, Sergey Vlasov wrote:
> > 
> > > In the meantime, you can try to specify a local clone of the mainline
> > > Linux repository with the --reference=... option to git-clone. 
> > 
> > Thanks.  I don't know if what I'm cloning is actually a kernel tree,
> > unfortunately.
> 
> At least git ls-remote git://www.mellanox.co.il/~git/infiniband
> suggests this.

Thanks.  This got me unwedged.

	<b
