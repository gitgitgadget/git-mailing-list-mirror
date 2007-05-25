From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Don't allow newlines to occur in $Id:$ collapse
Date: Fri, 25 May 2007 14:50:53 +0100
Message-ID: <200705251451.00999.andyparkins@gmail.com>
References: <200705251412.06196.andyparkins@gmail.com> <200705251413.42389.andyparkins@gmail.com> <20070525132800.GH6667@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joshua N Pritikin <jpritikin@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 15:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HraCF-0004QS-Rv
	for gcvg-git@gmane.org; Fri, 25 May 2007 15:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXEYNvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 09:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbXEYNvI
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 09:51:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:54108 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbXEYNvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 09:51:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1124580ugf
        for <git@vger.kernel.org>; Fri, 25 May 2007 06:51:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n80mKWYzZF6FOKRQHJRQxi4uwAWX12AzceTSoOq9OsXTRq1qNXNbmxyH6r2I0gBRm6HriKDnRT3IWKGo3VlMmbG267S7FBXZgdsHNFCwGLv1jH6Pqs4anNSnFM16+9OgSeEY092UFJADHyS41Vd9Xu6qRC+TVhVOehMNzheP6L0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EmIm7b4VEVwxu9LTvEsWK9H0WPBYuFs+F7XIq3IVlnI1NlMRG3Flu5MJLrT2zBZmRypn+a1vuN0MMkD8VcltUgJQoEwv8e16Z1Kb3XEvFDAjEcJdboknAvZkbZWxdpdeMgG2udgWSt4whOXEyCFaKw9zkQhw1APySr5vI3m4iao=
Received: by 10.67.93.7 with SMTP id v7mr2957331ugl.1180101064769;
        Fri, 25 May 2007 06:51:04 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm5846768ika.2007.05.25.06.51.03;
        Fri, 25 May 2007 06:51:04 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <20070525132800.GH6667@always.joy.eth.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48375>

On Friday 2007 May 25, Joshua N Pritikin wrote:

> That's better but I would error out instead of silently ignoring it.
> Your choice.

We can't error out on checking a file out - that file is in the repository 
already, if it's got problems - so be it, it's got to be possible to check it 
out.

One could even argue that it's not actually an error, if we define keywords to 
be such that they are not allowed to contain newlines, then the fact that 
someone has written "$Id:" in their file, with no closing "$" just means that 
it's not a keyword; and like every other non-keyword bit of data in the file 
it should be left untouched.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
