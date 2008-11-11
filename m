From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: force a merge conflict
Date: Tue, 11 Nov 2008 12:24:03 -0500
Message-ID: <81bfc67a0811110924y5ff6a669kee5cb33c92c6046d@mail.gmail.com>
References: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
	 <85647ef50811110914w7e1d36afh23b43b44ba0e2cf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 18:25:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzwzO-0001ZQ-Io
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 18:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbYKKRYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 12:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbYKKRYF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 12:24:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:21674 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbYKKRYE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 12:24:04 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3146042rvb.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HfHATrC7EyHx9591ZW5yw+DgIcM9McaCc8ajnSjQgI0=;
        b=KQjFDULmvj/EymTYLyw3hjUGb/hlGBxZeEACq3xOok8uSOIOPS3kMceUpntIrvqk0F
         ETr/LCN4Pn9F7e7hvFcY3Am8a2kEuriGIzyu3KVDQVkBSgSEHmEnkz2JdvQCI1SzUFwq
         G4MyurLJKs/wTNXcjlJb8b+7equ+nZkY+wUSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eZx6+6yO9vZxfpZaiQMmMkJj2pYEUK0mlMkrpzt1Wl4/9E6cnNk40QbrqNLPnjkoSz
         t3+ncR5h/6taVvI9q0z2J/NMq91Wj5EtKqCLCLBouRMv2mw6TEc7hOjsyisiB1kPoIs2
         asOW9Bdpua0JN+3b+931plQwmkPg0q44fMUYU=
Received: by 10.140.147.5 with SMTP id u5mr4343410rvd.14.1226424243702;
        Tue, 11 Nov 2008 09:24:03 -0800 (PST)
Received: by 10.141.34.3 with HTTP; Tue, 11 Nov 2008 09:24:03 -0800 (PST)
In-Reply-To: <85647ef50811110914w7e1d36afh23b43b44ba0e2cf3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100657>

> Is not the following option of the merge just for it?
>
>  --no-commit
>     Perform the merge but pretend the merge failed and do not
>  autocommit, to give the user a chance to inspect and further tweak the
>  merge result before committing.

yes and no... it doesn't auto-magically allow me to do what  a merge
conflict does. which is put together a diff. all it really did was not
commit the auto merge.

as far as --no-ff I'm not saying it commits the same way but I didn't
see any difference in the resulting diffs, which, imho, all that
matters is whether the resulting merged code is correct.


-- 
Caleb Cushing
