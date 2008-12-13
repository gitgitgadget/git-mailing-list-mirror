From: Nix <nix@esperi.org.uk>
Subject: Re: is gitosis secure?
Date: Sat, 13 Dec 2008 16:23:49 +0000
Message-ID: <87hc58hwmi.fsf@hades.wkstn.nix>
References: <200812090956.48613.thomas@koch.ro>
	<bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Thomas Koch" <thomas@koch.ro>,
	"Git Mailing List" <git@vger.kernel.org>, dabe@ymc.ch
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sat Dec 13 18:26:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBYGM-0000BR-50
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 18:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbYLMRZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 12:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYLMRZH
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 12:25:07 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:55195 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYLMRZG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 12:25:06 -0500
X-Greylist: delayed 3666 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Dec 2008 12:25:06 EST
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id mBDGNpHd005393;
	Sat, 13 Dec 2008 16:23:51 GMT
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id mBDGNoJb019923;
	Sat, 13 Dec 2008 16:23:50 GMT
Emacs: if SIGINT doesn't work, try a tranquilizer.
In-Reply-To: <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> (Sverre Rabbelier's message of "Tue, 9 Dec 2008 10:38:50 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-CTc-dcc2-Metrics: hades 1031; Body=4 Fuz1=4 Fuz2=4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103006>

On 9 Dec 2008, Sverre Rabbelier spake thusly:

> On Tue, Dec 9, 2008 at 09:56, Thomas Koch <thomas@koch.ro> wrote:
>> Our admin would prefer to not open SSH at all outside our LAN, but
>> developers would need to have write access also outside the office.
>
> What safer to connect to the LAN than with SSH? What _would_ your
> system admin be happy with using?

telnet. I do not jest, this is our sysadmins' stated reasons for not
opening the git port and for tweaking their (mandatory) HTTP proxy to
block HTTP traffic from git.

(Telnet over some horrible impossibly slow buggy proprietary VPN.
It takes >5min to bring up a single connection.)

Do not underestimate the stupidity and hideboundedness of undertrained
system administrators, for it is vast.
