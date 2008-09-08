From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [PATCH] t6023-merge-file: Work around non-portable sed usage
Date: Mon, 8 Sep 2008 21:23:13 +0200
Message-ID: <20080908192313.GB4148@regex.yaph.org>
References: <1220898558-73783-1-git-send-email-arjen@yaph.org> <cNVNi0DglMtk8yH2LYJQdUZ7rfXlu4pff2TkbJj4KU6hnx-n_IQ3nw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcmL0-0000rk-Ov
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbYIHTWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 15:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYIHTWo
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:22:44 -0400
Received: from regex.yaph.org ([193.202.115.201]:34000 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421AbYIHTWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 15:22:44 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id D02A25B7D5; Mon,  8 Sep 2008 21:23:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cNVNi0DglMtk8yH2LYJQdUZ7rfXlu4pff2TkbJj4KU6hnx-n_IQ3nw@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95295>

On Mon, Sep 08, 2008 at 02:06:02PM -0500, Brandon Casey wrote:
[...]
> I was just encountering this myself.
> 
> sed can be fixed without the use of tr by replacing '\n' with an explicit newline like:
> 
> sed -e 's/deerit./&\
> \
> \
> \
> /' -e "s/locavit,/locavit;/" < new6.txt > new8.txt
> 
> Of course it doesn't fit on one line though.

I don't think replacing 2 lines with 10 is a big win (not counting a
possible comment explaining why it's necessary).  I'd rather replaced
the thing with a Perl one-liner though, but that seems a bit frowned
upon, correct?

Arjen

-- 
Arjen Laarhoven

The presence of those seeking the truth is infinitely to be preferred to 
those who think they've found it.
                                -- Terry Pratchett, "Monstrous Regiment"
