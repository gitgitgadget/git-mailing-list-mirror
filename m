From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Possible bug with `export-subst' attribute
Date: Sun, 25 Jul 2010 16:09:35 +0300
Message-ID: <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sun Jul 25 15:08:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0wg-0005To-NA
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 15:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446Ab0GYNIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 09:08:41 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:47384 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab0GYNIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 09:08:40 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 7EBE98C119;
	Sun, 25 Jul 2010 16:08:39 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A06EF461393; Sun, 25 Jul 2010 16:08:39 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id DF762158A65;
	Sun, 25 Jul 2010 16:08:36 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <19531.65276.394443.190317@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151741>

On Sun, Jul 25, 2010 at 05:08:12AM -0400, Eli Barzilay wrote:
> I have a file with:
> 
>   (define archive-id "$Format:%ct|%h|a$")
> 
> and an `export-subst' attribute -- and it looks like the "%h" results
> in a full sha1 instead of the abbreviated one when used with `git
> archive'.  This is with 1.7..2 -- I'm not sure, but I think that it
> worked fine with 1.7.1.
 
I remember seeing similar stuff. It isn't just archive, I also rember seeing
commit printing full hashes in that informational line it prints when it has
made the commit (IIRC, normally that hash is abbrevated).

-Ilari
