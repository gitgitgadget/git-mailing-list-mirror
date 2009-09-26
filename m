From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: Distribution size
Date: Sat, 26 Sep 2009 17:17:37 +0200
Message-ID: <4ABE3091.5040600@syntevo.com>
References: <1253962653-sup-1882@nixos> <alpine.DEB.1.00.0909261320370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marc Weber <marco-oweber@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 17:16:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrZ0r-0006FT-5O
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 17:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZIZPQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 11:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbZIZPQb
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 11:16:31 -0400
Received: from syntevo.com ([85.214.39.145]:34859 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbZIZPQa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 11:16:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 982B137CA4F
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.DEB.1.00.0909261320370.4985@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129157>

> Funny.  Git for Windows is less than 12MB [*1*].

Well, the portable Git bundle compressed with 7zip is approx. 11MB, the Git
installer (maybe also using 7zip internally) is at approx. the same size.
Unpacked/installed on disk they are at 138MB/131MB. If you try to compress
it with zip, it will reduce to approx. 70MB which still is quite large.

We are interested, too, in having a small(er) bundle, because we want to
distribute Git binaries with our Git GUI front-end, SmartGit, so the user
will (have the option to) get an all-inclusive-bundle.

--
Best regards,
Thomas Singer
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com


Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 26 Sep 2009, Marc Weber wrote:
> 
>> Has anyone thought about reducing distribution size ?
>>
>> comparison:
>>
>> git-1.6.4.4 i%du -hs .
>> 115M    .
> 
> Funny.  Git for Windows is less than 12MB [*1*].  And it includes a bash 
> and Perl.  (Did you count Python on Windows?)
> 
> So maybe your analysis is severely borked.
> 
> Ciao,
> Dscho
> 
> [*1*]: See http://msysgit.googlecode.com/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
