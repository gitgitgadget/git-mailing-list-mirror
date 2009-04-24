From: Michael Witten <mfwitten@gmail.com>
Subject: Re: git send-email: How to modify subject prefix?
Date: Fri, 24 Apr 2009 10:20:05 -0500
Message-ID: <b4087cc50904240820r567020d7gaa7cecaa0f3b78fa@mail.gmail.com>
References: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 17:22:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxNEU-0000un-IH
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 17:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbZDXPUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 11:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbZDXPUJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 11:20:09 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:57344 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbZDXPUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 11:20:06 -0400
Received: by qyk16 with SMTP id 16so2308984qyk.33
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZgJgGFDvPPbWP+X3vMu5//AUY+mtNykb8P6OeCF2wTs=;
        b=CWNX/WA4fg0VI21jNiWdgkEsyE5VvIWQjO0EsOw+QoG6BXbS0Twt4z7DdBxzHnzOsG
         ewqDhCUtQ6b5ODmXRBCFvenDB8RepG9W8OwpoIP3DPw0MDZb2/swzJ7/ipuMlszY04WM
         o+TTs0ul875RZMz293juDGqJ1IMehEafKB1+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u4xMmVbb3TDfLm6MjElswhD2auV3DxImC+6bRGJEqYHnA+eetxPEFeK4pt5ZuTw1XY
         J/UPDec25tVzLZ2ncMnlBAkVvGswyDvTXYGWKK9tpYPdHBzcpRkL+Ew+2D0X1A6cTabj
         ycRMA9nwfeiuz2fDg0cwvI/cbusp0jHBvqeGY=
Received: by 10.224.37.19 with SMTP id v19mr2925564qad.70.1240586405662; Fri, 
	24 Apr 2009 08:20:05 -0700 (PDT)
In-Reply-To: <85647ef50904240818s41fffc2eh798083a24ab53750@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117452>

On Fri, Apr 24, 2009 at 10:18, Constantine Plotnikov
<constantine.plotnikov@gmail.com> wrote:
> I'm interested how to modify subject prefix when sending patches using
> git send-email. I want it to prefix the subject with [JGIT PATCH]
> instead of [PATCH] and I have not found any option that allows it.

The option is format-patch's --subject-prefix
