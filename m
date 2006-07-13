From: Christopher Faylor <me@cgf.cx>
Subject: Re: Error writing loose object on Cygwin
Date: Thu, 13 Jul 2006 01:51:27 -0400
Message-ID: <20060713055127.GA15960@trixie.casa.cgf.cx>
References: <20060712035746.GA7863@spearce.org> <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 13 07:51:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0u6l-0002qw-J9
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWGMFv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWGMFv2
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:51:28 -0400
Received: from pool-71-248-179-44.bstnma.fios.verizon.net ([71.248.179.44]:24740
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S1751458AbWGMFv2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 01:51:28 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id AF3B713C020; Thu, 13 Jul 2006 01:51:27 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23819>

On Tue, Jul 11, 2006 at 09:15:38PM -0700, Junio C Hamano wrote:
>Shawn Pearce <spearce@spearce.org> writes:
>
>> Has anyone else seen this type of behavior before?  Any suggestions
>> on debugging this issue?
>
>I would suggest raising this (politely) to Cygwin people.

I lost the thread here but wasn't this referring to a samba mount?  If so,
it would be samba that's returning the wrong "errno".

cgf
