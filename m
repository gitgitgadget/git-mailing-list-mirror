From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 05:59:19 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102105919.GA14391@thyrsus.com>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <20130102080247.GA20002@elie.Belkin>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 12:00:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqM3e-0000tW-BE
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 12:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab3ABLAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 06:00:05 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34238
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab3ABLAE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 06:00:04 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 266B74415C; Wed,  2 Jan 2013 05:59:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130102080247.GA20002@elie.Belkin>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212512>

Jonathan Nieder <jrnieder@gmail.com>:
> Speaking with my Debian packager hat on: the updated cvsps is not
> available in Debian.  "git cvsimport" is, and it has users that report
> bugs from time to time.  With this change, I would either have to take
> on responsibility for maintenance of the cvsps package (not going to
> happen) or drop "git cvsimport".  That's a serious regression.

How does going from "it silently damages imports" to "it fails with
an error message" constitute a regression?
 
> The moment someone takes care of packaging the updated cvsps, I'll
> stop minding, though. ;-)

I'll ping the Debian QA group.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
