From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 08:05:21 +0200
Organization: glandium.org
Message-ID: <20070924060521.GB10975@glandium.org>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 08:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZh5I-0002m9-6P
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 08:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738AbXIXGGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 02:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbXIXGGM
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 02:06:12 -0400
Received: from vawad.err.no ([85.19.200.177]:53715 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616AbXIXGGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 02:06:11 -0400
Received: from aputeaux-153-1-33-201.w82-124.abo.wanadoo.fr ([82.124.3.201] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IZh5B-0000E8-Jr; Mon, 24 Sep 2007 08:06:13 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IZh4L-00035L-WB; Mon, 24 Sep 2007 08:05:22 +0200
Content-Disposition: inline
In-Reply-To: <85myvdktb3.fsf@lola.goethe.zz>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59019>

On Sun, Sep 23, 2007 at 10:42:08PM +0200, David Kastrup wrote:
> -while case $# in 0) break ;; esac
> +while test $# != 0

Wouldn't -ne be better ?

Mike
