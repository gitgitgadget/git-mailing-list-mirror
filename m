From: bill lam <cbill.lam@gmail.com>
Subject: how to split a hunk
Date: Wed, 28 Oct 2009 10:21:05 +0800
Message-ID: <20091028022105.GE3938@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 03:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2yA8-0007pr-8e
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 03:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757203AbZJ1CVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 22:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757162AbZJ1CVO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 22:21:14 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:49978 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757172AbZJ1CVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 22:21:13 -0400
Received: by gxk8 with SMTP id 8so386675gxk.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 19:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=q7on33QwI739+tJ5foWn/3Ca6wu+wyNUQu27ZJrXW5c=;
        b=eV6DlXcvHmxq24ykg0R6IZrtckSrCQ1vkdnEGmGp9BRGMBYwikQhC6/5caCe6Uy1+l
         UfSqdvOpgb66QHjZaJZ1VTUEmvVnTihUWhxain012nufWeWommNtSoRZTUYHQRTD37PO
         it6qAv39FBEexu0iZ8Yaccl2WBSuTQWsd6Cw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=xNW5tqcoegL0L9lTcFDDZLNmQSdsOuefPxhQfJTBB6EDTXth+Z5TclDnooeovNSdFb
         57uH7FTlLVdovCMPL0y1yRr4sIHglTsN8UcLe2fq3sDYTACayWYPDCOjtNVj5dkdz8dA
         yBrzKe+jjPhAyhDOwhiW1+UhhCFi+Hyx8+iXA=
Received: by 10.150.132.19 with SMTP id f19mr7872543ybd.83.1256696478373;
        Tue, 27 Oct 2009 19:21:18 -0700 (PDT)
Received: from localhost (n218103227169.netvigator.com [218.103.227.169])
        by mx.google.com with ESMTPS id 4sm222413ywg.58.2009.10.27.19.21.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 19:21:18 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131400>

There are occasions where diff of a file is

- aaaa
+ bbbb
+ cccc

I want to add lines bbbb and cccc as separated commits, but git-add -p
seem cannot further split this hunk.  Do I have no choice but to edit
it by hand and commit the bbbb and then edit the file to add back the
cccc?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
