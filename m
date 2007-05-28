From: Nix <nix@esperi.org.uk>
Subject: Re: GIT on MinGW problem
Date: Mon, 28 May 2007 17:54:12 +0100
Message-ID: <87646c28jv.fsf@hades.wkstn.nix>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500>
	<464534EE.30904@xs4all.nl> <4656A304.AF39A0B6@eudaptics.com>
	<Pine.LNX.4.64.0705251113280.4648@racer.site>
	<46588DA4.5020109@xs4all.nl>
	<Pine.LNX.4.64.0705262311380.4648@racer.site>
	<46592B92.9060403@xs4all.nl>
	<Pine.LNX.4.64.0705271149450.4648@racer.site>
	<4659BA07.4080307@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Mon May 28 19:25:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsiyB-0000pF-QQ
	for gcvg-git@gmane.org; Mon, 28 May 2007 19:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017AbXE1RZH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758342AbXE1RZH
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 13:25:07 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:1727 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033AbXE1RZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 13:25:05 -0400
X-Greylist: delayed 1845 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 May 2007 13:25:05 EDT
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l4SGsDbW016724;
	Mon, 28 May 2007 17:54:13 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l4SGsCXj012042;
	Mon, 28 May 2007 17:54:12 +0100
Emacs: impress your (remaining) friends and neighbors.
In-Reply-To: <4659BA07.4080307@xs4all.nl> (Han-Wen Nienhuys's message of "Sun, 27 May 2007 14:04:07 -0300")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC-dcc1-Metrics: hades 1182; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48628>

On 27 May 2007, Han-Wen Nienhuys said:

> Johannes Schindelin escreveu:
>
>>>       ((Tcl_Obj **) objv) += (async + 3);
>> 
>> Ah yes, I was using MinGW's own GCC, which is GCC 3.something.
>> 
>> It is a new "feature" of GCC 4.x to disallow constructs like these. 
>> (Probably because GCC people think that other people are not intelligent 
>> enough to understand such constructs, and therefore prohibit their use.)
>
> I very much doubt that. GCC uses type information to determine whether 
> pointers might be aliased.  I think disallowing such constructs helps with
> compiler optimization.

Actually it was simply too difficult to maintain this extension over the
C and C++ parser rewrites in the early 4.x timeline. (Also, IIRC, it had
some *nasty* ambiguities, especially in C++.)

-- 
`On a scale of one to ten of usefulness, BBC BASIC was several points ahead
 of the competition, scoring a relatively respectable zero.' --- Peter Corlett
