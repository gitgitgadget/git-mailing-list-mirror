From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A Basic Git Question About File Tracking
Date: Mon, 3 Oct 2011 20:10:35 -0500
Message-ID: <20111004011035.GA13836@elie>
References: <j6dlhf$dp3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 03:10:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAtX8-0003Ku-EL
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 03:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab1JDBKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 21:10:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46940 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab1JDBKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 21:10:48 -0400
Received: by gyg10 with SMTP id 10so3994211gyg.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 18:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MmbeYQeMGLKba0Y3xttnUQuLMslrnvx6BhY6ARIa7UQ=;
        b=P8vi18OvdR5/vyfTwEyOJWEfbcLcJQMbwnX97H0X4GpExFDim/Mp6I+9/0J/ZUSI1p
         Ie/scHpanyRQlXG7GsKpwc3rFhEjNDpVSXaEBOayUayWKMDDpK97vFQtdrPINBYv7rUr
         dyiWvOmAhn+40vgo3HqYNsaKlSAiH4NEBQoSA=
Received: by 10.236.178.8 with SMTP id e8mr3339609yhm.39.1317690647502;
        Mon, 03 Oct 2011 18:10:47 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id o48sm17784487yhl.4.2011.10.03.18.10.46
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 18:10:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <j6dlhf$dp3$1@dough.gmane.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182720>

Hi!

Jon Forrest wrote:

> The Pro Git book says "Untracked basically means that Git sees a
> file you didn=E2=80=99t have in the previous snapshot (commit)".

Yep, that's a bug in the Pro Git book.  "Untracked" means "not in
the index", nothing more, nothing less.

I believe Scott takes patches[1]. :)

Hope that helps,
Jonathan

[1] https://github.com/progit/progit
