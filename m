From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Mon, 2 Oct 2006 12:56:34 +0200
Message-ID: <200610021256.35236.jnareb@gmail.com>
References: <efc2no$eti$2@sea.gmane.org> <200610012127.37113.jnareb@gmail.com> <4520BC84.5090800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 12:56:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GULTB-0006eS-T4
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 12:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWJBK4R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 06:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJBK4Q
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 06:56:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:56387 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750784AbWJBK4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 06:56:16 -0400
Received: by ug-out-1314.google.com with SMTP id o38so487994ugd
        for <git@vger.kernel.org>; Mon, 02 Oct 2006 03:56:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=byFwIdTBwq5dXLN7InhbmAOvg+LOcPOAOfislPNCLI2uoU+Qi719Z2FeZPZ077QYnqXU79kfBTmkSmNchRI45P9uGGrTSSEjV3YStmRmrVvLDElfS6ZtzXiQxcGOmU3dAa+FV2Fde3rygsYSpIuwA3+XsbaAMSBr8NgO1WV5rg8=
Received: by 10.67.93.6 with SMTP id v6mr2690270ugl;
        Mon, 02 Oct 2006 03:56:14 -0700 (PDT)
Received: from host-81-190-17-45.torun.mm.pl ( [81.190.17.45])
        by mx.gmail.com with ESMTP id w40sm4610033ugc.2006.10.02.03.56.14;
        Mon, 02 Oct 2006 03:56:14 -0700 (PDT)
To: Andreas Ericsson <ae@op5.se>
User-Agent: KMail/1.9.3
In-Reply-To: <4520BC84.5090800@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28224>

Andreas Ericsson wrote:
> Jakub Narebski wrote:
>> Junio C Hamano wrote:
>> 
>>> Doesn't leading drwxr-xr-x mean anything?
>> 
>> Neither d in drwxr-xr-x, nor trailing / in the name are significant
>> enough indicators of directory vs file (tree vs blob) indicator,
>> especially that by default git-ls-tree output mixes trees with blobs.
>>  
> 
> I beg to differ. The trailing slash would indeed help, as peoples eyes 
> are generally focused on the mouse-pointer rather than some 5-10" to the 
> left of it. If we're worrying that windows folks use \ for 
> path-delimiter, I think they'll pick up the difference quick enough.

I agree that it would help, but it is not enough when tree (directory)
and blob (file) would have the same color and the same decoration.

-- 
Jakub Narebski
Poland
