From: Richard Maw <richard.maw@codethink.co.uk>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Fri, 8 Jan 2016 10:52:04 +0000
Message-ID: <20160108105204.GD3397@logi.codethink.co.uk>
References: <20160107165417.GB3397@logi.codethink.co.uk>
 <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
 <20160108101903.GC3397@logi.codethink.co.uk>
 <CACsJy8CBj-oMTLrn8gVudhLPEixZfkwFv9BaN8LSNFvOHkqKkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 11:52:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHUeX-00084c-P7
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 11:52:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbcAHKwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 05:52:12 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:57771 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615AbcAHKwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 05:52:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id B09E34624C0;
	Fri,  8 Jan 2016 10:52:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWGeOfs8S0XM; Fri,  8 Jan 2016 10:52:06 +0000 (GMT)
Received: from logi.codethink.co.uk (unknown [10.24.1.141])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 5A523460245;
	Fri,  8 Jan 2016 10:52:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CACsJy8CBj-oMTLrn8gVudhLPEixZfkwFv9BaN8LSNFvOHkqKkg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283535>

On Fri, Jan 08, 2016 at 05:44:30PM +0700, Duy Nguyen wrote:
> It sounds a lot like what I did with narrow clone [2] prototype. A
> narrow clone only contains enough objects for certain paths so there's
> a chance that we just don't have enough to do a proper merge. A
> server-side command was added [1] to retrieve enough objects for the
> task. If you fetch commit chain without all necessary trees and
> objects, your repo is "broken" from Git point of view and you'll need
> to do some extra work to make sure your repo is not actually broken.
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/154371
> [2] http://thread.gmane.org/gmane.comp.version-control.git/154343

Thanks for the links. I'll have a read to see how it fits together.
