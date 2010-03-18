From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 09:48:57 -0400
Message-ID: <9e4733911003180648w74f48194w1d75b0d58a309f1e@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 14:49:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsG6L-0004Cl-8G
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 14:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0CRNtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 09:49:17 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:47350 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660Ab0CRNs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 09:48:59 -0400
Received: by qw-out-2122.google.com with SMTP id 8so355844qwh.37
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YXsxIuKO1PAPj71HINOHO6QLO/u9wvt/Vrv3vrAmfz0=;
        b=QsOt5pYcHg+B8pexQD0vJlp4s7SgFWej8yG0g32NSg0IbFgWj+SinwxvjkppYFfEIR
         VipdFT4HAYw8YDz5sOaQYQnB1Vt94rt3ZvZH7++7Z5dsGDmw/cDGjSiKP4fJ4Xj4J2/C
         5P/0nyyB1Ud0o27+ZbhCUgU4B/ghF8Zou4wCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wlpXUNAcJ8DqSJXnoRumK0OrrTsS8YkTMoitWaZ28oRtUGblmHa8adD5BzE5BjxnRy
         bbqmjWx3GzMfpVRSpq2apfoKOyaaSQOSQrWxovQwB2bqpc4I6A48p+11itkh+GA6/sHk
         pDvGTFAAeQdQJj4aNhfFe1xMF7a8WNu+oHPlU=
Received: by 10.229.223.140 with SMTP id ik12mr2180008qcb.98.1268920137569; 
	Thu, 18 Mar 2010 06:48:57 -0700 (PDT)
In-Reply-To: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142469>

You can't go back and edit the history in git so a map of the aliases
is needed.  The easy fix is a .mailmap file. However, the .mailmap
entries need a mechanism to track which entries are correct and which
have been fixed. Read this long and painful thread...
http://lkml.org/lkml/2008/7/28/134

-- 
Jon Smirl
jonsmirl@gmail.com
