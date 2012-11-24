From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Know how much to download before clonig
Date: Sat, 24 Nov 2012 10:10:21 -0800
Message-ID: <CAJo=hJvnDkbEW4u_c3xC9YUQwg=YCxLA2H+GGXTKm2fC61ooUg@mail.gmail.com>
References: <k8qd1l$l7o$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: arif <aftnix@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 19:11:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcKBx-0004zc-V1
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 19:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab2KXSKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 13:10:45 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38312 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab2KXSKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 13:10:42 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so6879365qcr.19
        for <git@vger.kernel.org>; Sat, 24 Nov 2012 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TTM+36WWgzmr+GbrMfIo5vX4CvgsqfyNgM7n8dI9YNw=;
        b=OQ6s+4WEHEMhmtfCe1n3VCxO6ZGXIQ+qaMm0yJsScf2X3uCPqa+u6TFku4O1SkRDbq
         piJ3pyFSAUfPP0gFQH/sHo6Th3Lj733vSFCtBr4qKw86ZpSNt21w+BIeav7rsqNQTelC
         XYDlWtdbwaJ4Q9WW/IFmpyGJMAEImk3mySXnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=TTM+36WWgzmr+GbrMfIo5vX4CvgsqfyNgM7n8dI9YNw=;
        b=l5qZoIbb0emUxhg77hGQUC8dv+GCl4KHkVCqsZcCqj0I2GKOMuom/L2qD2pjaAKBc8
         pasIHSael9Updwh8c8NrfLAHRmdAhz/SU8FfEouAMTEr7JjSdqgjemgc/FCnzMWSKbMB
         WP48hyFFisAGndnO/7LZHzQfaJXGc1t56VmRAwYDv6gLB2Jpzpe1wa6mjhGw+pPbsdpd
         pSpslk1yKNFxTphoHP43x//Fty1iOs6SjYYaH+31ormghEe778wnzfRVEWOvfajqlf93
         sBPrUjvWfTxV2jXQjmQsg1DQKPSlRttf5ButbVA1w0S83wZ4CIGgfIu1D1isHXYGP6pU
         Y0WQ==
Received: by 10.224.185.79 with SMTP id cn15mr7706713qab.14.1353780642001;
 Sat, 24 Nov 2012 10:10:42 -0800 (PST)
Received: by 10.49.60.198 with HTTP; Sat, 24 Nov 2012 10:10:21 -0800 (PST)
In-Reply-To: <k8qd1l$l7o$1@ger.gmane.org>
X-Gm-Message-State: ALoCoQkKGWP7+yVCt/URy8v0tvfKF3w+hpX2/MSi6NAd8IX13EkIhyA74UAyhHpEWjzOHZrXKtSi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210326>

On Sat, Nov 24, 2012 at 4:02 AM, arif <aftnix@gmail.com> wrote:
> Is there any way so that i can tell how much i have to download to
> obtain a full clone (not a shallow one) of a respository?

Ask the repository owner to tell you?

There is no information sent by the server about size of repository,
so no, you can't really know without having the repository owner tell
you through some other side channel.
