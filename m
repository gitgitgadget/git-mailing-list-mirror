From: Michael Witten <mfwitten@gmail.com>
Subject: Re: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 10:32:44 -0500
Message-ID: <b4087cc50904240832u6d0a17b2gaad406a0176da883@mail.gmail.com>
References: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
	 <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
	 <85647ef50904240828i76cf5f0en14a9fd2dc496a89d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNQ3-0005jP-Ku
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbZDXPcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbZDXPcq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:32:46 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:60668 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbZDXPcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:32:45 -0400
Received: by qyk16 with SMTP id 16so2323032qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jw0g33JWehMx7KGzEKhjtvmiG0moyrOJxVGnem5g6Nw=;
        b=QaY9xItzPAlo5AgxE3a5w9LUMMNJ59c55YZIIp4uY8Sl/QWYnAjQq11nav355fJ3Qi
         YeS6WKST1k/aSdWa0rdK5oTQYZ6zGjUizXPDtP4tJeMgenmVpgoNRc3KHdNh/+s4u15O
         U5G0rjRRoCtRMBpVbgN9Gsg4epROr4Lndyf40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=biVgfh2q9BLntzkOzgdgp7fRp5HmRdZzWWwrz6AzZ2lQJHFyjE85bXja9Lucy8FbFb
         E0evXZoNG+KsSAAK5Nd+tXwVfMShFpOZrDIiyt/SQajTgwywlePOK9MAeKUMYJjU2JHw
         3jVMv6adLKl1EsKifuqDs+GB5Dia6/QEX+Nkw=
Received: by 10.224.19.131 with SMTP id a3mr2967989qab.23.1240587164258; Fri, 
	24 Apr 2009 08:32:44 -0700 (PDT)
In-Reply-To: <85647ef50904240828i76cf5f0en14a9fd2dc496a89d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117458>

On Fri, Apr 24, 2009 at 10:28, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> This option works. Thank you.
>
> BTW why this option is not in the man page? Is it discouraged for use?

The option --subject-prefix is documented in format-patch's man page
(it is an option of format-patch, after all :-D).

However, using '--' with send-email to pass along arguments to a call
to format-patch is not documented in send-email's man page, and it
should be.
