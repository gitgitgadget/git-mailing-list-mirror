From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: How to ignore a modified file?
Date: Thu, 5 Mar 2009 09:50:37 +0100
Message-ID: <fabb9a1e0903050050r322f1c54q8fd704cecc126115@mail.gmail.com>
References: <1236242659559-2428157.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dealmaker <vinkhc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 09:52:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9JS-0007lI-RH
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 09:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbZCEIum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 03:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753521AbZCEIum
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 03:50:42 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:52169 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbZCEIul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 03:50:41 -0500
Received: by fxm24 with SMTP id 24so3237382fxm.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 00:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FEMHL7m379bu7MWIEWCMwSpXUb3c2lFW++YyrzhCwPc=;
        b=W3R9qh9J2OMdqKYRcEQibDK6jOP4YG/niGYsiVGgQqv7HJft10+QrAcybkITJDCP3d
         fG5PbbtQ+P97QpUxW0mkpl0VlvZe3zsEIRuIEwqyjFtcOKFXCJufsdJxWdlS7Sni1Fbc
         ozXlOWQS3gDDu33CyUTUlZc+zb9w9ULQWH5Xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pvHHLCbjpXYVoiFpW1ZpmcIVUGpEagOqHyc4iRaBLrfGNk/v+RWKQN3wOagHSyI5W6
         cSqgcPFxJ9sL0NL5QazaLb3Pil21pr5o3woD2zwnqDcHQCxg+u3KmYdqb3/Dsx/pQFZ4
         ts4JYIb/s1A9DYuulh1goyI8rJEGDZ76srmww=
Received: by 10.103.117.9 with SMTP id u9mr420773mum.55.1236243037270; Thu, 05 
	Mar 2009 00:50:37 -0800 (PST)
In-Reply-To: <1236242659559-2428157.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112268>

Heya,

On Thu, Mar 5, 2009 at 09:44, dealmaker <vinkhc@gmail.com> wrote:
> [...] How do I ignore [a tracked] directory?

$ git rm -rf --cached dirname && git commit -m "Removed directory from git"

Git will tell you about changes to the contents of the directory until
you stop tracking it. --cached will prevent the folder from actually
being removed from your harddisk.

-- 
Cheers,

Sverre Rabbelier
