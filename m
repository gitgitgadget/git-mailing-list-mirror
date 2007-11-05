From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
	git, help users out.
Date: Mon, 5 Nov 2007 14:05:56 -0500
Message-ID: <20071105190556.GG22767@fieldses.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <20071105190411.GG6205@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 20:06:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7H4-0007M7-T4
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbXKETGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXKETGA
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:06:00 -0500
Received: from mail.fieldses.org ([66.93.2.214]:40014 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbXKETF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:05:59 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ip7Gm-0000d9-Ml; Mon, 05 Nov 2007 14:05:56 -0500
Content-Disposition: inline
In-Reply-To: <20071105190411.GG6205@artemis.corp>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63536>

On Mon, Nov 05, 2007 at 08:04:11PM +0100, Pierre Habouzit wrote:
> On Mon, Nov 05, 2007 at 07:01:41PM +0000, Pierre Habouzit wrote:
> > +		if (!lstat(name, &st)) {
> > +			die("Cannot find commit '%s', did you meant: "

s/meant/mean/

> > +				"git checkout HEAD -- '%s'", arg, arg);
> > +		} else {
> > +			die("Cannot find commit '%s'", arg);
> > +		}
> > +	}

--b.
