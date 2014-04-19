From: John Keeping <john@keeping.me.uk>
Subject: Re: Git: Please allow to use gpgsm to support X.509 certificates
Date: Sat, 19 Apr 2014 16:19:13 +0100
Message-ID: <20140419151913.GA29656@serenity.lan>
References: <87FCFF58480C9949AF1110DED8AC48E4E9A0D636@BASMX001.akros.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Schittli Thomas <Thomas.Schittli@akros.ch>
X-From: git-owner@vger.kernel.org Sat Apr 19 17:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbX3C-00079I-Di
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 17:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981AbaDSPT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 11:19:26 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:33841 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbaDSPTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 11:19:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5DAE2CDA609;
	Sat, 19 Apr 2014 16:19:24 +0100 (BST)
X-Quarantine-ID: <V7Qc1lNdNgwS>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7Qc1lNdNgwS; Sat, 19 Apr 2014 16:19:23 +0100 (BST)
Received: from coyote.aluminati.org (coyote.aluminati.org [10.0.16.51])
	by jackal.aluminati.org (Postfix) with ESMTP id B546CCDA5FF;
	Sat, 19 Apr 2014 16:19:21 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 8C4436064EF;
	Sat, 19 Apr 2014 16:19:21 +0100 (BST)
X-Quarantine-ID: <LyuSU+neO+bg>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LyuSU+neO+bg; Sat, 19 Apr 2014 16:19:20 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 25E7D6064EE;
	Sat, 19 Apr 2014 16:19:17 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87FCFF58480C9949AF1110DED8AC48E4E9A0D636@BASMX001.akros.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246516>

On Sat, Apr 19, 2014 at 11:03:07AM +0000, Schittli Thomas wrote:
> last night, brian m. Carlson explained, that "Git wants a key that can
> be used by GnuPG" and therefore X.509 certificates are not supported.
> 
> As you probably know, since 3 years gpg supports X.509 -
> unfortunately, gpg does not automatically detect X.509 certificates
> and we have to use gpgsm instead of gpg.
> The good thing: for identical functions, the command line arguments are identical :-)
> 
> Therefore: please allow to configure git, so that it can use gpg or gpgsm.
> Or even better: if gpg fails, then please automatically try gpgsm :-)

Have you tried `git config gpg.program gpgsm`?
