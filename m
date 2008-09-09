From: Jing Xue <jingxue@mindportcorp.com>
Subject: Re: Re* file deletion in index lost after checkout -b
Date: Mon, 8 Sep 2008 22:06:11 -0400
Message-ID: <20080909020611.GD10924@jabba.hq.digizenstudio.com>
References: <20080901034414.GR6619@jabba.hq.digizenstudio.com> <7vljy7xgs5.fsf@gitster.siamese.dyndns.org> <7vprnfic7e.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 04:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcsk0-00049Z-Jl
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 04:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbYIICM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 22:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbYIICM6
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 22:12:58 -0400
Received: from k2smtpout02-01.prod.mesa1.secureserver.net ([64.202.189.90]:34012
	"HELO k2smtpout02-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751412AbYIICM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 22:12:57 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Sep 2008 22:12:57 EDT
Received: (qmail 22372 invoked from network); 9 Sep 2008 02:06:17 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout02-01.prod.mesa1.secureserver.net (64.202.189.90) with ESMTP; 09 Sep 2008 02:06:17 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 29A78100A22;
	Tue,  9 Sep 2008 02:06:17 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sp7yCfHFHspl; Mon,  8 Sep 2008 22:06:12 -0400 (EDT)
Received: from jabba.hq.digizenstudio.com (ip70-174-133-176.dc.dc.cox.net [70.174.133.176])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 625BD10008B;
	Mon,  8 Sep 2008 22:06:12 -0400 (EDT)
Received: by jabba.hq.digizenstudio.com (Postfix, from userid 1000)
	id 5E93748E9A; Mon,  8 Sep 2008 22:06:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vprnfic7e.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95331>

On Sun, Sep 07, 2008 at 07:49:25PM -0700, Junio C Hamano wrote:
> Try this patch.

Works well. It doesn't give the fatal warning from "checkout -m" either.
"make test" shows it doesn't break any existing tests.

Thanks.
-- 
Jing
