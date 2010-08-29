From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 08/13] transport-helper: export should disconnect too
Date: Sun, 29 Aug 2010 15:32:07 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1008291529510.14365@iabervon.org>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com> <1283053540-27042-9-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Opnby-0004dY-EE
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab0H2TcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 15:32:09 -0400
Received: from iabervon.org ([66.92.72.58]:52256 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753785Ab0H2TcI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 15:32:08 -0400
Received: (qmail 3241 invoked by uid 1000); 29 Aug 2010 19:32:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Aug 2010 19:32:07 -0000
In-Reply-To: <1283053540-27042-9-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154705>

On Sat, 28 Aug 2010, Sverre Rabbelier wrote:

> Now that the remote helper protocol uses the new done command in its
> fast-import streams, export no longer needs to be the last command in
> the stream.
> ---
> 
>   The fact that we had this before shows how messed up the protocol
>   was earlier. Basically, any 'import' or 'export' command meant
>   "you're done talking to the helper now".

Yup; this is a big improvement, and I'dhave done it this way in the first 
place, had I realized how easy it would be to get fast-import to have a 
"done" command. Your subject is backwards, I think, though; export won't 
require a disconnect.

	-Daniel
*This .sig left intentionally blank*
