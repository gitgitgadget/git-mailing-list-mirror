From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 21:36:15 +0300
Message-ID: <20080512183615.GO31039@zakalwe.fi>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com> <alpine.DEB.1.00.0805121606010.30431@racer> <20080512152731.GM31039@zakalwe.fi> <alpine.DEB.1.00.0805121804500.30431@racer> <20080512180720.GN31039@zakalwe.fi> <alpine.DEB.1.00.0805121920120.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: bill lam <cbill.lam@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 12 20:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvctW-00041l-TF
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYELSgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753133AbYELSgR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:36:17 -0400
Received: from zakalwe.fi ([80.83.5.154]:35179 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbYELSgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:36:16 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 58D4E2BBE5; Mon, 12 May 2008 21:36:15 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805121920120.30431@racer>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81896>

On Mon, May 12, 2008 at 07:21:02PM +0100, Johannes Schindelin wrote:
> Heikki, why don't you just go with the "git fetch" approach I described?  
> We do not need "git backup" when "git fetch" does already what you want.

I need efficient (small) daily increment files. What I could do is 
something like:

1. rm -rf yesterday ; mv today yesterday

2. git clone yesterday today

3. cd today && git fetch /path/to/repo

4. create an increment file (from yesterday to today) or a full

The above should just be something like (why not make this easy?):

1. git backup /path/to/repo /backup/location/

And restoration should be something like:

1. git backup --restore /backup/location/foo /path/to/repo

Am I missing something?

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
