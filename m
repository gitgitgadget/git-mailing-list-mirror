From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 1 Apr 2007 08:42:50 +0100
Message-ID: <200704010842.53042.andyparkins@gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx> <Pine.LNX.4.64.0703111326170.9690@woody.linux-foundation.org> <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthias Lederhofer <matled@gmx.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 01 09:45:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXul5-0008KO-IY
	for gcvg-git@gmane.org; Sun, 01 Apr 2007 09:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbXDAHpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Apr 2007 03:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbXDAHpq
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Apr 2007 03:45:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:4988 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179AbXDAHpq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Apr 2007 03:45:46 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1236606uga
        for <git@vger.kernel.org>; Sun, 01 Apr 2007 00:45:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZxGXQdSlkZhqXl/3TPA5aTvHO8TYb5twC9frbDtRiGE+BU7bt+2XMdZb2GgQP43k1aorz7guS+2TCOFH8+ShKOp4/jObOq6XmRdkwnuplsulj02VX3q4PyY1lSBaH5DJjCMUTcPa7f8Gtk403XEokXAuPD0uZ90SPmHU02dhR98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jgOcDKZ7F9O0IdINP6jfqT+tNvIhEe7erczlKZXU9o5HQqb8bBl5B1rYWrvSVfo9y1u5niqcEc6wGMPnrMN183neY9+slerSO18ML8S/rryIVK9uY9YQ5Yw4zHv7WEgYuFMcrFwAt8lXimlOfPehMvwniF0jrw92H1ocBQCdSik=
Received: by 10.67.117.18 with SMTP id u18mr3533462ugm.1175413544435;
        Sun, 01 Apr 2007 00:45:44 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id 53sm5427069ugn.2007.04.01.00.45.42;
        Sun, 01 Apr 2007 00:45:43 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43583>

On Sunday 2007, March 11, Junio C Hamano wrote:

> That is a good example usage schenario; we would need to think
> about what to do with .gitignore (and .gitattributes if we will
> have that in-tree), though.

While it's not solveable yet; if git gets gitattributes support, then 
it's easy.  As long as there is a way of specifying attributes in the 
config (which I'm sure there will be), in the music repository you 
would have (syntax being made up on the spot)

[attribute "gitattributesfile"]
  path = .gitattribute-music
[attribute "gitignorefile"]
  path = .gitignore-music

Then in the config repository:

[attribute "gitattributesfile"]
  path = .gitattribute-config
[attribute "gitignorefile"]
  path = .gitignore-config



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
