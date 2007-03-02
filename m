From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] add test for git-config --remove-section
Date: Fri, 02 Mar 2007 09:14:41 +0100
Message-ID: <45E7DCF1.9080602@gnu.org>
References: <es66vt$jej$1@sea.gmane.org> <81b0412b0703011351ldd903a8od2e4f76aded31519@mail.gmail.com> <Pine.LNX.4.63.0703012338370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 09:15:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN2v7-0006ZE-05
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 09:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbXCBIOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 03:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbXCBIOq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 03:14:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:63328 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbXCBIOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 03:14:45 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1200589nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 00:14:44 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=U1OMj8I0xi+e+G04bMrRYqYtR5sOhvO5IhAdCwYQFJ5Mh8joJ41oFK5ptxeYxsUMwjIBpRFK8S4UqfO8ciEDY4DbE+Accr/N0hXX4iFJBz63l3RUDOOk7oeW2R/Z5uO1gSUC3rkGufGLKX3O/QXODP2Cp1YRbFROt17MMxaij7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=CxceJ2m2jLGQ0SpSKRoedFxEMctI/JuOP8ZO0JoEDcH4D0SMxCP2a2hAICSQZz2Iu2FgQnS/QxsUBDfRE9ncYD6q+/MZFigmbqtgKYVa3a+iRPqamxfmtaY2lXY1G8L8hTpGQUxGZ+pIH9t3LSQQD5aWFlFE0nLAnGR9al/XzBc=
Received: by 10.49.54.3 with SMTP id g3mr7257718nfk.1172823284157;
        Fri, 02 Mar 2007 00:14:44 -0800 (PST)
Received: from ?192.168.68.211? ( [195.176.178.209])
        by mx.google.com with ESMTP id u9sm11159919muf.2007.03.02.00.14.42;
        Fri, 02 Mar 2007 00:14:43 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0703012338370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41165>

Johannes Schindelin wrote:
> This adds a simple test if a section is properly removed, even if the 
> section header is repeated in the config.
> 
> Not-yet-Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Waits-for-ack-by: Paolo Bonzini <bonzini@gnu.org>

Thanks!

Paolo
