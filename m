From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Wed, 29 Oct 2008 09:50:49 -0700
Message-ID: <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com>
	 <20081029164253.GA3172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 29 17:52:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvEH7-0001BR-3c
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 17:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbYJ2Quw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 12:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbYJ2Quw
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 12:50:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:53505 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbYJ2Quv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 12:50:51 -0400
Received: by ug-out-1314.google.com with SMTP id 39so669503ugf.37
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DwdI4eYqpalr9wy/romq0wPMcmnQX5j8DNRk1xZnpbo=;
        b=uP+2bUdg+XFMxkSu1+1WvNS8B6zB9+y51PEWSMVrTFcxnjNgowE/LKImyFIRvnot8Z
         Sf3EFUMcba9A3b3bZT9K5O4d4UXt3+/aWm6HhuWRz/QCPURw9cjtjsF7g+A+rKB5l9zS
         rdxfmZTCNv2+HKmGBB9BPzLJwGaKpWUPk4sP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FfHjWrfgHV7dpbvzehaedYSN7v8V+r4mZBerNGFEQIRWym8sY8NnqCqQgYtU9EIR3h
         51NN/PbE+pFQho8zciiwaPfc9DvS1coZ+ue1aR1jmKVyvzUOIJlXpDRpA/bmIE3wg1kj
         kUb1uT4VG173Cdin4QMX/dD2Hf4XsSoDRl/9o=
Received: by 10.210.34.2 with SMTP id h2mr1267255ebh.82.1225299049664;
        Wed, 29 Oct 2008 09:50:49 -0700 (PDT)
Received: by 10.210.51.7 with HTTP; Wed, 29 Oct 2008 09:50:49 -0700 (PDT)
In-Reply-To: <20081029164253.GA3172@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99380>

On Wed, Oct 29, 2008 at 9:42 AM, Jeff King <peff@peff.net> wrote:

> Hmm. I wonder if it would make it more sense to make the "official" name
> --staged, and leave --cached forever as a synonym. If the goal is giving
> sane names to end users, then we should probably advertise the sane
> ones.

I agree. If there's some consensus, I can make that shift, keeping
--cached as a backward-compatibility synonym.


Dave.
