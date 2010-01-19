From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Tue, 19 Jan 2010 20:37:36 +0200
Message-ID: <20100119183736.GA24204@Knoppix>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <201001191839.27090.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXIxX-0006gm-Kb
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 19:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab0ASShm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 13:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955Ab0ASShl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 13:37:41 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:57114 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab0ASShl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 13:37:41 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 4E15B18D5AE;
	Tue, 19 Jan 2010 20:37:39 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0382C3D083; Tue, 19 Jan 2010 20:37:39 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 2391427D9D;
	Tue, 19 Jan 2010 20:37:36 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <201001191839.27090.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137482>

On Tue, Jan 19, 2010 at 06:39:25PM +0100, Thomas Rast wrote:
> Ilari Liusvaara wrote:
> 
> Sorry for being so late to this discussion, but... wouldn't it be
> nicer to give it some globbing powers and the same semantics as
> 'fetch' lines?  That way spelling "all master branches of my remotes"
> and other such things would be easy.

Unfortunately doesn't seem to be easy to do, as push and fetch have
their own refspec logic. In fact, if matching power would be extended,
probably the easiest extension would be full-blown extended regular
expressions.

-Ilari
