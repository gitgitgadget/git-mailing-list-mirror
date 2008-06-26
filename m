From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Windows symlinks
Date: Wed, 25 Jun 2008 23:50:19 -0400
Message-ID: <76718490806252050q372519bjcca1ca7637b48d97@mail.gmail.com>
References: <911589C97062424796D53B625CEC0025E4618F@USCOBRMFA-SE-70.northamerica.cexp.com>
	 <32541b130806241618p69f6167dycb09cdec1af8ba0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Patrick.Higgins@cexp.com" <Patrick.Higgins@cexp.com>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 05:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBiVx-00053I-Q3
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 05:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYFZDuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 23:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753629AbYFZDuV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 23:50:21 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:45130 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbYFZDuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 23:50:20 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1274732waf.23
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 20:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/iRvleRNNAwGY1Y3OhIYe+VFIhXGWGxfGeaTibZT3rA=;
        b=ilI1VlvnvUvpTjTxgov6GhfcXsqAETgMGH+yskPpDlrXaHoNC89hDlB5F9sKlgx9Zx
         sYq762343e/Saz+MNoDp+SoObp0GaLlvogajvBd1P0Y2qXS8WLN/ppTZTez++RKMUpGa
         OqiuEXBvMO3fGfY6rbpYtymIohjyMzBBaoid8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KzL/xoUKKRU39iEo114xSLM+Cf8BQmMkgC4rKMw32hg3G2UHuLOWgDZXVdwVoLbYsY
         26iyTb2fF5GUGVMj/PBm8DCfxiGErpYH2TSZlQNvzUijO0aiiA6L6iKozsWeBWeEQEVg
         5RZo+EUfuDf4IX5mcHsQZmp2hXrdLoQcKJeXA=
Received: by 10.114.181.6 with SMTP id d6mr6731094waf.50.1214452219424;
        Wed, 25 Jun 2008 20:50:19 -0700 (PDT)
Received: by 10.115.78.6 with HTTP; Wed, 25 Jun 2008 20:50:19 -0700 (PDT)
In-Reply-To: <32541b130806241618p69f6167dycb09cdec1af8ba0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86389>

On Tue, Jun 24, 2008 at 7:18 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> My understanding of Clearcase is that it actually loads a virtual
> filesystem driver in Windows and does all kinds of insane magic -

Just FYI, this is only the case if you're using so-called dynamic
views, which require the MVFS
driver, as you say. The OP said he was using snapshot views -- these
don't use MVFS and instead just checkout to the OS's native
filesystem.

j.
