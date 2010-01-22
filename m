From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCHv2] Make difftool.prompt fall back to mergetool.prompt
Date: Sat, 23 Jan 2010 00:31:21 +0100
Message-ID: <bdca99241001221531t24afc87cydf080f432cfbc51a@mail.gmail.com>
References: <4B59D414.4020507@gmail.com>
	 <7vr5pivx70.fsf@alter.siamese.dyndns.org>
	 <7B0478B5-CEE2-4207-8268-B0B338F88449@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 00:31:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYSyX-0005xH-A2
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 00:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab0AVXbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 18:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412Ab0AVXbY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 18:31:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:57969 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382Ab0AVXbW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 18:31:22 -0500
Received: by fg-out-1718.google.com with SMTP id 16so152877fgg.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 15:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=MdztnJlD7qBG3kXHyAB0G8A/iuxF0D3sQ6L86qcvpmQ=;
        b=ut83pr2xT6jiHkmRwRvlsH+rAahRRpAFO07LZRjz6DYILsr+HUAw0k2A+/5rzemOUC
         z6Z0DWmxAsorOSfovdeChUwLzif3RXj0cC65NYSuFckQLSmP2eIyuXAMoPkITtdc8xOI
         cA+xMUwpLBFBwyYFNGIpXPN2QtQFEP/5sfY5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bn7g8R+kJBlgZCkd4pwkNYydAaN8wqab8AxDZ2cbFUrNw2NFDoYY3s7RKdqBzvzgao
         oulQ105pMd8dZfX3g2kYeDBnn13/42sbVp2xGLMrtsqeEQ4V6xfTJqKS8UOJf5wPc4Hw
         wmKGGXo5ITz/dZZoljLxYE4sg5pGtLyhd7tOw=
Received: by 10.87.44.12 with SMTP id w12mr5784639fgj.74.1264203081329; Fri, 
	22 Jan 2010 15:31:21 -0800 (PST)
In-Reply-To: <7B0478B5-CEE2-4207-8268-B0B338F88449@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137786>

On Fri, Jan 22, 2010 at 22:24, David Aguilar <davvid@gmail.com> wrote:

> Sebastian, I you don't send a test I'll try to send one tonight.

I'd be glad if you could propose a testcase. Thanks.

-- 
Sebastian Schuberth
