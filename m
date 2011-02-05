From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [idea] separate .git dir and the working tree
Date: Sat, 5 Feb 2011 07:27:08 -0600
Message-ID: <20110205132708.GA18391@elie>
References: <AANLkTik4MjnpOzPdGy7ZDiH0in4e1DpjrhQFOHjUiEEE@mail.gmail.com>
 <20110205032339.GA15303@mg1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: redstun <redstun@gmail.com>, Mike Gant <mike@gantsfort.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 14:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PliAm-0001VD-Kr
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 14:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab1BEN1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 08:27:15 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51140 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab1BEN1O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 08:27:14 -0500
Received: by iwn9 with SMTP id 9so3076418iwn.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0bTr5W8sOCtSgfJGypnYdNcJemlWrYhDgVFVMPTKiFE=;
        b=evtU6w1G/fiPbzfvLs3fcWgLvvehO0jZ+wSQ03r66gtabDauW7TrK3qxMpRLthtbOK
         vnrOJrzJGRoLVEkc4jEeO+hPP2EUeVfOCkoMzqrSA/iULQTqNp2vLkJPjg2o+C64R2wN
         4/ipGShNY7X/ZyU/ODVAHrESMCTmceCbhiC7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n/zZpMEu6Qlt+g28ZWtQRDM656HMrafpYOATQYXkmwrEC5X2g8HnFTkmNPl3NoK0G+
         7gokzt6cTKeyoFnGKZ2Ri/xZ+enFdFqLkgDSSHmwsnUzhz7QLYnSN8t8BAsxiMKC3fah
         pBz4WTdv/roKQcW84zr0oGd9dtcA5+vQ6vbRE=
Received: by 10.42.174.198 with SMTP id w6mr15831041icz.281.1296912433873;
        Sat, 05 Feb 2011 05:27:13 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id d13sm1480162ice.16.2011.02.05.05.27.12
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 05:27:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110205032339.GA15303@mg1>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166089>

(restoring cc list; please do not cull cc's)

Mike Gant wrote:
> On Sat, Feb 05, 2011 at 10:53:58AM +0800, redstun wrote:

>> I think separating the .git directory from its working tree could
>> increase the safety of the data to one more level higher.
[...]
> GIT_DIR and GIT_WORK_TREE might be what you are looking for. Explanation
> of usage in 'man git'

The .git directory is allowed to be a symlink.  Or a file like so

	gitdir: /path/to/git/repo

for symlink-challenged operating systems.  See gitrepository-layout(7)
for details.

Cheers,
Jonathan
