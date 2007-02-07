From: Jan Nieuwenhuizen <jan@avatar.nl>
Subject: Re: MinGW binary installer available
Date: Wed, 07 Feb 2007 21:18:26 +0100
Organization: lilypond-design.com
Message-ID: <87y7n990x9.fsf@peder.flower>
References: <45C9E470.7030609@xs4all.nl>
	<Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45C9F842.3080704@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:25:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtME-0006Y5-MR
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbXBGUZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbXBGUZb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:25:31 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:2214 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422769AbXBGUZb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:25:31 -0500
X-Greylist: delayed 404 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Feb 2007 15:25:30 EST
Received: from peder.flower (peder.xs4all.nl [82.93.198.126])
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id l17KIieb038869;
	Wed, 7 Feb 2007 21:18:44 +0100 (CET)
	(envelope-from jan@avatar.nl)
Received: by peder.flower (Postfix, from userid 1000)
	id D3ED6177407A; Wed,  7 Feb 2007 21:18:26 +0100 (CET)
In-Reply-To: <45C9F842.3080704@xs4all.nl> (Han-Wen Nienhuys's message of "Wed\, 07 Feb 2007 17\:03\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38962>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Strange, those are builtins, not?  I recall that we also had
> some issues with lilypond stdout printing things inside CMD,
> depending on whether -mwindows is on the link line.
> Details escape me, though. 

> Jan? 

I didn't either, but Google says

   This is a windows limitation.  GUI apps (apps created with -mwindows)
   can't send output to or receive input from the console.

That seems right, I remember that we chose to use -mwindows to get
rid of the flashing black console silliness.

Greetings,
Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
