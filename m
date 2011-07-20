From: Peter Simons <simons@cryp.to>
Subject: [BUG] git-am and git-submodule rely on $PATH to find perl
Date: Thu, 21 Jul 2011 00:35:56 +0200
Organization: private
Message-ID: <87fwm0inqr.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 00:36:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjfNH-0003dE-4R
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab1GTWgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 18:36:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:44444 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab1GTWgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 18:36:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QjfN9-0003c5-G0
	for git@vger.kernel.org; Thu, 21 Jul 2011 00:36:07 +0200
Received: from brln-4dbc18a6.pool.mediaways.net ([77.188.24.166])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 00:36:07 +0200
Received: from simons by brln-4dbc18a6.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 00:36:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: brln-4dbc18a6.pool.mediaways.net
Cancel-Lock: sha1:oHlIN1VgfuctGAZc7OvrB8a4knQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177557>

Both scripts run perl without any path, i.e. they don't use the
$PERL_PATH that was passed at build time.
