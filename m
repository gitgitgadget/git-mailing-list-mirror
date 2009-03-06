From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: Gitk - Seeing just a specific remote ?
Date: Fri, 6 Mar 2009 11:28:11 +0530
Message-ID: <f662f0210903052158q77aa0f2fo92c4f4a09c13780e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 06:59:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfT5y-0003Vb-T3
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 06:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbZCFF6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 00:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbZCFF6O
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 00:58:14 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:26030 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZCFF6N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 00:58:13 -0500
Received: by rv-out-0506.google.com with SMTP id g37so334978rvb.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 21:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=R95t0mJt7k+mJKfsFLiXBRjTh+TVt+rnJH7v6gAVAZU=;
        b=GkY8KgZKsaAaLWdYMAbTVZ2si7bUkugFNiSXALMz/NYbzLr1LdVAzfUKtD/DC2cSuY
         2BLihd0L6dgPDBG2OKOqlu7fkephQAFSOfft94LKXlolT98lemzUlmZ1Jr/6wkD76Fyf
         nzSXDBXja1XE5ixU9Sk3Dm2fLXLIPTYAQLljo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=atlNRq/m+tMc8omAaomGfNTX+zVrfHLs1SGYecHBLDiQD9WEHIIjYL2m3WcYvobRtG
         RtPYWIJG5/M7CA2qdnwAsdccA9W+XUNrmaHXJrYBw4+iNUOQS3wWhOgrexZauk3EX22l
         Kr6SkYdKRGGBQx+OkCBjHbK1hh1PS4XKeXgHc=
Received: by 10.141.52.6 with SMTP id e6mr141036rvk.133.1236319091102; Thu, 05 
	Mar 2009 21:58:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112389>

Hi All,

I have a git repository (say, new_develop) in which a remote
repository (say old_develop) is also there of some older work with the
associated remote branches. Is there a way to see all  the branches of
only this remote older_develop repository graphically in gitk -
something that shows me the same thing that doing a 'gitk --all' would
have shown had I done it from the older_develop repository itself ? If
I say 'gitk --all' (in new_develop) it shows me all the branches
(local as well as remote). Specifying 'gitk --remotes' also shows all
the remote branches (not just from the old_develop remote repo) ? Is
there some other way that I am missing ? I have seen the man page of
git-rev-list too but there doesn't sem to be a way to do it.

Regards,
Aneesh
