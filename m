From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RESEND] Pagination for gitweb
Date: Sun, 12 Sep 2010 21:40:10 +0200
Message-ID: <201009122140.10926.jnareb@gmail.com>
References: <1284135442-10971-1-git-send-email-lkundrak@v3.sk> <m34odxmnpj.fsf@localhost.localdomain> <4C8A816E.4090305@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sun Sep 12 21:40:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OusPZ-0002IE-Tw
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab0ILTkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 15:40:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44726 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab0ILTkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 15:40:19 -0400
Received: by bwz11 with SMTP id 11so3951207bwz.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=AwuE9RjgZ2DyNTAbCt1ByfJEAkjGp+dSygAzfXXFduQ=;
        b=IQZViCISCks8sciukS7izfFsZbVIMPn73r7056xgSeTrmrFJ9ZPOQTbA7IRXU6rQA2
         9QywE/n7XFvgrTM2YyPAwx96xcKdri4OjShuYvdLgZF+fx7NPTi7zT+0g0TUcck925IB
         qgMlDV0/ysRIFf8Q7Vn3P1ODWSzlWJJigispw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xVqeCTXa6fAVJrQcZgwp9JBmitIrFt5g4DoCJfOANaD4WcF1B75ibPASJm/AEhVRl7
         /LVHys+PY6yRvO8Y1ZjyzczoDw3WZr8Yz3zMlUrlycdBjnRwKiU6tnhG2cU4DKnHuI6n
         UxGAlgPZL2QA0na6b/+3Fj+VJ+kWLa1MEm1fA=
Received: by 10.204.56.143 with SMTP id y15mr2343024bkg.198.1284320418209;
        Sun, 12 Sep 2010 12:40:18 -0700 (PDT)
Received: from [192.168.1.13] (abwi198.neoplus.adsl.tpnet.pl [83.8.232.198])
        by mx.google.com with ESMTPS id f10sm3945401bkl.17.2010.09.12.12.40.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Sep 2010 12:40:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C8A816E.4090305@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156045>

On Fri, 10 Sep 2010, J.H. wrote:
> On 09/10/2010 11:57 AM, Jakub Narebski wrote:
 
> > Is the problem server performance for large number of projects?  If
> > this is the problem, perhaps better solution would be to use caching
> > (work in progress).
> 
> They already moved to using my caching layer, mainly because I could
> create an RPM for them and the fact that my caching code is slightly
> more battle tested.

Is this RPM site-specific, or generic one?  Could you share *.spec file?
Or do you use git.spec from git, just use patched gitweb?
-- 
Jakub Narebski
Poland
