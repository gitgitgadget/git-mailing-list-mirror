From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Mon, 8 Nov 2010 11:24:21 -0600
Message-ID: <20101108172421.GB3619@burratino>
References: <1289212979-64246-1-git-send-email-lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Nov 08 18:24:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFVSU-0005Mg-Db
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 18:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab0KHRYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 12:24:37 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36694 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab0KHRYh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 12:24:37 -0500
Received: by pzk28 with SMTP id 28so972899pzk.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 09:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UsuH5S6KWiomfTN7VsYZTgedrfgCmVzYYuSze2CfC0E=;
        b=EQBBc/pF2nBTH4HRo/q2vQOUewIAR88mtsB3zFXUiN2VawV2rMAm/fiPeT1mAIzo3i
         GlafPk2F7c+vEx+3LOF3E93GQlc1JJRtImKr4LdawUFD4Vt+FtSg+cqz782T1SjjVQTQ
         SPIJlI3pt6G4XS7CYl/lR0L1N4IzLnfqVNIVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lsAoVIm4cQz5jgQSEagESmWrLnQQWoZTcSFFWkSTrcrFRxpsl/qI4O7VCFGxg1+9L3
         Sea2Zo9V02NyMrzRnIAA1LxILMG2s02Vzdi9s9OKx3htfbQ6DxCVAE+HCgyZ9wafJFTy
         ds9nmBm45U/L71nJITgFnOpfOdXn97DgvqZzc=
Received: by 10.229.224.136 with SMTP id io8mr5361775qcb.88.1289237076087;
        Mon, 08 Nov 2010 09:24:36 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id k15sm109538qcu.23.2010.11.08.09.24.34
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 09:24:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289212979-64246-1-git-send-email-lists@haller-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160948>

Stefan Haller wrote:

> Sometimes it's desirable to see what changes were introduced by a
> merge commit, rather than how conflicts were resolved. This adds
> a checkbox which, when turned on, makes gitk show the equivalent
> of "git show --first-parent <commit>" for merge commits.

To be clear: this is a diff option (like -m but limited to one
parent), not a history traversal option, right?

> I realize this conflicts with Thomas Rast's recent patch to
> add a word-diff dropdown box; things are fighting for space
> in the diff pane header...

Any ideas for addressing the space shortage?
