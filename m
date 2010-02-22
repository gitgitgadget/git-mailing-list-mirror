From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Mon, 22 Feb 2010 12:51:34 +0200
Message-ID: <20100222105133.GA10577@Knoppix>
References: <4B7D8358.1080108@gmail.com>
 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
 <4B7E3856.3080609@gmail.com>
 <20100219135549.GA31796@Knoppix>
 <4B820B4E.7050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:47:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjVt9-0003ft-AV
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0BVKvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:51:39 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45118 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab0BVKvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:51:38 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id C93DD18E608;
	Mon, 22 Feb 2010 12:51:36 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00351C5FBC; Mon, 22 Feb 2010 12:51:36 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id AF61241BEC;
	Mon, 22 Feb 2010 12:51:34 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4B820B4E.7050405@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140666>

On Sun, Feb 21, 2010 at 11:42:54PM -0500, Gabriel Filion wrote:
> On 2010-02-19 08:55, Ilari Liusvaara wrote:
 
> However, when I tried creating a git-remote-bzr+ssh link pointing to the
> git-remote-bzr script so that URLs like bzr+ssh://something/somewhere
> (this is how ssh is used with Bazaar) got handed down to the dummy
> script, it kept saying the "bzr+ssh" protocol wasn't handled. So, it
> would seem I can't have special characters in the helper script name.

Yeah, it seems like remote helper names can't have non-alphanum characters
(oops).

> How could I get this protocol to be handled by the remote helper? Having
> to type bzr::bzr+ssh://something/somewhere looks like a really awkward
> thing to write. Also, requiring users to add something to a protocol
> that already identifies the type of remote repository (and, that is
> already well known and used by users of bzr) is not interesting in a
> usability point of view.

bzr::ssh://something/somewhere ?

That goes to git-remote-bzr (as 'ssh://something/somewhere').

-Ilari
