From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Fri, 25 Jul 2008 10:53:54 -0400
Message-ID: <32541b130807250753j1071639ao9313a8acad9f4183@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <m3tzefvd3q.fsf@localhost.localdomain>
	 <fcaeb9bf0807240358l6584c063u85179196bd6db30a@mail.gmail.com>
	 <200807242201.23991.jnareb@gmail.com>
	 <fcaeb9bf0807241621y60b0341ej8f9f3b591ef12baf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 16:55:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMOh7-0002TK-6C
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 16:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYGYOx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbYGYOx5
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 10:53:57 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:19895 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbYGYOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 10:53:56 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1340513ywe.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZI3UjxTuQN/z0ohdXEg26bQ/4nK/UTQYSGdSz7cqYlE=;
        b=nwdARZsOkb+b5qwDJ/MyVwdhz7XTNIsoOSuO14yCUFngS7mUJI2JrVkpM/RQ1a1IXd
         /YKDo7HFBARpJ3CFCoQUPK8+h0gIxlPXaepoNbJaQ+1/vngP0cK3pipwVhx5DMEfiIje
         GSO6jrr4uCdUBBsaGadZlvnlkeRUDRbs/PMzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HMEWAA9DStbGrFqcDF5PGp/GzBK7G3LYvbnwWs2jjnUlaPjykuXXFrifdVhLYSCPnm
         Nu48aYMqqGW3/anoM7Y8bmcbppv//lYdo32iZiu0raOOBvO51EH27db4uo12eDc/82Vy
         ROtEKSEbc7fW3KR33DwD4Eud4B2GqYXKIETxs=
Received: by 10.114.201.1 with SMTP id y1mr2050238waf.93.1216997634587;
        Fri, 25 Jul 2008 07:53:54 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Fri, 25 Jul 2008 07:53:54 -0700 (PDT)
In-Reply-To: <fcaeb9bf0807241621y60b0341ej8f9f3b591ef12baf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90056>

On 7/24/08, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I wrote that with svn repos in mind. If those repos are to be
>  partially checked out, .svnignore would be in subdirectories rather
>  than at toplevel. Anyway that may not be true.

As far as I know, this is a misstatement of how svn works.  It uses
svn:ignore properties, not .svnignore files, and they don't apply
recursively, so this potential inconsistency wouldn't happen with svn.
 Of course, in the name of this consistency, svn gave up recursive
ignores.

So anyway, back on topic, the definition of a "well-organized
repository" is different wth git than with svn for this reason.  I
would certainly expect most well-organized git repositories to have a
toplevel .gitignore for the most common stuff.

Have fun,

Avery
