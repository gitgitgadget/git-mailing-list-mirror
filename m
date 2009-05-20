From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 0/3] http*: refactor fetching code (v2)
Date: Wed, 20 May 2009 09:43:52 +0200
Message-ID: <20090520074352.GC21455@glandium.org>
References: <20090518163025.58842505.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 09:44:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6gTu-0005CZ-77
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 09:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbZETHoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 03:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbZETHoD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 03:44:03 -0400
Received: from vuizook.err.no ([85.19.221.46]:53717 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbZETHoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 03:44:01 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1M6gSt-0005IO-GT; Wed, 20 May 2009 09:43:55 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1M6gSu-0006MN-1o; Wed, 20 May 2009 09:43:52 +0200
Content-Disposition: inline
In-Reply-To: <20090518163025.58842505.rctay89@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119585>

On Mon, May 18, 2009 at 04:30:25PM +0800, Tay Ray Chuan wrote:
> This patch series applies on pu.
> 
> The major differences between this series and the 11-patch long one
> (dated May 15, 2009) are:
> 
>  *check 'preq' pointer before using it (for fetching packs) [1]
>  *moved free(url) before 'abort' label to stop -Wuninitialized warning
>   (for fetching loose objects) [2]
>  *use unlink_or_warn, after 691f1a2 ("replace direct calls to unlink
>   (2) with unlink_or_warn")
> 
> Junio: I've rebased the patch series on pu, hopefully this stops the
> attribute warnings for patch 3.
> 
> Tay Ray Chuan (3):
>   http*: add helper methods for fetching packs
>   http*: add helper methods for fetching objects/info/packs
>   http*: add helper methods for fetching objects (loose)

I do think these would be even better if they were integrated with
http://kerneltrap.org/mailarchive/git/2009/1/18/4757804.

Speaking of which, do we have a better http test suite now ? If we do, I
can try to (finally) finalize my work.

Mike
