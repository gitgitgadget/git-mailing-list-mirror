From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Alphabetize the fast-import options, following a
 suggestion on the list.
Date: Sun, 6 Jan 2013 00:13:09 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130106051309.GB2303@thyrsus.com>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 06:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TriZG-0003mC-Uk
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 06:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736Ab3AFFNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 00:13:17 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:59307
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3AFFNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 00:13:16 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 9AECC4044B; Sun,  6 Jan 2013 00:13:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130105231151.GD3247@elie.Belkin>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212751>

Jonathan Nieder <jrnieder@gmail.com>:
> But in fact the current options list doesn't seem to be well organized at all.

I agree.

> What do you think would be a logical way to group these?
> 
>  Features of input syntax
> 
> 	--date-format
> 	--done
> 
>  Verbosity
> 
> 	--quiet
> 	--stats
> 
>  Marks handling (checkpoint/restore)
> 
> 	--import-marks
> 	--import-marks-if-exists
> 	--export-marks
> 	--relative-marks
> 
>  Semantics of execution
> 
> 	--dry-run
> 	--force
> 	--cat-blob-fd
> 	--export-pack-edges
> 
>  Tuning
> 
> 	--active-branches
> 	--max-pack-size
> 	--big-file-threshold
> 	--depth

That would work as well or better than any other organization I can
think of.  Um, which is significant because my work on surgery tools
and exporters means I've had to consult this page a *lot*.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
