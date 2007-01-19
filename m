From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-cvsserver won't add new content on update
Date: Fri, 19 Jan 2007 07:21:43 +0000
Message-ID: <200701190721.44891.andyparkins@gmail.com>
References: <200701181616.38318.andyparkins@gmail.com> <20070118162222.GE15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 19 08:24:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7o7C-0004xH-8L
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 08:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbXASHYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 02:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbXASHYe
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 02:24:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:28116 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964865AbXASHYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 02:24:33 -0500
Received: by ug-out-1314.google.com with SMTP id 44so387967uga
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 23:24:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MgXedHyuEpNydVsASNZa2I3iPOV6f4DmdNG04XBVA+skJQqEgphbne/Nio3uRBlQG6DEEoPlbKgYECfpLNRUps+DQfJ6rClben29p+OiLSx7jn8VQWp0YPrqapoeMUX6Lm06//+Cm8ABH+mHXvWPV1ICbpHKvydV4TmCu7WmT+w=
Received: by 10.67.92.1 with SMTP id u1mr2585211ugl.1169191472018;
        Thu, 18 Jan 2007 23:24:32 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164])
        by mx.google.com with ESMTP id s1sm1807904uge.2007.01.18.23.24.31;
        Thu, 18 Jan 2007 23:24:31 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <20070118162222.GE15428@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37154>

On Thursday 2007, January 18 16:22, Shawn O. Pearce wrote:

> You need to commit first to get the file completely added.
> What you are seeing above is that the file was listed in
> some/sub/directory/CVS/Entries so that the next commit will
> know to upload the file to the server.  Until then its not
> actually going to do that...

I've mislead you.  The file was added in the git repository.  It got there 
fine; it's therefore not in the Entries file.  I'm merely trying to get the 
file to appear in the CVS sandbox.



Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
