From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/7] remote-helpers: add support for an export command
Date: Mon, 29 Mar 2010 13:21:45 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1003291256020.14365@iabervon.org>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com> <1269881309-19690-6-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 19:21:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwIeu-0000ZH-Tu
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 19:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0C2RVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 13:21:48 -0400
Received: from iabervon.org ([66.92.72.58]:54392 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755151Ab0C2RVr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 13:21:47 -0400
Received: (qmail 7649 invoked by uid 1000); 29 Mar 2010 17:21:45 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Mar 2010 17:21:45 -0000
In-Reply-To: <1269881309-19690-6-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143502>

On Mon, 29 Mar 2010, Sverre Rabbelier wrote:

> ---
> 
> 	This complements the 'import' capability, making it possible
> 	to use remote-helpers with only fast-import/fast-exports
> 	streams.

It would be good to have documentation on what the helper should do doing 
here; it's relatively difficult to tell from this code.

I think that it's getting some options (import and export marks) back from 
the helper in a kind of ad-hoc and unclear fashion, and it should be doing 
something more appropriate. (I'm not sure what the more appropriate thing 
is, or really what the requirements are here as far as getting information 
around, but I think it needs to be discussed.)

	-Daniel
*This .sig left intentionally blank*
