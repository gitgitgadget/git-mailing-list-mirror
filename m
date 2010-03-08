From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Git status shows modifications after cloning
Date: Mon, 8 Mar 2010 17:40:22 +0200
Message-ID: <20100308154021.GA27413@Knoppix>
References: <27821819.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 16:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nof4J-0005XR-Jv
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 16:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab0CHPk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 10:40:27 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41070 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab0CHPkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 10:40:25 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id C2C6818D3F9;
	Mon,  8 Mar 2010 17:40:24 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A040ACC0928; Mon, 08 Mar 2010 17:40:24 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id B728241BF1;
	Mon,  8 Mar 2010 17:40:22 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <27821819.post@talk.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141770>

On Mon, Mar 08, 2010 at 07:32:25AM -0800, jateeq wrote:
> 
> After cloning from a local repository, a git status shows me that each file
> in the repository has been modified - I don't want this to happen. I have
> searched around the net, and there is stuff about this happening if the
> configurations for the original and the clone are not the same, with
> specific mention of the variable core.autocrlf. However, this variable is
> unspecified in both repositories, and the differences in config files is
> listed below.

At least having core.autocrlf enabled and having CRLF files in repository
is known to cause problems like that. But reading the configuration, it doesn't
look this is Windows system (and the rest don't tend to have core.autocrlf
enabled).

The files in repository definitely should not have CRLF line endings (the
proper one is just LF).

-Ilari
