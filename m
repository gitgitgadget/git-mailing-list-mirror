From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH 4/4] Rename push.default to push.style
Date: Mon, 30 Mar 2009 10:01:15 +0200
Message-ID: <20090330080115.GA19142@pvv.org>
References: <1238281804-30290-1-git-send-email-santi@agolina.net> <1238281804-30290-5-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 10:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoCSG-0007nf-Nb
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 10:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbZC3IBT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 04:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbZC3IBS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 04:01:18 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:60789 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZC3IBS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 04:01:18 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LoCQl-0007cy-Kr; Mon, 30 Mar 2009 10:01:15 +0200
Content-Disposition: inline
In-Reply-To: <1238281804-30290-5-git-send-email-santi@agolina.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115101>

On Sun, Mar 29, 2009 at 12:10:04AM +0100, Santi B=E9jar wrote:
> push.default was too generic, and also didn't specify if it was about
> remote, refspec, branches, behaviour...
> [...]
>  	"You can specify what action you want to take in this case, and",
> -	"avoid seeing this message again, by configuring 'push.default' to:=
",
> +	"avoid seeing this message again, by configuring 'push.style' to:",
>  	"  'nothing'  : Do not push anything",
>  	"  'matching' : Push all matching branches (default)",
>  	"  'tracking' : Push the current branch to whatever it is tracking"=
,
> [...]

I don't think "push.style" is an improvement. "style" sounds like it
affects all pushes. This configuration variable says what push should
do when no refspec is given and none are configured, so the word
"default" should be in there at least. Maybe "defaultref" would have
been better?

Some people may have started setting push.default already, so changing
the name may cause additional grief.

- Finn Arne
