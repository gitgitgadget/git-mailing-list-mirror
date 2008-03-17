From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: submodule usage with links
Date: Mon, 17 Mar 2008 15:19:40 +0000
Message-ID: <320075ff0803170819p711e512cl30127a44f0543138@mail.gmail.com>
References: <320075ff0803170652i75041745v7825915f153fa577@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 16:21:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbH8n-0002ZP-Qy
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 16:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbYCQPTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbYCQPTm
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 11:19:42 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:54250 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbYCQPTl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 11:19:41 -0400
Received: by wf-out-1314.google.com with SMTP id 28so5478978wff.4
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fTto6bzolXhNSIch2YkIDhmHAjtHic/KNX85ir40vyc=;
        b=qEt/h8+vlmvRJ7KLs10vydmvYhlYlu+5zkV3wwwJrsgTPftnr6twFEG7+Luw00XSxuB9AS3PAmdtR4jNfdEuvK9PhW/rodzgRd7GMc7O02MDgfee2j/qKBdDmXDCppC8FWi+YccsSiUKyluCCHdJ34ctvG1OHWhqLnUeqez8Plc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c30upGCxyO44oTQFsA19+da1TIqnRBhfaeBLbMTsudEAMjDPhi97piC+AI2qTiBy/K9X6+DkvjbjVHQjD+uXadNGL0y0dp7MfmWFEAWSl26Ggvh0uCYmI3d9CDSDloBvoZo3w3E6NBjB5YxIo2RKr2znDNnzuEOeIKPULMogj/k=
Received: by 10.142.241.10 with SMTP id o10mr230452wfh.155.1205767180641;
        Mon, 17 Mar 2008 08:19:40 -0700 (PDT)
Received: by 10.66.243.3 with HTTP; Mon, 17 Mar 2008 08:19:40 -0700 (PDT)
In-Reply-To: <320075ff0803170652i75041745v7825915f153fa577@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77439>

Ok - turns out I was being optimistic, git understands symlinks and
notices a typechange.

Is there any support for doing this kind of thing? I have lots of
superprojects that all use the same
module - I'd like to not have to have them duplicated many times over
(It's ok that I'll have to reset the module
repository when changing between superproject)..


On Mon, Mar 17, 2008 at 1:52 PM, Nigel Magnay <nigel.magnay@gmail.com> wrote:
> Hi there
>
>  We use a lot of repo links that I'd like to use submodule support for.
>
>  Instead of doing
>  git submodule add ~/module/a
>  or even
>  git submodule add git://myhost/module/a
>
>  I'd like to share a, and do something like
>
>  <<add value to .gitmodules>>
>  ln -s a ../modules/a
>  ?? do something to add 'A' to the index as a 'subproject commit'
>  rather than a symlink ??
>
>  I'm stuck on the last bit - or is this not going to work?
>
