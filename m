From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable and world-readable
Date: Sat, 12 Apr 2008 21:52:54 +0300
Message-ID: <20080412185254.GE31039@zakalwe.fi>
References: <20080411140916.GA30667@zakalwe.fi> <7vfxtrnban.fsf@gitster.siamese.dyndns.org> <20080412030021.GB31039@zakalwe.fi> <7vzlrzlluj.fsf@gitster.siamese.dyndns.org> <20080412091723.GB20443@atjola.homenet> <7vprsvie4x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 20:54:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jkkre-0003dV-D8
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 20:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758249AbYDLSw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 14:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758258AbYDLSw4
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 14:52:56 -0400
Received: from zakalwe.fi ([80.83.5.154]:40815 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758227AbYDLSwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 14:52:55 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 27FA22C331; Sat, 12 Apr 2008 21:52:54 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vprsvie4x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79374>

On Sat, Apr 12, 2008 at 03:03:26AM -0700, Junio C Hamano wrote:
> "a set of umask modifications that were
> designed with only loosening in mind" can become maintenance burden, as we
> must keep them for backward compatibility.

The latest patch, just posted a few minutes ago, does not add any new 
keywords, but a generic 0xxx filemode value.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
